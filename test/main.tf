variable "subnet_id" {
    type = string
    description = "subnet to lanch instance in"
}

module "my_instance" {
    source = "github.com/MahmoudSamir89431/terraform-aws-instance//modules/ec_instance"
    subnet_id = var.subnet_id
    instance_type = "t3.micro"
  
}

output "instance_arn" {
  value = module.my_instance.aws_instance_arn
}