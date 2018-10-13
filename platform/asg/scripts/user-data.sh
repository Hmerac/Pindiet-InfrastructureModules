#!/bin/bash

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo start amazon-ssm-agent

# Write ECS config file
mkdir -p /var/log/ecs /var/lib/ecs/data /etc/ecs && touch /etc/ecs/ecs.config
cat << EOF > /etc/ecs/ecs.config
ECS_DATADIR=/data
ECS_ENABLE_TASK_IAM_ROLE=true
ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
ECS_LOGFILE=/log/ecs-agent.log
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
ECS_LOGLEVEL=info
ECS_CLUSTER=${cluster_name}
ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=30m
EOF
