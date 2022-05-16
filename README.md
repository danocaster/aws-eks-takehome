To deploy this EKS instance:

Log in to AWS with awscli

`terraform init`
`terraform apply --var-file=dev.tfvars -target aws_iam_policy.load_balancer_controller`
`terraform apply --var-file=dev.tfvars`