variable "name_prefix" {
    type        = string
    description = "The prefix to apply at the begining of names genreted by this module"
}

variable "tags" {
    type = map(string)
    description = "Key/value pairs to pass to AWS as Tags"
    default     = {}
  
}

variable "instance_count" {
    type        = number
    description = "The number of instances to launch"
    default     = 0
    validation {
      condition = can(parseint(tostring(var.my_integer), 10))
      error_message = "The instant count must be whole number."
    }
    validation {
      condition = var.instance_count >=0
      error_message = "The instant count can't be negative."
    }
  
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
    statement {
      actions = ["sts:AssumeRole"]

      principals {
        type = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
    }
}
resource "aws_iam_role" "main" {
    name               = "${var.name_prefix}-instance-role"
    assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}
resource "aws_iam_instance_profile" "main" {
    name = aws_iam_role.main.name
    role = aws_iam_role.main.name
  
}
resource "aws_instance" "hello_world" {
    count                = var.instance_count
    ami                  = data.aws_ami.ubuntu.id
    subnet_id            = var.subnet_id
    instance_type        = var.instance_type
    iam_instance_profile = aws_iam_instance_profile.main.name

    tags = merge(var.tags, {
        Name = "${var.name_prefix}-instance"
    })
}