
### Terraform Remote State Backend & State Locking  
### 1️⃣ Create S3 Bucket & DynamoDB 

Before configuring the backend, create:
- S3 bucket → to store Terraform state ('***bucket.tf***')
- DynamoDB table → to manage state locking ('***dynamo.tf***')

### 2️⃣ Write Backend Configuration Code

Create ***terraform.tf***:  
<img width="548" height="346" alt="image" src="https://github.com/user-attachments/assets/974bdcfa-a046-496d-8f85-ec98b9d0b826" />


This tells Terraform:  
-  ✔️ Where to store state (S3)
-  ✔️ How to lock state (DynamoDB)


### 3️⃣ Write Infrastructure Code  
Inside your Terraform project:
- providers.tf
- variables.tf
- main.tf
- outputs.tf

At this stage:
- State is still local
- Backend is not active yet


### 4️⃣ Run terraform init  
```bash
terraform init
```
<img width="701" height="505" alt="image" src="https://github.com/user-attachments/assets/c05dbbd8-8fde-4149-8405-11029a46b6e2" />


Terraform does the following:
-  ✔️Detects backend configuration
-  ✔️Initializes S3 backend
-  ✔️Prompts for state migration


### 5️⃣ State Migration to S3  
After confirmation:
-  ✔️Local terraform.tfstate is copied to S3
-  ✔️Terraform starts using remote state
-  ✔️Local state is ignored
  
<img width="1279" height="295" alt="image" src="https://github.com/user-attachments/assets/6a31a980-b006-42d8-a643-9319995ae846" />
<img width="1080" height="285" alt="image" src="https://github.com/user-attachments/assets/0c5f0744-fdd6-4e33-b0ee-e06ad75d118a" />


<img width="1275" height="225" alt="image" src="https://github.com/user-attachments/assets/1448fafe-ac5a-4887-a273-9c8fc4c4139b" />  


📌 This is why:  

Even after deleting '***.tfstate***', Terraform still works  
<img width="672" height="260" alt="image" src="https://github.com/user-attachments/assets/208098e4-9a52-4ee6-898b-9508a2a9bdfc" />

 
### 6️⃣ Backend Initialization Completed  
- All Terraform commands use S3 state  
- DynamoDB locking is enabled  

### 7️⃣ Verify Remote State  
```bash
terraform state list
```

<img width="668" height="126" alt="image" src="https://github.com/user-attachments/assets/bcd0b083-d9da-47a3-a667-c5416c5aaffc" />


Terraform:
-  ✔️Reads state from S3  
-  ✔️Lists all managed resources  
-  ✔️Confirms remote backend is active


### 8️⃣ State Locking During Apply/Destroy  

```bash
terraform apply
```

<img width="668" height="126" alt="image" src="https://github.com/user-attachments/assets/d50b004b-c600-4645-b44b-12c44296726b" />


Terraform:
-  ✔️Acquires a lock in DynamoDB  
-  ✔️Prevents parallel execution  

  If you run Terraform from another terminal:
  - It fails with state lock error  

<img width="426" height="357" alt="image" src="https://github.com/user-attachments/assets/fe88bdbf-f91d-478a-aeba-79c1d1fc821c" />


📌 This proves locking is working
