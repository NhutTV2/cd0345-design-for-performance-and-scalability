terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 3.27"
      }
    }
    
  required_version = ">= 0.12"
}


# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
    access_key = "ASIAW77OL5TZ36DQLVFZ"
    secret_key = "FiJg7Im8OpneDV0NfAZ48FoG9UR2BTlTvgZX2B2p"
    token = "FwoGZXIvYXdzEIj//////////wEaDBPAsDltc1n1qEbw3iLVAejqBADoTqLDdqwztSE9RH49BQIoV02hKWppLOLgWqHTOnxngFcS9lGqbPVK0sXigERtjETwS6MborU+SZRCq+OyRQa4/ue0r0dQxV47SZj5b5Aj68lbMGs7sCRkp/IZbS3T/4hV/NHssIP/OdAQcvhp7tKqMZ+DnmpoRkns6kMGMi2ES+h431VcwD4YHfEV1upNTIwfIFzIKpkIPFedHnNFRPZnmBk7Ws5HDKDzQS0KIS7n+/Y1a/zkg62TxUDCYLdAlXsiQ+FrzQQpNqCIyP61dttGlijFxPilBjItbodyAFC7gZR9K9mYH+NdVkYhNNij7ZGDiepcLkhYKOppU9GImVHmuGXb+hRg"
    region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
# resource "aws_instance" "Udacity_T2" {
#   ami           = "ami-053b0d53c279acc90"
#   instance_type = "t2.micro"
#   subnet_id     = "subnet-09b483fa00011d503"
#   count         = 4
#   tags = {
#     "Name" = "Udacity T2"
#   }
# }

# TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "Udacity_M4" {
#   ami           = "ami-053b0d53c279acc90"
#   instance_type = "m4.large"
#   subnet_id     = "subnet-087623d47ff1d76f9"
#   count         = 2
#   tags = {
#     "Name" = "Udacity M4"
#   }
# }