
### Terraform Remote State Backend & State Locking  
### 1️⃣ Create S3 Bucket & DynamoDB 

Before configuring the backend, create:
- S3 bucket → to store Terraform state ('***bucket.tf***')
- DynamoDB table → to manage state locking ('***dynamo.tf***')

### 2️⃣ Write Backend Configuration Code

Create ***terraform.tf***:  
<img width="822" height="519" alt="image" src="https://github.com/user-attachments/assets/6ed6f728-2f66-46fd-9692-f6596c40f2a1" />


This tells Terraform:  
-  ✔️ Where to store state (S3)
-  ✔️ How to lock state (DynamoDB)


### 3️⃣ Write Infrastructure Code  
Inside your Terraform project:
- main.tf
- dynamo.tf
```bash
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

```
- outputs.tf
- terraform.tf
```bash
  #remote state backend
  backend "s3"{
    bucket= "remote-tf-state-bucket-sahu"
    key= "terraform.tfstate"    # tfstate file stored in bucket
    region="us-east-1"
    dynamodb_table = "remoteState-tf-app-table"

}
```

At this stage:
- State is still local
- Backend is not active yet


### 4️⃣ Run terraform init  
```bash
terraform init
```
<img width="1051" height="757" alt="image" src="https://github.com/user-attachments/assets/1b1d07d3-647d-429d-98e1-bc072a72a057" />


Terraform does the following:
-  ✔️Detects backend configuration
-  ✔️Initializes S3 backend
-  ✔️Prompts for state migration


### 5️⃣ State Migration to S3  
After confirmation:
-  ✔️Local terraform.tfstate is copied to S3
-  ✔️Terraform starts using remote state
-  ✔️Local state is ignored
  
<img width="1919" height="443" alt="image" src="https://github.com/user-attachments/assets/911613c3-ebce-424b-a210-b406bf392e1a" />
<img width="1620" height="428" alt="image" src="https://github.com/user-attachments/assets/fbb234cd-a0b3-47d0-b3e7-1fbd9550ddc4" />


<img width="1918" height="771" alt="image" src="https://github.com/user-attachments/assets/e0b2b135-cf96-4581-88b9-12e73f03e64c" />


📌 This is why:  

Even after deleting '***.tfstate***', Terraform still works  
<img width="673" height="195" alt="image" src="https://github.com/user-attachments/assets/1704fb07-169d-4b5e-abf9-17e9b17099b2" />

 
### 6️⃣ Backend Initialization Completed  
- All Terraform commands use S3 state  
- DynamoDB locking is enabled  

### 7️⃣ Verify Remote State  
```bash
terraform state list
```

<img width="673" height="195" alt="image" src="https://github.com/user-attachments/assets/1339dd8a-301c-4957-b639-c28ed30cf596" />


Terraform:
-  ✔️Reads state from S3  
-  ✔️Lists all managed resources  
-  ✔️Confirms remote backend is active


### 8️⃣ State Locking During Apply/Destroy  

```bash
terraform apply
```

<img width="1002" height="189" alt="image" src="https://github.com/user-attachments/assets/fc1f441d-deb8-4d1e-b008-d6b0d044e794" />


Terraform:
-  ✔️Acquires a lock in DynamoDB  
-  ✔️Prevents parallel execution  

  If you run Terraform from another terminal:
  - It fails with state lock error  

<img width="639" height="535" alt="image" src="https://github.com/user-attachments/assets/6b8b845d-3563-4b60-80e5-087f16a79f82" />


📌 This proves locking is working
