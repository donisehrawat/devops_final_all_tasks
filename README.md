create an ec2 instance  
Install a webserver (Nginx)  
Browse it using browser  
![][image1]

 Create a new VPC  
create an instance inside that VPC  
Map your Domain with your Nginx webserver

![][image2]

create ec2   
install web app  
add files  
capture image   
use image to configure launch template  
use launch template to configure Auto Scaling Group  
•⁠  ⁠Policy to auto scale

![][image3]

Task 1 — EC2: Allow All Actions BUT Deny Termination  
Task 2 — S3: Allow Full Access to All Buckets BUT Deny One Specific Bucket  
Task 3 — EC2: Allow Start/Stop BUT Deny in Specific Region  
Task 4 — VPC: Allow VPC Creation BUT Deny Internet Gateway Creation  
Task 5 — S3: Deny Deletion BUT Allow Everything Else  
![][image4]  
\\s3 secure bucket

![][image5]

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
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/images/\*"  
        },  
        {  
            "Sid": "AllowTrustedUploadsOnlyToUploadsPrefix",  
            "Effect": "Allow",  
            "Principal": {  
                "AWS": "arn:aws:iam::248263319485:root"  
            },  
            "Action": "s3:PutObject",  
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/uploads/\*"  
        },  
        {  
            "Sid": "DenyUploadsOutsideUploadsPrefixForTrustedPrincipals",  
            "Effect": "Deny",  
            "Principal": {  
                "AWS": "arn:aws:iam::248263319485:root"  
            },  
            "Action": "s3:PutObject",  
            "NotResource": "arn:aws:s3:::donisehrawat-secure-248263319485/uploads/\*"  
        },  
        {  
            "Sid": "DenyObjectDeletion",  
            "Effect": "Deny",  
            "Principal": "\*",  
            "Action": \[  
                "s3:DeleteObjectVersion",  
                "s3:DeleteObject"  
            \],  
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/\*"  
        },  
        {  
            "Sid": "DenyFinanceObjectDeletion",  
            "Effect": "Deny",  
            "Principal": "\*",  
            "Action": \[  
                "s3:DeleteObjectVersion",  
                "s3:DeleteObject"  
            \],  
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/finance/\*"  
        },  
        {  
            "Sid": "DenyUnencryptedUploads",  
            "Effect": "Deny",  
            "Principal": "\*",  
            "Action": "s3:PutObject",  
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/\*",  
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
            "Resource": "arn:aws:s3:::donisehrawat-secure-248263319485/\*",  
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

![][image6]

Object Lock governance mode

![][image7]

Lifecycle rule for uploads/\*![][image8]

![][image9]

Server access logging

![][image10]

Logs delivered to secure bucket

![][image11]

Logs bucket not public

![][image12]

S3 access logging

![][image13]

Static website hosting

![][image14]

Website working

![][image15]

IAM groups/policies![][image16]  
![][image17]

CloudWatch alarms \+ SNS![][image18]  
![][image19]

RDS primary \+ replica

![][image20]

DB subnet group  
![][image21]

Hub-and-spoke VPCs

![][image22]  
VPC peering  
![][image23]

Route tables  
![][image24]

S3 VPC endpoint

![][image25]

Private EC2 \+ no public IP

![][image26]  
![][image27]

SSM state Manager  
![][image28]

Centralized logging  
![][image29]  
![][image30]

ALB access logs  
![][image31]

WAF rules

![][image32]

AMI backup  
![][image33]

Auto Scaling Group  
![][image34]

Route 53 failover  
![][image35]

[image1]: images/image1.png

[image2]: images/image2.png

[image3]: images/image3.png

[image4]: images/image4.png

[image5]: images/image5.png

[image6]: images/image6.png

[image7]: images/image7.png

[image8]: images/image8.png

[image9]: images/image9.png

[image10]: images/image10.png

[image11]: images/image11.png

[image12]: images/image12.png

[image13]: images/image13.png

[image14]: images/image14.png

[image15]: images/image15.png

[image16]: images/image16.png

[image17]: images/image17.png

[image18]: images/image18.png

[image19]: images/image19.png

[image20]: images/image20.png

[image21]: images/image21.png

[image22]: images/image22.png

[image23]: images/image23.png

[image24]: images/image24.png

[image25]: images/image25.png

[image26]: images/image26.png

[image27]: images/image27.png

[image28]: images/image28.png

[image29]: images/image29.png

[image30]: images/image30.png

[image31]: images/image31.png

[image32]: images/image32.png

[image33]: images/image33.png

[image34]: images/image34.png

[image35]: images/image35.png