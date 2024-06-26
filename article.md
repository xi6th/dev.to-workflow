---
title: Simplifying Terraform State Management - The GUI way 💎
published: false
description: A comprehensive guide on simplifying Terraform state management using Terraform Cloud.
tags: 'terraform, tfstate, TerraformCloud, azure, iac'
cover_image: 'https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/tfdod.JPG'
canonical_url: null
---

###### TL;DR

- Terraform Cloud Workspaces simplify state management and enhance collaboration and version control through an intuitive GUI.
- Terraform state is a snapshot of infrastructure at a given point in time, mapping Terraform configurations to real-world resources.
- Traditional state management approaches, such as storing state files locally or on a shared file system, can lead to issues like corruption, merge conflicts, and state drift.
- Terraform Cloud Workspaces offer a centralized solution by storing state files in the cloud, providing access to the latest version of the state and state locking to prevent conflicts.
- It also allows for versioning infrastructure and provides an easy-to-use GUI for managing resources with features like state locking, versioning, and a user-friendly interface.
- Terraform Cloud Workspaces streamline infrastructure management and make it more accessible, easy to restore different versions of your infrastructure, plus it's free to get started. 😄

#### Overview

Formula D, a car racing motorsport, is such a thrill to watch for most folks, even if you are not a fan. It involves not just getting across the finish line but also scoring points in the process by drifting plus a mix of driving styles.

With Terraform, a widely used Infrastructure as Code (IaC) tool, experiencing 'drift' is far from enjoyable, hence the ominous phrase 'TERRAFORM DRIFT OF DEATH'.

In the realm of Infrastructure as Code (IaC), managing the state of your infrastructure is as vital as the infrastructure itself. This post brings exciting news that makes using and managing Terraform not just essential but also enjoyable.

Terraform employs a concept known as "state" to track the resources it manages. This state is a text file, auto-created from your Terraform configuration during the initial run and stored within your workspace. As your configuration evolves, so does the state, providing an accurate representation of your actual infrastructure.

Terraform Cloud has a feature that not only revolutionizes state management but also simplifies, enhances collaboration, and improves version control, all through an intuitive GUI. This article delves deeper into this game-changing feature.

#### Understanding Terraform State

As explained above, Terraform state is a snapshot of your infrastructure at a given point in time. It maps your Terraform configurations to the actual resources, ensuring that Terraform knows what it is managing and how to update those resources without causing conflicts or duplications.

The state file is a file that stores your Terraform state as text. By default, this file is saved on the file system of the host where Terraform is running.

It's crucial to keep this state file synchronized with your actual infrastructure. If they fall out of sync, you'll encounter discrepancies, also known as state drift.

#### The Pain of State Management

##### Local State

Traditionally, Terraform stores state files locally. While this approach works well for individual use, it can quickly become a bottleneck for teams. Issues such as state file corruption, merge conflicts, and the dreaded "state drift" (where the state file no longer accurately reflects the actual infrastructure) can occur.

Since the state is stored on the host system's file system, collaboration becomes challenging. Each user ends up with a different copy of the state file, leading to inconsistencies. This approach is mostly recommended for local experimentation.

However, as your infrastructure and team grow, managing this state file can become increasingly complex due to frequent merge conflicts and drifts.

These limitations of using local storage led to the development of remote state management.

##### Remote State

In contrast to local state management, remote state involves storing the state files in a shared, remote location. This could be an AWS S3 bucket, an Azure storage account, or any other cloud storage service. Remote state allows team members to effectively share the same state file, promoting consistency across the infrastructure.

While remote state management significantly improves collaboration, it also introduces its own set of challenges:

1. **Bootstrapping Problem:** If your Infrastructure as Code (IaC) setup requires remote state, you'll need to describe the remote state storage (like an S3 bucket or Azure Storage account) in your code. This creates a "chicken and egg" situation, as the storage account itself will also require its own state management.
2. **Access Management:** Centralized storage locations require sharing access keys or credentials with team members. If not handled carefully, this can pose a security risk.
3. **Sensitive Information:** Terraform state files can contain sensitive data, such as secrets or access keys. If these files are not properly secured, unauthorized access could lead to data breaches or system compromises.
4. **Direct Interaction:** HashiCorp, the creator of Terraform, recommends against directly modifying or interacting with the state file. This can be challenging when changes to the state are necessary.

Understanding these potential issues and incorporating them into your Infrastructure as Code (IaC) strategy is crucial. I will now walk you through the process of eliminating the above concerns.

#### Terraform Cloud Workspaces to the Rescue

Terraform Cloud workspaces offer a centralized solution for state management. By storing state files in the cloud, it ensures that everyone on the team has access to the latest version of the state and easy version rollback via a GUI interface. It also provides state locking, preventing concurrent executions that could lead to conflicts. With Terraform Cloud, you do not need a third-party storage tool to manage the state of your infrastructure.

![1718741609701](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/tfdod.JPG)

#### Terraform Cloud Workspaces: A Modern Solution for State Management

Terraform Cloud Workspaces offer a centralized solution for managing state. By storing state files in the cloud, they ensure that all team members have access to the most up-to-date state version. This setup also facilitates easy version rollback through a user-friendly graphical user interface.

Key features of Terraform Cloud Workspaces include enhanced security measures, manual state lock/control to prevent conflicting operations, and Single Sign-On (SSO) integration with your organization.

With Terraform Cloud, you can eliminate the need for a third-party storage solution to manage your infrastructure's state, and there's also no requirement to define the "state backend" in your code.

Terraform Cloud significantly simplifies the overall process!

#### Getting Started with Terraform Cloud

1. **Sign Up**: Visit the [Terraform Cloud website](https://app.terraform.io "Terraform Cloud") and create your [free account](https://app.terraform.io/public/signup/account).
2. **Activate Your Account**: After signing up, you'll receive an email with a link to activate your account. Follow this link to complete the activation process.
3. **Create or Join an Organization**: Once you've logged in, you'll be directed to a page where you can either create a new organization or join an existing one, if you've been invited by a colleague.

   ![1718745641791](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718745641791.png)

   ![1718745747621](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718745747621.png)

4. **Create Workspaces**: Define workspaces for different environments or projects. There are three types of workspaces, but for this guide, select the **CLI driven** one. For more information on workspace types and their uses, refer to my other article on the same.

   ![1718745909028](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718745909028.png)

   ![1718745930424](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718745930424.png)

5. **Connect Your Configuration to Your Workspace**: Replace the existing Terraform block in your configuration with the code provided below. Leave the other settings as default.

   ![1718745972956](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718745972956.png)

   Update the following settings:

   - **Execution Mode**: Set this to `local`. This setting ensures that Terraform runs on your local machine and not on the Terraform Cloud machines.
   - **Auto-apply**: Set this to `Off`.
   - **Auto-apply Run Triggers**: Set this to `Off`.

6. **Update the Terraform block with your workspace configuration**:

   I have a configuration to create a Resource Group in Azure, here is what it looks like after adding the code above to it:

   ![1718746035840](https://raw.githubusercontent.com/kunlesanni/MyBlogPosts/main/2024/june/TerraformStateWithTFC/images/1718746035840.png)

7. **Login to Terraform Cloud**:

   Before running your Terraform commands, you need to authenticate to Terraform Cloud. Run `terraform login` as shown below (Note: do not expose your credentials like this in a real-world scenario). Find the different
