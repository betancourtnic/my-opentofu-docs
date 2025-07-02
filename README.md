You can view the embedded content directly on Notion here: [OpenTofu User Guide (Notion)](https://plain-son-12d.notion.site/ebd/223839cd91d68076a65dd6100cace3b1)

# OpenTofu User Guide for Windows: From Installation to Your First Project
## Table of Contents
Introduction

Prerequisites

Part 1: Installing OpenTofu on Windows

Method 1: Manual Installation (Recommended)

Method 2: Using the PowerShell Installer Script (Alternative)

Part 2: Setting up Visual Studio Code (VS Code) for OpenTofu

Part 3: Your First OpenTofu Project (A Local File Example)

Understanding the OpenTofu Workflow

Step 1: Create a Project Directory

Step 2: Write Your Configuration (main.tf)

Step 3: Initialize the Working Directory (tofu init)

Step 4: Review the Plan (tofu plan)

Step 5: Apply the Changes (tofu apply)

Step 6: Understand the tofu.tfstate file

Step 7: Inspect the State (tofu show)

Step 8: Clean Up Your Infrastructure (tofu destroy)

Part 4: Next Steps - Building Real Infrastructure

Conclusion

### 1. Introduction
OpenTofu is an open-source, community-driven fork of Terraform that allows you to define, provision, and manage infrastructure as code. This guide will walk you through the process of installing OpenTofu on your Windows machine and setting up your development environment, culminating in building your very first project.

### 2. Prerequisites
Before you begin, ensure you have:

A Windows operating system (Windows 10 or 11 recommended).

Administrator privileges on your machine (needed for adding to system PATH).

An active internet connection.

(Recommended) Visual Studio Code installed (download from https://code.visualstudio.com/).

### 3. Part 1: Installing OpenTofu on Windows
You have two primary ways to install OpenTofu on your Windows machine.

Method 1: Manual Installation (Recommended for Most Users)
This method involves downloading the OpenTofu executable and placing it in your system's PATH.

Download the latest release:

Go to the official OpenTofu GitHub Releases page: https://github.com/opentofu/opentofu/releases

Find the latest stable release (e.g., v1.x.x).

Under the "Assets" section for that release, download the .zip file for Windows. It will typically be named something like tofu_X.X.X_windows_amd64.zip.

Extract the executable:

Locate the downloaded .zip file, right-click, and select "Extract All...".

Once extracted, you will find a single executable file named tofu.exe inside.

Place tofu.exe in your PATH:

Create a dedicated directory: Create a new folder where you'd like to permanently store tofu.exe. A common choice is C:\OpenTofu\bin.

Move tofu.exe: Move the extracted tofu.exe file into this new directory (e.g., C:\OpenTofu\bin).

Add to System PATH Environment Variable: This step allows you to run tofu commands from any directory in your Command Prompt or PowerShell.

Search for "Environment Variables" in your Windows search bar and select "Edit the system environment variables."

In the System Properties window, click the "Environment Variables..." button.

Under the "System variables" section, locate and select the "Path" variable, then click "Edit...".

In the "Edit environment variable" window, click "New" and add the full path to your tofu.exe directory (e.g., C:\OpenTofu\bin).

Click "OK" on all open windows to save your changes.

Verify Installation:

Open a NEW Command Prompt or PowerShell window (existing windows won't have the updated PATH).

Type tofu version and press Enter.

You should see the OpenTofu version information, confirming a successful installation.

Method 2: Using the PowerShell Installer Script (Alternative)
OpenTofu provides a PowerShell script for an automated installation.

Open PowerShell as Administrator: Right-click on the PowerShell icon in your Start Menu and select "Run as administrator."

Temporarily set execution policy (if needed):

PowerShell

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
This allows running downloaded scripts. You can revert this later if desired.

Download the installer script:

PowerShell

Invoke-WebRequest -outfile "install-opentofu.ps1" -uri "https://get.opentofu.org/install-opentofu.ps1"
Run the installer:

PowerShell

& .\install-opentofu.ps1 -installMethod standalone
Remove the installer (optional):

PowerShell

Remove-Item install-opentofu.ps1
Verify Installation:

Open a NEW Command Prompt or PowerShell window.

Type tofu version and press Enter to confirm.

### 4. Part 2: Setting up Visual Studio Code (VS Code) for OpenTofu
VS Code is highly recommended for writing OpenTofu configurations due to its powerful extensions.

Install VS Code: If you haven't already, download and install VS Code from https://code.visualstudio.com/.

Install the OpenTofu VS Code Extension:

Open VS Code.

Go to the Extensions view by clicking the square icon on the left sidebar (or press Ctrl+Shift+X).

In the search bar, type "OpenTofu".

Look for the extension published by OpenTofu (or an officially affiliated publisher as it evolves).

Click the "Install" button.

Benefits of the OpenTofu Extension:
This extension provides syntax highlighting, IntelliSense (autocompletion), code formatting, validation, and snippets, greatly enhancing your coding experience.

### 5. Part 3: Your First OpenTofu Project (A Local File Example)
This section guides you through the fundamental OpenTofu workflow using a simple example that creates a local file on your machine.

Understanding the OpenTofu Workflow
The core OpenTofu workflow involves these steps:

Define: Write your infrastructure in .tf files.

Init: Initialize the working directory, downloading necessary providers.

Plan: Preview the changes OpenTofu proposes to make to your infrastructure.

Apply: Execute the plan to provision or modify your infrastructure.

Destroy: (Optional, but good for cleanup) Remove the infrastructure created by OpenTofu.

Step 1: Create a Project Directory
Open your Command Prompt or PowerShell and create a new, empty folder for your first project:

PowerShell

mkdir my-first-tofu-project
cd my-first-tofu-project
Step 2: Write Your Configuration (main.tf)
Now, create your OpenTofu configuration file inside the my-first-tofu-project directory.

Open VS Code: In VS Code, go to File > Open Folder... and select the my-first-tofu-project folder.

Create main.tf: In the VS Code Explorer (left sidebar), click the "New File" icon and name the file main.tf.

Add the Configuration: Paste the following content into main.tf:

Terraform

#Define a local file resource
resource "local_file" "hello_opentofu" {
  content  = "Hello from OpenTofu! This file was created at ${timestamp()}"
  filename = "hello_opentofu.txt"
}

#Output the path to the created file
output "file_path" {
  value       = local_file.hello_opentofu.filename
  description = "The path to the generated hello file."
}
Code Explanation:

resource "local_file" "hello_opentofu": Declares a resource.

local_file: The provider and resource type (from the local provider, which interacts with your local filesystem).

hello_opentofu: Your chosen local name for this specific resource instance.

content: The text that will be written into the file. ${timestamp()} is an OpenTofu function for the current time.

filename: The name of the file to be created.

output "file_path": Defines an output variable, useful for displaying important information after provisioning.

Step 3: Initialize the Working Directory (tofu init)
Open the integrated terminal in VS Code (View > Terminal or Ctrl+`` ) or use your standalone PowerShell window. Ensure you are in the my-first-tofu-project directory.

Run:

PowerShell

tofu init
Expected Output:
You should see messages indicating that the backend is initialized and provider plugins (like hashicorp/local) are being found and installed.

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Installing hashicorp/local v2.x.x...
- Installed hashicorp/local v2.x.x (signed by HashiCorp)

OpenTofu has been successfully initialized!
...
Troubleshooting "OpenTofu initialized in an empty directory!":
If you see this message, it means OpenTofu couldn't find your main.tf file.

Verify Directory: Use pwd (PowerShell) or cd to ensure you are in the my-first-tofu-project folder.

Verify File Name: Use ls (PowerShell) to check that main.tf exists and is spelled correctly (not main.tf.txt or just main).

File Content: Ensure main.tf is not empty and contains the configuration provided above.

Step 4: Review the Plan (tofu plan)
Before applying any changes, always review the execution plan.

Run:

PowerShell

tofu plan
OpenTofu will analyze your configuration and show you a detailed list of actions it will perform. You should see that local_file.hello_opentofu will be created.

Important Note on tofu plan -out:
You might see a warning like: "You didn't use the -out option to save this plan, so OpenTofu can't guarantee to take exactly these actions if you run 'tofu apply' now."

What it means: Without -out, tofu apply will re-evaluate the state and your configuration, which could lead to different actions than what you saw in tofu plan if anything changes in between.

For this beginner project: You can usually ignore this warning and proceed directly to tofu apply, as the "state" (your local directory) is unlikely to change rapidly.

Best Practice: For real-world or collaborative projects, always use -out to save the plan.

To practice with -out:

Run: tofu plan -out my-first-plan.tfplan

This will save the precise plan to a file.

Step 5: Apply the Changes (tofu apply)
This command will execute the plan and create or modify your infrastructure.

If you didn't use -out in the previous step, run:

PowerShell

tofu apply
If you did save the plan using -out, run:

PowerShell

tofu apply my-first-plan.tfplan
OpenTofu will show the plan again (or use the saved plan) and then prompt for confirmation. Type yes and press Enter.

You should see confirmation that the resource was added and the file_path output:

...
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

file_path = "hello_opentofu.txt"
Verification: Check your my-first-tofu-project directory. You should now find hello_opentofu.txt created, containing the "Hello from OpenTofu!" message.

Step 6: Understand the tofu.tfstate file
After tofu apply, you'll notice a new file: tofu.tfstate (and potentially a .opentofu folder).

tofu.tfstate: This is OpenTofu's "source of truth" about the infrastructure it manages. It maps your OpenTofu resources to the real-world components created. Never manually edit this file, as it can corrupt OpenTofu's understanding of your infrastructure.

.opentofu folder: Contains OpenTofu's internal files and downloaded provider plugins.

Step 7: Inspect the State (tofu show)
You can view the contents of the tofu.tfstate file in a human-readable format using:

PowerShell

tofu show
This will display details about the local_file.hello_opentofu resource that OpenTofu is currently managing.

Step 8: Clean Up Your Infrastructure (tofu destroy)
It's good practice to clean up resources you no longer need, especially when learning, to avoid clutter or unexpected costs (for cloud resources).

PowerShell

tofu destroy
OpenTofu will show you a plan to destroy the resource. Type yes and press Enter when prompted.

The hello_opentofu.txt file should now be removed from your directory.

### 6. Part 4: Next Steps - Building Real Infrastructure
You've successfully completed the core OpenTofu workflow! Now, you can extend your learning to build real-world infrastructure in cloud providers.

Choose a Cloud Provider: Select a cloud platform you want to learn (e.g., AWS, Microsoft Azure, Google Cloud Platform, DigitalOcean, Linode). Many offer free tiers for basic services.

Set up Cloud Credentials: This is critical. Each cloud provider has specific instructions for generating API keys, access tokens, or configuring their CLI so OpenTofu can authenticate and manage resources. Follow their official documentation for this step.

Update your main.tf:

Add a provider block for your chosen cloud (e.g., provider "aws" { ... }).

Define a very simple resource in that cloud (e.g., an S3 bucket in AWS, a Resource Group in Azure, a Storage Bucket in GCP).

Repeat the Workflow:

tofu init (OpenTofu will now download the new cloud provider plugin).

tofu plan

tofu apply

Crucially, always remember tofu destroy when you're done with a cloud project to avoid incurring unexpected costs!

Explore the OpenTofu Registry: The official OpenTofu Registry (https://registry.opentofu.org/) is your best resource for finding providers and understanding the resources they offer, along with detailed examples.

### 7. Conclusion
You've successfully installed OpenTofu, set up your development environment, and completed your first infrastructure deployment and destruction. You now have a solid foundation to explore the powerful world of Infrastructure as Code. Keep practicing, refer to the documentation, and enjoy building!
