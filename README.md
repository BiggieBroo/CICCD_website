# Introduction
In the following project it can be seen how a personal website is deployed with CICD pipeline the usage of the technologies and methods of DevOps on AWS.
# Pre-requisites
1. AWS account
2. Installed Docker, docker-compose
3. Installed Terraform
4. DigitalOcean or any cloud provider
5. Jenkins on DigitalOcean (or any in your case)
6. DockerHub acccount

To set up the credentials of AWS use the following path: ~/.aws/credentials
# Deployment steps
1. On DigitalOcean we create a droplet which will be serving as point for CICD. Jenkins will be used as CICD, firstly docker will be installed on droplet, after that Jenkins is run with docker. Inside of the Jenkins's container requires to install Terraform in order to run terraform files.
![Screenshot from 2024-04-01 11-57-16](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/a1d52b7e-695f-44df-908c-55affe095432)
![carbon (1)](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/01e371de-fbeb-4599-8e88-541d63d6214f)
To install Terraform inside the container the following link is used: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
2. Then Jenkins will be run based on the provided IPv4 by DigitalOcean.
3. In the Jenkins need to set up the credentials for DockerHub, AWS, GitHub
![Screenshot from 2024-04-01 09-12-10](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/8bc9d927-bc7a-419b-90a5-1cfde3bcd604)
4. Further, need to install SSH Agent plugin on Jenkins via GUI.
5. For the automation the entire process need to prepare "jenkins-shared-library" so they might be run as functions. As "Class" need to "Docker.groovy", then variables as "groovy" files as well. The files are pushed into the branch "jenkins-shared-library".
6. The next stage is preparing a Jenkinsfile. In the file need to give the exact steps what should be done such as dockerizing the site, naming and pushing into the docker hub. When they are ready, the next step is running it on AWS.
7. Before executing the 6th step, the process demands to prepare infrastructure with the Terraform. By setting up the exact resources we can run in pipeline.
8. As soon as all of the resources ready then we might create a pipeline by the name "website_pipeline" and run it.
![Screenshot from 2024-04-01 09-12-33](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/684727b3-1fb8-4114-bb40-8718d6cd5649)
![Screenshot from 2024-04-01 13-20-16](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/810bfd16-d42e-4821-9577-b67560c23b91)
9. As the final step we get our website via DNS hostname.
![devops_site](https://github.com/BiggieBroo/CICD_website_DevOps/assets/140602458/aa32a90f-ff02-4489-8b66-7f3bdb1ae904)
