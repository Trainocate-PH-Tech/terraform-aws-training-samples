# Basic Docker Deployment

## **Objective**
Deploy a custom Docker container using Terraform, which serves a static website using Nginx and a mounted volume.

---

## **Prerequisites**
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Ensure Docker is running
- Any text editor for writing code

---

## **Step 1: Create the Project Directory**

Create a new directory and navigate into it:

```sh
mkdir terraform-docker-app  
cd terraform-docker-app  
```

---

## **Step 2: Create a Simple Web App**

Create a `index.html` file inside a `website` directory:

```sh
mkdir website
nano website/index.html
```

Add the following content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform + Docker</title>
</head>
<body>
    <h1>Hello from Terraform-deployed Docker container!</h1>
</body>
</html>
```

---

## **Step 3: Create a Custom Dockerfile**

Create a `Dockerfile` in the project directory:

```dockerfile
FROM nginx:latest
COPY website /usr/share/nginx/html
EXPOSE 80
```

This builds an image using Nginx and serves our custom `index.html`.

---

## **Step 4: Write the Terraform Configuration**

Create a file named `main.tf` and add the following:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "custom_nginx" {
  name         = "custom-nginx"
  build {
    context    = "./"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "web" {
  name  = "my-nginx"
  image = docker_image.custom_nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}
```

This Terraform script:
- Uses the Docker provider
- Builds a custom Nginx image with our static website
- Deploys the container and maps port `8080` on the host to `80` inside the container

---

## **Step 5: Initialize and Deploy**

Run the following commands:

1. **Initialize Terraform:**
   ```sh
   terraform init
   ```

2. **Plan the Deployment:**
   ```sh
   terraform plan
   ```

3. **Apply the Configuration:**
   ```sh
   terraform apply -auto-approve
   ```

---

## **Step 6: Test the Deployment**

Open a browser and visit:

```
http://localhost:8080
```

You should see the custom static webpage.

---

## **Step 7: Clean Up**

To destroy the container and image, run:

```sh
terraform destroy -auto-approve
```

---

## Challenge Items

## **Bonus Challenges**
1. Modify Terraform to use environment variables
2. Mount the `website` directory instead of copying it at build time
