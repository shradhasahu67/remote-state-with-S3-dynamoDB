
resource "aws_dynamodb_table" "my_table" {
    name = "remoteState-tf-app-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"                       #LockID if we set remote backend
    attribute {
      name = "LockID"
      type = "S"
    }
    tags = {
      Name = "remoteState-tf-app-table"
      //Environment = var.env
    }
  
}