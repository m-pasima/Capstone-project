#!/bin/bash
pkill -f 'java -jar' || true
nohup java -jar /home/ec2-user/app/*.war > /home/ec2-user/app/app.log 2>&1 &
