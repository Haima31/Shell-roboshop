#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-07c50cacebb7651f8"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "car" "shipping" "payment" "dispatch" "frontend")

ZONE_ID="Z07217861L8HXB4SGRF90"
DOMAIN_NAME="haima.site"

for instance in ${INSTANCES[@]}
do
  INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-07c50cacebb7651f8 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=test}]" --query "Instances[0].InstanceId" --output text)
if [ $instance != "frontend" ]
then
   IP=aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text
else
IP=aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text
fi
echo "$INSTANCE Ip address: $IP"
done