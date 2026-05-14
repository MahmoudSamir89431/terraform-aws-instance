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

resource "aws_instance" "hello_world" {
    count               = var.instance_count
    ami                 = data.aws_ami.ubuntu.id
    subnet_id           = var.subnet_id
    instance_type       = var.instance_type

    tags = merge(var.tags, {
        Name = "${var.name_prefix}-instance"
    })
}