terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
  }

  
  #remote state backend
  backend "s3"{
    bucket= "remote-tf-state-bucket-sahu"
    key= "terraform.tfstate"    # tfstate file stored in bucket
    region="us-east-1"
    dynamodb_table = "remoteState-tf-app-table"

}

}



