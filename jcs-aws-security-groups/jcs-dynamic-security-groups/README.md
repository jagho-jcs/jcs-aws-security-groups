# Dynamic Security Group rules JCS 

Configuration in this directory creates sets of Security Groups and Security Group Rules resources in various combinations.

Data sources are used to discover existing VPC resources (VPC and default security group).

## Usage

To run this you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply -var-file=<file>
```

Note that this example may create resources which may be charged. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this\_security\_group\_description | The description of the security group |
| this\_security\_group\_id | The ID of the security group |
| this\_security\_group\_name | The name of the security group |
| this\_security\_group\_owner\_id | The owner ID |
| this\_security\_group\_vpc\_id | The VPC ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
