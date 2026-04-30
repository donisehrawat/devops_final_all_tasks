# ALB Module

This module creates:

- public Application Load Balancer
- target group
- listener on port 80
- launch template
- Auto Scaling Group in private subnets
- Nginx installation using user data
- security group for ALB
- security group for EC2

Traffic flow:

```text
Internet -> ALB -> EC2 instances in private subnets
```
