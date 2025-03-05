# Terraform GCP Compute Instance Deployment

This repository contains a Terraform configuration and a GitHub Actions workflow to deploy a Google Cloud Platform (GCP) Compute Instance using Terraform. Deployments can be triggered manually by running Terraform locally or automatically via GitHub Actions when a versioned tag (e.g., `v1.0.0`) is pushed.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) (>= 1.0). Note that the GitHub Action uses Terraform v1.3.0.
- A GCP account with the required permissions.
- [Google Cloud SDK](https://cloud.google.com/sdk) (if running Terraform locally).
- GCP credentials in JSON format.

## Repository Structure

- **.github/workflows/terraform-deploy.yml**: GitHub Actions workflow that triggers deployments on tag push events.
- **terraform/**
  - `main.tf`: Defines the Google Compute Instance.
  - `variables.tf`: Contains variable definitions (e.g., project_id, region, zone, machine_type).
  - `outputs.tf`: Exposes outputs such as instance name and external IP.
  - `versions.tf`: Specifies Terraform and provider version requirements.

## Running Terraform Locally

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>
   ```

2. **Set Up Your GCP Credentials:**

   Export your GCP credentials and project ID as environment variables:

   ```bash
   export GOOGLE_CREDENTIALS=$(cat /path/to/your/gcp_credentials.json)
   export GCP_PROJECT=<your-gcp-project-id>
   ```

3. **Navigate to the Terraform Directory:**

   ```bash
   cd terraform
   ```

4. **Initialize Terraform:**

   ```bash
   terraform init
   ```

5. **Plan the Deployment:**

   ```bash
   terraform plan -var "project_id=$GCP_PROJECT"
   ```

6. **Apply the Deployment:**

   ```bash
   terraform apply -auto-approve -var "project_id=$GCP_PROJECT"
   ```

## Deploying via GitHub Actions

1. **Configure GitHub Secrets:**

   In your repository settings, add the following secrets:
   - `GCP_CREDENTIALS`: Your GCP credentials in JSON format.
   - `GCP_PROJECT`: Your GCP project ID.

2. **Create a Versioned Tag:**

   The workflow is triggered on tag pushes that follow the pattern `v*`. For example:

   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

3. **GitHub Actions Workflow:**

   When a versioned tag is pushed, the workflow (`.github/workflows/terraform-deploy.yml`) will:
   - Checkout the repository.
   - Set up Terraform using the specified version.
   - Run `terraform init`, `terraform plan`, and `terraform apply` within the `./terraform` directory.

## Cleaning Up

To destroy the deployed resources, run the following command in the `terraform` directory:

```bash
terraform destroy -var "project_id=$GCP_PROJECT"
```

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to open a pull request or an issue.

## License

This project is licensed under the [MIT License](LICENSE).
