# Cloud Management Platform - VaPP Terraform Sample Codes
#
#
# Brazil Managed Services Architecture
## Created by Carlos Azevedo
cazevedo@equinxix.com
#

## Terraform and Equinix Hybrid Cloud

Since Equinix Hybrid Cloud is a VMWare vCloud Director based infrastructure, we can take advantage of Terraform to create, modify, and destroy resources within it.

Terraform provides a set of infrastructure language based on VCD Provider that can help us to write IaC and deploy your workloads within Equinix Hybrid Cloud in a fast and securely way.

You can use the modules from Hashicorp VCD Provider to do it.
#

## The Hybrid Cloud Terraform Sample

Our goal here is to give you a sample code, generalized, that you can use to create a Virtual Application with some virtual machines inside it, connected to a predefined organization network and deploy your workload in matter of minutes.

This sample code intends to be your starting point to do more, to begin coding with terraform inside Equinix Hybrid Cloud, and to provide you with the beauty of IaC and how Equinix can help you to stay up to date with the best technologies.
#

## Repository Source Code

The source code is available within the Equinix Git repositories and can be downloaded to be used with Equinix Hybrid Cloud.
The repository link is: HTTPS://GITHUB.COM/EQUINIX/HC-TF-SAMPLE-VAPP

It’s a Git repository, so you’ll need to use Git CLI to interact with it.
To install the Git CLI, please look in here.

How to download the codes from Git.
Go to your bash console and type:
GIT CLONE HTTPS://GITHUB.COM/EQUINIX/HC-TF-SAMPLE-VAPP
#

## Terraform Modules

The first step is to understand the code structure and how the modules interact.

Since it is a simple code, we have only one module here represented by the sub item called INFRA-VAPP.
Inside this module we can find all codes needed to create our virtual application, fulfill its dependencies, and deliver the virtual machines within it.

The file VAPP.TF contains the source code, the file VARIABLES.TF the modules variables and the OUTPUT.TF any output intended to be passed from the module to the root.

The root area of the code is composed by the same files VARIABLES.TF and OUTPUT.TF. But in this level, we must consider the variables that we need on the root level of the code and not only the variables from the module.

The OUTPUT.TF here will deliver outputs from the code execution, so everything described in this output level will be exposed at the end of the code execution.

The MAIN.TF is the master file, here we define the provider where we will connect, the modules we are calling and their variables values.
#

## The Virtual Application Module

This module will define the infrastructure to be created.

The resource VCD_VAPP provides a VMware Cloud Director vApp resource. This can be used to create, modify, and delete vApps.
The resource VCD_VAPP_ORG_NETWORK provides capability to attach an existing Org VDC Network to a vApp and toggle network features.

Here we added a dependency where to create the network link, we first need the Virtual Application to be already created to make the reference.
#

## Catalog Steps

Once we’ve done the vApp creation, now we need to browse a template image from an existing catalog to create our Virtual Machines to hold the vApp workload.

To do it so, first we search for the desirable catalog, then we search for the image inside this catalog.
We are going to use a data source command called VCD_CATALOG, that provides a VMware Cloud Director Catalog data source. A Catalog can be used to manage catalog items and media items.

Then we are going to use another data source command, VCD_CATALOG_VAPP_TEMPLATE, that provides a VMware Cloud Director vApp Template data source. A vApp Template can be used to reference an already existing vApp Template in VCD and use its data within other resources or data sources.

We have now built the Virtual Application shell and collect the Catalog and Image Template references.
#

## vApp Virtual Machines

It’s time to create the virtual machines, as many as we want it to, to hold our workload and compose the vApp created before.
To do it so, we need to use the resource VCD_VAPP_VM and set some attributes.

The count variable in the first line will receive the input stating the number of virtual machines we are going to create.
We pass the vApp name variable as reference to indicate where these VMs will reside and format the name of the virtual machine to be a composition of the vApp Name plus an index counter.
Eg.
- vApp Name: VAPP-WEB
- vApp VMs Names:
    - VAPP-WEB-0
    - VAPP-WEB-1
    - VAPP-WEB-2
    - VAPP-WEB-3

We set the VM shapes, CPUs, Cores, Memory, etc.
Make the reference to the Org Network that we created the link before calling the resource name on VCD_VAPP_ORG_NETWORK.NETWORKS.ORG_NETWORK_NAME, and set some default post customization optional attributes.
#

## Infra-vapp Variables

To set the variables and do the right modularization, we need to create and fulfill the file variables.tf, containing all the variables used on this module.

