# Introduction
In the following project it can be seen how a personal website is deployed with CICD pipeline the usage of the technologies and methods of DevOps on AWS.
# Pre-requisites
1. AWS account
2. Installed Docker
3. Installed Terraform
4. DigitalOcean or any cloud provider
5. Jenkins on DigitalOcean (or any in your case)

To set up the credentials of AWS use the following path: ~/.aws/credentials
# Deployment steps
1. On DigitalOcean we create a droplet which will be serving as point for CICD. Jenkins will be used as CICD, firstly docker will be installed on droplet, after that Jenkins is run with docker. Inside of the Jenkins's container requires to install Terraform in order to run terraform files.
![Screenshot from 2024-04-01 11-57-16](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/a1d52b7e-695f-44df-908c-55affe095432)
![carbon (1)](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/01e371de-fbeb-4599-8e88-541d63d6214f)
