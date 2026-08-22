## Automate create AWS DB Instance using Terraform and GitHub Actions  


This is a complete setup to create AWS DB instance (MySQL) using Terraform and GitHub Actions.

**Requirements:**  
Add your AWS credentials to your GitHub repository  
- AWS_ACCESS_KEY_ID: Your AWS access key
- AWS_SECRET_ACCESS_KEY: Your AWS secret access key

<br/>

#### <ins>Method 1:</ins> Deploy AWS DB instance (MySQL) using CLI
- Deploy AWS DB instance (MySQL):  
```
tarraform init
terraform plan
terraform apply -auto-approve
```

- Destroy AWS DB instance (MySQL):
```
terraform init
terraform plan -destroy
terraform destroy -auto-approve
```

#### <ins>Method 2:</ins> Deploy AWS DB instance (MySQL) using GitHub Actions
- The provided GitHub Action is for deploying the AWS DB instance (MySQL) And they are triggered by workflow_dispatch. Change to other trigger if you wish.
- There are two Gihub Actions workflow files (deploy.yml and destroy.yml).
    - deploy.yml: Deploy the AWS DB instance (MySQL).
    - destroy.yml: Destroy AWS DB instance (MySQL).

<br/>
