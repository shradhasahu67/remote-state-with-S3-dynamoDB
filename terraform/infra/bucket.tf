resource "aws_s3_bucket" "my_bucket" {
  bucket = "remote-tf-state-bucket-sahu"       #string interpolation
  tags = {
    Name = "remote-tf-state-bucket-sahu"
    //Environment=var.env                      #making it module specific
  }
}