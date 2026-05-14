variable "instance_type" {
    type              = string
    description       = "the type of instance to launch"
    default           = "t3.micro"
}

variable "subnet_id" {
    type              = string
    description       = "The ID of the subnet to launch the instance to"

    validation {
      condition       = length(regexall("^subnet-[\\d|\\w]+$", var.subnet_id)) == 1
      error_message   = "The subnet_id must match the pattern ^subnet-[\\d|\\w]+$"
    } 
}

