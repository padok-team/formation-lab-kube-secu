# Exercise ~ Attacking a kubernetes cluster

Welcome to this Dojo !
Your goal is to exploit this kubernetes cluster to understand the risks linked to a non secure cluster implementation, and learn the maximum during this session.

That's why it is essential that:

- You experiment and try things that may break. Don't simply copy paste everything from StackOverflow until it passes the test !
- To keep moving or learn more, please _andon_! It means then whenever you have a question, a doubt, a feedback, call someone from the staff, we'll love to help you.

## Setup your env

First, you need to setup your computer for the dojo.

Start with cloning this repo:

```bash
git clone https://github.com/padok-team/dojo-terraform-aws-security
cd dojo-terraform-aws-security
```

### Connect to a distant VM

To work efficiently, you will work on a distant VM on which all the following tools are already installed.

- `git`: Version your code and collaborate
- [`aws CLI`](https://docs.aws.amazon.com/fr_fr/cli): The CLI to interact with AWS.

To connect to the VM:

- Install VSCode
- Add the following [Remote SSH extension](https://code.visualstudio.com/docs/remote/ssh) to VSCode

- Create a github account
- Create a SSH key on your Github account: [Add a ssh key documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- Share your handle Github with Padok's team member

- Launch a "Remote SSH Session" with VSCode extension via the command `ssh cs@<handleGithub>.cs.padok.school`

### Bootstrap the environment

To create the insecure infrastructure, follow these steps:

```bash
chmod +x access-deployments.sh
./access-deployments.sh

```

## Let's attack it !
## First attack scenario
Ready? Set. Go!

### Step 1 : Exploit the app

Check what the app contains and search how you can exploit the vulnerability.


<details>
  <summary>Hint 1</summary>

  How can you interact with the server ?
</details>

<details>
  <summary>Hint 2</summary>

  Try searching for ways to trigger a reverse shell with an image uploader. Check for CVE.

</details>

<details>
  <summary>Hint 3</summary>

  Have you heard of imagemagick ?
</details>

<details>
  <summary>Hint 4</summary>

  Check the CVE-2016-3714
</details>

### Step 2 : Pod access

<details>
  <summary>Hint 1</summary>
  
  Check the capabilities of the pod with capsh --print
</details>

<details>
  <summary>Hint 2</summary>

  How can you use privileged rights to escape a pod ?
</details>

<details>
  <summary>Hint 3</summary>
  
  Have you heard of docker escape ?
</details>

### Step 3 : What can you do when you have access to a node ?

<details>
  <summary>Hint 1</summary>
  
  Check the capabilities of the pod with capsh --print
</details>

<details>
  <summary>Hint 2</summary>

  How can you use privileged rights to escape a pod ?
</details>

<details>
  <summary>Hint 3</summary>
  
  Have you heard of docker escape ?
</details>

### Step 4 : What role is linked to the service account of the pod?

<details>
  <summary>Hint 1</summary>
  
  How are you able to manage a kubernetes cluster ?
</details>

<details>
  <summary>Hint 2</summary>

  Have you heard of authentication tokens ?
</details>

<details>
  <summary>Hint 3</summary>
  
  How can you steal the authentication token ?
</details>

## Second attack scenario
### Step 1 : Exploit the SSRF

Check what the app contains and search how you can exploit the vulnerability.


<details>
  <summary>Hint 1</summary>

  How can you interact with the server ?
</details>

<details>
  <summary>Hint 2</summary>

  Try searching for ways to trigger a reverse shell with an image uploader. Check for CVE.

</details>

### Step 2 : Node group IAM 

<details>
  <summary>Hint 1</summary>
  
  Check the capabilities of the pod with capsh --print
</details>

<details>
  <summary>Hint 2</summary>

  How can you use privileged rights to escape a pod ?
</details>

<details>
  <summary>Hint 3</summary>
  
  Have you heard of docker escape ?
</details>

### Step 3 : Read the content of the file in the bucket

<details>
  <summary>Hint 1</summary>
  
  Check the capabilities of the pod with capsh --print
</details>

<details>
  <summary>Hint 2</summary>

  How can you use privileged rights to escape a pod ?
</details>

<details>
  <summary>Hint 3</summary>
  
  Have you heard of docker escape ?
</details>

<details>
  <summary>Solutions Step 1</summary>

You can find solutions here:
  * [solution/step_1/main.tf](./solution/step_2/main.tf)
  * [solution/step_1/output.tf](./solution/step_2/output.tf)
  * [solution/step_1/dev.tfvars](./solution/step_2/dev.tfvars)
</details>


![final](./secure_architecture.png)

# LICENSE

© 2022 [Padok](https://www.padok.fr/).

Licensed under the [Apache License](https://www.apache.org/licenses/LICENSE-2.0), Version 2.0 ([LICENSE](./LICENSE))