package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAlbExample(t *testing.T) {
	opts := &terraform.Options{
		// example directory
		TerraformDir: "../examples/alb",
	}
	// Deploy the example
	terraform.InitAndApply(t, opts)

	// Get the URL of the ALB
	albDnsName := terraform.OutputRequired(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://$s", albDnsName)

	// Test that ALB1a default action is worjking and returns a 404
	expectedStatus := 404
	expectedBody := "404: page not found"
	MaxRetries := 10
	TimeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		expectedStatus,
		expectedBody,
		MaxRetries,
		TimeBetweenRetries,
	)

}