Here we can define the variables, it’s default values, descriptions and use them to pass values across the module to the root level of the code.
It’s imperative that all the variables referenced on the module be declared here, otherwise you are going to have trouble, like an ERROR STOP.
#

## The Main File

The main course, the opera of our code, the main file, where we define what will be executed, when and why.
It seams stressful, but it’s simples, don’t worry.

The main file just states the provider where we are going to connect, and in our case, using modularization (which is very good by the way), we call the modules created before and define the values for the variables declared in those modules.

Wait, what? Variables to fulfill variables? Yes, my young padawan.
 
Even in the main file, it’s a best practice to use variables and don’t expose directly sensitive information like credentials and other sensitive information.

Furthermore, using variables prevent you to change the code, you just need to change the variables file with the value that you need or pass the information in execution time, what makes more sense when we want to generalize the code.

After we configure the provider, we can call all modules that we have created, one by one, and make the main file, the place where our modules connect.
 
We just need to use the module resource, give him a name, indicate the source (the path) to the module, and reference the variables.
And it´s done.

Oh wait! Not yet. Scroll down 😅
#

## The Root Level Variables

As well we did at the module level, we need to define the variables here too. So, we are going to create the same structure inside an varible.tf file and declare all the variables used in the main file.
 #

## The Global Variables File

The TERRAFORM.TFVARS will state and declare the global variables, predefined and used along all the code.
After the environment variables, which we are not using here, the TERRAFORM.TFVARS is the first file that terraform will look to load variables to the code if it´s present.
 
Here the goal is to define variables that will remain the same and won’t change, no matter what happens.
If you comment out these variables, you’ll generalize the code, so, in the execution, the terraform will prompt you for that information, so you can choose over time, without the need to change the code every time you execute it.

But, if you be certain that you will always use the same catalog, same network, organization, VDC and any other variable that you want with the same value, you can add their values here.

Just be careful to do not expose credentials.
Always use best practices like environment variables, pipelines variables, secret vaults or just pass the credential information in execution time.
#

## Initializing the Modules

It is time! We are going to deploy our code and create our infrastructure as a code. But how?
Easy!

First, open a terminal screen with a bash console. I recommend using an IDE like Visual Studio with Ubuntu 18.04 LTS as bash terminal or later version. Don’t forget to enable Windows Subsystem for Linux (WSL).

Run TERRAFORM INIT command at the root level of the code.

The TERRAFORM INIT command initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.
#

## Planning the Execution

After successfully run the initialization, we are going to plan our deploy to see if everything is okay.
Run TERRAFORM PLAN -OUT=PLAN.
 
All the variables that we have not declared with a default value will be requested to be fulfilled now. And it’s good, we asked for it, so get to work, pass on the information, and let the code do their job!

If you rather use the variables values within the tfvars file, the code will execute without asking you for variables inputs.
The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. By default, when terraform creates a plan it:
- Reads the current state of any already-existing remote objects to make sure that the Terraform state is up to date.
- Compares the current configuration to the prior state and noting any differences.
- Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

The plan command alone does not actually carry out the proposed changes.
You will a planning information on the screen stating exactly everything that the code will do, and the information that this planning was saved in a file, that’s why we wrote the plan command with an -OUT=PLAN option.
#

## Deploying the Code

Once we already initialized the modules and planned our execution, it’s time to rock n’ roll and put this code to fly!
Go back to the bash console and run the command:

- TERRAFORM APPLY PLAN -AUTO-APPROVE

The terraform apply command executes the actions proposed in a Terraform plan.
So, as we saved our plan execution in a file called PLAN, we are calling the apply command to be executed looking to the plan already made.

You can pass the -AUTO-APPROVE option to instruct Terraform to apply the plan without asking for confirmation. But be careful, if you take too long to apply your saved plan, terraform will no long accept it to be deployed, as a stale plan.

Run the command, and behold, the power of IaC!

If we look inside Equinix Hybrid Cloud, we can see our infrastructure being created.
And voilà! Everything is done in a few minutes.

And you can redeploy this code as many times you need it and can be reused for everyone in your enterprise.
But remember, terraform works with a state file, so he knows what you have done in last summer. To run it again without affect the already deployed infrastructure, make a copy of it to another place.

When you deploy your infrastructure as a code, you must manage it in your code, keep that in mind!
Do not fear the coding, fear is the path to the dark side. Keep coding!
#

## Deploying Workloads
You can add to this code, guest customization options to deploy along side the infrastructure, the workload to configure the application with a purpose, because as we know, without purpose, we would not exist.

You can use this document as guide to understand and create your vApp customization and deploy your application through IGNITION FILES or using CLOUD-INIT.