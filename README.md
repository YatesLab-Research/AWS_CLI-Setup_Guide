
# The AWS Command Line Interface (AWS CLI)

The AWS CLI is an open source tool that enables you to interact with AWS services using commands in your command-line shell. With minimal configuration, the AWS CLI allows you to start running commands that replicate functionality provided by the browser-based AWS Management Console.  
👉 [More info here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)

---

## ✅ Prerequisites

To access AWS services with the AWS CLI, you need:
- An AWS account
- IAM credentials

⚠️ Avoid using your root credentials. Instead, create a user with least-privilege access for enhanced security.

---

## 🔧 Step 1: Install AWS CLI v2

### 📦 For Linux

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### ✅ Confirm installation

```bash
aws --version
```

---

### 🖥️ For Windows

1. Download and run the [AWS CLI MSI installer](https://awscli.amazonaws.com/AWSCLIV2.msi)
2. Confirm installation:

```powershell
C:\> aws --version
```

---

## 🔐 Step 2: Configure AWS CLI with IAM Identity Center (SSO)

1. Sign in to the **AWS Access Portal** (link provided by JH IT via email).
2. In the **Accounts** tab, select:  
   `jh-awslza-yates-lab-Clayton-Yates-90112037`
3. Next to **JH-RIT-S3-User-Updated**, click **Access keys**.
4. In the dialog box, choose your operating system: **Mac/Linux** or **Windows**.
5. Select **IAM Identity Center credentials (Recommended)** and note:
   - `SSO Start URL`
   - `SSO Region`

6. In your terminal, run:

```bash
aws configure sso
```

7. Provide the prompts:

```bash
SSO session name (Recommended): my-sso
SSO start URL: <paste from step 5>
SSO region: us-east-1
SSO registration scopes: sso:account:access
```

8. If the browser window does not open automatically, copy and paste the provided URL to complete authentication.

9. Back in the terminal, choose the role:  
   `JH-RIT-S3-User-Updated`

10. Finish configuration:

```bash
Default client Region [None]: us-east-1
CLI default output format [None]: text
Profile name [None]: yateslab
```

---

## 🚀 Step 3: Upload Data from Your PC or External Drive to AWS S3

1. Identify the local folder path (e.g., `/mnt/e/Maryland_RNA-seq/`).
2. Go to the `rit-yates-lab-sa1` bucket via the AWS portal.
3. Create a new folder inside the bucket (use underscores `_` or hyphens `-`; avoid spaces).
4. Select the folder and click **Copy S3 URL**, e.g.:  
   `s3://rit-yates-lab-sa1/Maryland_RNA-seq/`
5. In your terminal, run:

```bash
aws s3 sync /path/to/local/file/or/folder/ s3://bucket-name/folder/ --profile yateslab --exact-timestamps > upload.log 2>&1
```

### ✅ Example:

```bash
aws s3 sync /mnt/e/RNA-seq/ s3://rit-yates-lab-sa1/RNA-seq/ --profile yateslab --exact-timestamps > upload.log 2>&1
```

## Alternatively
Use `aws_cli_S3_upload.sh`

This script uploads files from a local directory to an AWS S3 bucket using `aws s3 sync`, with exact timestamp handling and SHA256 checksum validation.

## Configuration

Edit the following variables in the script:

- `SOURCE_DIR`: Absolute path to the directory you want to upload
- `DEST_S3`: Full S3 URI where the files should go
- `PROFILE`: AWS CLI profile with write access to the S3 bucket

## Usage

1. Make the script executable:
   ```bash
   chmod +x aws_cli_S3_upload.sh
   ```

2. Run the script:
   ```bash
   chmod +x aws_cli_S3_upload.sh
   ```
## Requirements
-AWS CLI v2.7.0 or later (for  `--checksum-algorithm `)

-Bash shell environment

---

## 📡 Monitor Upload Progress

```bash
tail -f upload.log
```
#### The 'aws s3 sync' command is a powerful and efficient way to upload files to S3, as it only transfers new or modified files, making it ideal for large datasets and safe to re-run without duplicating data.

---

## ⚠️ Token Expiry Note

If you see this error:

```bash
An error occurred (ExpiredToken): The security token included in the request is expired
```

Repeat **Step 2 (6–10)** and then re-run your upload (**Step 3**). 

---

## 📬 Need Help?

- Email: [smwambu1@jh.edu](mailto:smwambu1@jh.edu)  
- Phone: 571-234-7722

☕ While the data is migrating, drink a glass of water or a shot of coffee! 
  
  ### Remember to load your data in batches- tends to upload faster.
  ### I will update this document regularly as I discover more tricks.

---

## 📚 Reference

[AWS CLI Official Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
