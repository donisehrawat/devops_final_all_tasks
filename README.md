create an ec2 instance

Install a webserver (Nginx)

Browse it using browser

![](media/image20.png)

Create a new VPC

create an instance inside that VPC

Map your Domain with your Nginx webserver

![](media/image13.png)

create ec2

install web app

add files

capture image

use image to configure launch template

use launch template to configure Auto Scaling
Group

•⁠ ⁠Policy to auto scale

![](media/image34.png)

Task 1 — EC2: Allow All Actions BUT Deny
Termination

Task 2 — S3: Allow Full Access to All Buckets BUT
Deny One Specific Bucket

Task 3 — EC2: Allow Start/Stop BUT Deny in Specific
Region

Task 4 — VPC: Allow VPC Creation BUT Deny Internet
Gateway Creation

Task 5 — S3: Deny Deletion BUT Allow Everything
Else

![](media/image29.png)

\s3 secure bucket

![](media/image25.png)

Only /images/\* publicly readable

All other objects private

Block public access except required access

PutObject only to uploads/\*

Deny DeleteObject

Deny uploads without encryption

Prevent deletion under finance/\*

…All this in bucket policy

{

"Version": "2012-10-17",

"Statement": \[

{

"Sid": "PublicReadImagesOnly",

"Effect": "Allow",

"Principal": "\*",

"Action": "s3:GetObject",

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/images/\*"

},

{

"Sid":
"AllowTrustedUploadsOnlyToUploadsPrefix",

"Effect": "Allow",

"Principal": {

"AWS": "arn:aws:iam::248263319485:root"

},

"Action": "s3:PutObject",

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/uploads/\*"

},

{

"Sid":
"DenyUploadsOutsideUploadsPrefixForTrustedPrincipals",

"Effect": "Deny",

"Principal": {

"AWS": "arn:aws:iam::248263319485:root"

},

"Action": "s3:PutObject",

"NotResource":
"arn:aws:s3:::donisehrawat-secure-248263319485/uploads/\*"

},

{

"Sid": "DenyObjectDeletion",

"Effect": "Deny",

"Principal": "\*",

"Action": \[

"s3:DeleteObjectVersion",

"s3:DeleteObject"

\],

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/\*"

},

{

"Sid": "DenyFinanceObjectDeletion",

"Effect": "Deny",

"Principal": "\*",

"Action": \[

"s3:DeleteObjectVersion",

"s3:DeleteObject"

\],

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/finance/\*"

},

{

"Sid": "DenyUnencryptedUploads",

"Effect": "Deny",

"Principal": "\*",

"Action": "s3:PutObject",

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/\*",

"Condition": {

"Null": {

"s3:x-amz-server-side-encryption": "true"

}

}

},

{

"Sid": "DenyUnsupportedUploadEncryption",

"Effect": "Deny",

"Principal": "\*",

"Action": "s3:PutObject",

"Resource":
"arn:aws:s3:::donisehrawat-secure-248263319485/\*",

"Condition": {

"StringNotEquals": {

"s3:x-amz-server-side-encryption": \[

"AES256",

"aws:kms"

\]

}

}

}

\]

}

Bucket versioning

![](media/image7.png)

Object Lock governance mode

![](media/image8.png)

Lifecycle rule for
uploads/\*![](media/image21.png)

![](media/image27.png)

Server access logging

![](media/image18.png)

Logs delivered to secure bucket

![](media/image22.png)

Logs bucket not public

![](media/image10.png)

S3 access logging

![](media/image30.png)

Static website hosting

![](media/image32.png)

Website working

![](media/image2.png)

IAM
groups/policies![](media/image14.png)

![](media/image11.png)

CloudWatch alarms +
SNS![](media/image6.png)

![](media/image26.png)

RDS primary + replica

![](media/image28.png)

DB subnet group

![](media/image12.png)

Hub-and-spoke VPCs

![](media/image24.png)

VPC peering

![](media/image17.png)

Route tables

![](media/image33.png)

S3 VPC endpoint

![](media/image16.png)

Private EC2 + no public IP

![](media/image4.png)

![](media/image1.png)

SSM state Manager

![](media/image9.png)

Centralized logging

![](media/image23.png)

![](media/image35.png)

ALB access logs

![](media/image15.png)

WAF rules

![](media/image5.png)

AMI backup

![](media/image19.png)

Auto Scaling Group

![](media/image3.png)

Route 53 failover

![](media/image31.png)
