#!/bin/bash
# from https://docs.aws.amazon.com/efs/latest/ug/wt1-create-ec2-resources.html

# security group 4 ec2
aws ec2 create-security-group \
--region eu-west-1 \
--group-name efs-dataprocessing1-ec2-sg \
--description "Amazon EFS dataprocessing 1, SG for EC2 instance" \
--vpc-id vpc-87ad55fe


# security group 4 efs
aws ec2 create-security-group \
--region eu-west-1 \
--group-name efs-dataprocessing1-mt-sg \
--description "Amazon EFS dataprocessing 1, SG for mount target" \
--vpc-id vpc-87ad55fe

# access to ec2 instance group from everywhere
aws ec2 authorize-security-group-ingress \
--group-id sg-098669727548dcedd \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0 \
--region eu-west-1

# describe security group
aws ec2 describe-security-groups \
--region eu-west-1 \
--group-id sg-098669727548dcedd

# access to efs storrage from ec2 group
aws ec2 authorize-security-group-ingress \
--group-id sg-02778494bc39601d4 \
--protocol tcp \
--port 2049 \
--source-group sg-098669727548dcedd \
--region eu-west-1 

# get subnet id
aws ec2 describe-subnets \
--region eu-west-1 \
--filters "Name=vpc-id,Values=vpc-87ad55fe"

# run ec2 instance
aws ec2 run-instances \
--image-id ami-047bb4163c506cd98 \
--count 1 \
--instance-type t2.micro \
--associate-public-ip-address \
--key-name bfh_root.pem \
--security-group-ids sg-098669727548dcedd \
--subnet-id subnet-f66512ac \
--region eu-west-1


aws ec2 describe-instances \
--instance-ids i-09cb26ed64cdde683 \
--region eu-west-1

# ec2-54-75-53-151.eu-west-1.compute.amazonaws.com
# EFS ==========================================
aws efs create-file-system \
--creation-token FileSystemForDataprocessing1 \
--tags Key=Name,Value=Dataprocessing1 \
--region eu-west-1


# create mount target
aws efs create-mount-target \
--file-system-id fs-5ace1d90 \
--subnet-id subnet-f66512ac \
--security-group sg-02778494bc39601d4 \
--region eu-west-1


# On instance
sudo yum -y update
sudo reboot  # dont know why... like windows
sudo yum -y install nfs-utils
mkdir ~/efs-mount-point 
cd ~/efs-mount-point  
sudo chmod go+rw .

sudo mount -t nfs \
-o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-5ace1d90.efs.eu-west-1.amazonaws.com:/ \
~/efs-mount-point 

# CP from home to ec2 instance
scp -i bfh_root.pem \
/media/saibot/vortrag/bfh/buildings/*.tar \
ec2-user@54.75.53.151:/home/ec2-user/efs-mount-point/buildings/

