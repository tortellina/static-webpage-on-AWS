#COMPANY'S STATIC WEBPAGE DEPLOYMENT ON AWS USING TERRAFORM

This project sets up the deployment of a simple static webpage using AWS as provider
and Terraform as IaaC, developed using Visual Studio Code. The infrastructure include the set up of subnets, internet and NAT gateway, security groups,
listener, target, load balancer and autoscaling group. 

#TABLE OF CONTENTS
1.STRUCTURE OVERVIEW
2. INSTALLATION  
    2.1 TERRAFORM
    2.2 AWS CONSOLE
3. CONFIGURATION - ACCESS TO THE WEBSITE
4. ADDITIONAL INFORMATION



##1. STRUCTURE OVERVIEW
The users access the website by browsing the DNS name of the load balancer. 
The request is sent inside the Virtual Private Enviroment (VPC) through the internet gateway which then share the request to the load balancer. 
The latter distribuites the incoming traffic among the two avaiability zones, send the request to the EC2 instance (web-server) 
contained in the private subnet which then send back the response through the load balancer to the user. 
The autoscaling group guarantee the availability of resources based on the traffic of the website. 
The presence of a nat gateway is needed to ensure the possibility of EC2 instances to send outbound traffic.


##2. INSTALLATION

This Webpage configuration comes in a zip file. Extract the files and open the folder in Visual Studio Code. Remember to configure your
aws console with the right permits for the user. See below for further infomation on the prior steps.

##1.1 TERRAFORM INSTALLATION
Terraform is an Infrastructure as a Code (IaaC), a tool for managing and provisioning structures with the use of code instead of
doing it manually. For installing the software, search on the official Terraform HashiCorp Developer website for the installation package
suited for your Operating System (or follow this link https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

##1.2 AWS CONSOLE INSTALLATION AND SET-UP
You must have an AWS account. 

A AWS user must be accessed in your device for permitting terraform to create the infrastructures coded in the files, directed in your AWS account:

1. Download AWS CLI (https://aws.amazon.com/cli/)
2. Access your aws account and go to IAM > user
3. Create a new user (i.e. "user-cli") with the permissions "AmazonEC2FullAccess" and "IAMFullAccess". Retrive access key ID and password
4. Open a prompt in your device and type "aws configuration". This configuration must be completed:

    AWS Access Key ID []: *insert access key ID*
    AWS Secret Access Key []:  *insert password*
    Default region name []: *insert 'eu-north-1'*
    Default output format []: *insert 'text'*

The set up is done.


##2.CONFIGURATION - ACCESS TO THE WEBSITE
The following steps will guide you trough the initialization of the website:
1. OPEN THE FOLDER IN VISUAL STUDIO CODE
2. OPEN A TERMINAL
3. DIGIT IN THE TERMINAL THE FOLLOWING STATEMENTS IN THE SAME ORDER:
        - "terraform init". This initializes terraform inside our working enviroment.
        - "terraform validate". This comand tells if the structure is valid.
        - "terraform plan". This recap the computing structures that are going to be created.
        - "terraform apply". This comand creates the infrastructure.
4. ACCESS THE WEBSITE TROUGH THE DNS NAME OF THE LOAD BALANCER THAT HAS BEEN PRINTED IN THE TERMINAL.

ATTENTION: when the infrastructure is no longer needed, digit in the terminal "terraform destroy" to delete every part of the infrastruture.


##5. ADDITIONAL INFORMATION
For any questions, feel free to contact me.
