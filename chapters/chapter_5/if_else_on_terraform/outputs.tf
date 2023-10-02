#uses ternary to access the return of the if else statement
output "neo_cloudwatch_policy_arn" {
  value = (
    var.give_neo_cloudwatch_full_access
    ? aws_iam_user_policy_attachment.cloudwatch_full_access[0].policy_arn
    : aws_iam_user_policy_attachment.cloudwatch_read_only[0].policy_arn
  )
}
