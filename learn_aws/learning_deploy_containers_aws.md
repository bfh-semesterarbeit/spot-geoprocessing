# AWS CLI

<https://aws.amazon.com/cli/>



## ECR
Docker login on ecr
```bash
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 483277333869.dkr.ecr.eu-west-1.amazonaws.com/semesterarbeit
```

```bash
aws ecr list-images --repository-name semesterarbeit
```
