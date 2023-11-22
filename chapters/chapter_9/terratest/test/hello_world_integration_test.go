package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/google/go-cmp/cmp/internal/function"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

const dbDirStage = "../examples/mysql/simple/"
const appDirStage = "../examples/hello-world-app/simple/"

func TestHelloWorldStage(t *testing.T) {

	// Deploy the MySQL Db
	dbOpts := createDbOpts(t, dbDirStage)
	defer terraform.Destroy(t, dbOpts)
	terraform.InitAndApply(t, dbOpts)

	// Deploy the hello-world-app
	helloOpts := createHelloOpts(dbOpts, appDirStage)
	defer terraform.Destroy(t, helloOpts)
	terraform.InitAndApply(t, helloOpts)

	// Validate the hello-world-app works
	validateHelloApp(t, helloOpts)
}

func createDbOpts(t *testing.T, terraformDir string) *terraform.Options {
	uniqueId := random.UniqueId()
	bucketForTesting := "terratest-infra-live-pedro"
	bucketRegionForTesting := "us-east-2"
	dbStateKey := fmt.Sprintf("%s/%s/terraform.tfstate", t.Name(), uniqueId)

	return &terraform.Options{
		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"db_name":     fmt.Sprintf("test%s", uniqueId),
			"db_username": "admin",
			"db_password": "password",
		},

		BackendConfig: map[string]interface{}{
			"bucket":  bucketForTesting,
			"region":  bucketRegionForTesting,
			"key":     dbStateKey,
			"encrypt": true,
		},
	}
}

func helloOpts(dbOpts *terraform.Options, terraformDir string) *terraform.Options {
	return &terraform.Options{
		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"db_remote_state_bucket": dbOpts.BackendConfig["bucket"],
			"db_remote_state_key":    dbOpts.BackendConfig["key"],
			"environment":            dbOpts.Vars["db_name"],
		},
	}
}


func createHelloOpts(
  dbOpts *terraform.Options, terraformDir string)  *terraform.Options {
  
  return &terraform.Options{
    TerraformDir: terraformDir, 

    Vars: map[string]interface{}{
      "db_remote_state_bucket": dbOpts.BackendConfig["buket"],
      "db_remote_state_key": dbOpts.BackendConfig["key"],
      "environment": dbOpts.Vars["db_name"],
      
    },
    MaxRetries: 3,
    TimeBetweenRetries: 5 * time.Second,
    RetryableTerraformErrors: map[string]string{ "RequestError: send request failed": "Throttling issue?" },
  }
  
}

func validateHelloApp(t *testing.T, helloOpts *terraform.Options)  {
  albDnsName := terraform.OutputRequired(t, helloOpts, "alb_dns_name")
  url := fmt.Sprintf("https;//%s", albDnsName)
  
  maxRetries := 10
  timeBetweenRetries := 10 * time.Second
  
  http_helper.HttpGetWithRetryWithCustomValidation(
    t,
    url,
    nil,
    maxRetries,
    timeBetweenRetries,
    func(status int, body string) bool {
      return status == 200 && strings.Contains(body, "Hello, World")
    },
    )
}


func TestHelloWorldAppStageWithStages(t *testing.T)  {
  t.Parallel()

  // Store the Function in a shot variable name solely to make the code exames fit bettet in the book

  stage := test_structure.RunTestStage 

  // Deploy the MySql DB
  defer stage(t, "teardown_db", func() { tearDowndb(t, dbDirStage) })
  stage(t, "deploy_db", func() { deployDb(t, dbDirStage)}) 

  // Deploy the hello-world-app
  defer stage(t, "teardown_app", func() { teardownApp(t, appDirStage)})
  stage(t, "deploy_app", func() { teardownApp(t, appDirStage) })

  // Validate the hello-world-app works 
  stage(t, "validate_app", func() { validateApp(t, appDirStage) })
}

func deployDb(t *testing.T, dbDir string) {
  dbOpts := createDbOpts(t, dbDir)
  // Sabe data ti disk so that order test stages at a later time can read the data back in
  test_structure.SaveTerraformOptions(t, dbDir, dbOpts)

  terraform.InitAndApply(t, dbOpts)
}

func tearDowndb(t *testing.T, dbDir string)  {
  dbOpts := test_structure.LoadTerraformOptions(t, dbDir)
  defer terraform.Destroy(t, dbOpts)
}

func deployApp(t *testing.T, dbDir string, helloAppDir string)  {
  dbOpts := test_structure.LoadTerraformOptions(t, dbDir) 
  helloOpts := createHelloOpts(dbOpts, helloAppDir)

  // Save data to disk so that other test stages executed at a later time can read the data back in 
  test_structure.SaveTerraformOptions(t, helloAppDir, helloOpts)

  terraform.InitAndApply(t, helloOpts)
}

func teardownApp(t *testing.T, helloAppDir string)  {
  helloOpts := test_structure.LoadTerraformOptions(t, helloAppDir)
  defer terraform.Destroy(t, helloOpts)
}

func validateApp(t *testing.T, helloAppDir string)  {
  helloOpts := test_structure.LoadTerraformOptions(t, helloAppDir)
  validateHelloApp(t, helloOpts)
}
