# Terraform Exercise: S3 Static Website Hosting

## Introduction

This exercise will guide you through:

1. Creating an S3 bucket as a separate Terraform module.
2. Enabling static website hosting on the S3 bucket.
3. Outputting the website's DNS.

---

## 1. Project Structure

Organize your Terraform project as follows:

```
terraform-s3-static-site/
│── modules/
│   ├── s3_static_site/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── outputs.tf
│── variables.tf
│── providers.tf
```

---

## 2. Define the S3 Module

Inside `modules/s3_static_site/`, create the necessary Terraform files.

### `modules/s3_static_site/main.tf`
Define the resources for:
- Creating an S3 bucket
- Enabling static website hosting
- Setting a bucket policy to allow public access

```hcl
# Define your S3 bucket here

# Enable static website hosting

# Configure the bucket policy
```

### `modules/s3_static_site/variables.tf`
Define the input variable for the bucket name.

```hcl
# Define a variable for the bucket name
```

### `modules/s3_static_site/outputs.tf`
Define the output variable for the website's DNS.

```hcl
# Output the website endpoint
```

---

## 3. Define the Root Module

Configure `main.tf` at the root level to use the module.

### `main.tf`
```hcl
# Call the S3 module and pass the required variable
```

### `outputs.tf`
Define the output for the website endpoint.

```hcl
# Output the S3 static website URL
```

### `providers.tf`
Set up the required AWS provider.

```hcl
# Define the provider configuration
```

---

## 4. Running Terraform

Execute the following commands to initialize and apply your Terraform configuration:

```sh
terraform init
terraform apply
```
