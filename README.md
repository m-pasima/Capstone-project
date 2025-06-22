# DevOps Capstone Web Application

This project provides a simple Java Spring Boot web application that can be deployed on AWS using the free tier. The infrastructure (EC2 Auto Scaling, ALB, RDS, CloudWatch, and CI/CD pipeline) should be created manually in the AWS console. The repository only contains the application code, a Maven build configuration, and notes on using Jenkins with SonarQube and Nexus for the pipeline.

## Application Overview

- **Language:** Java with Spring Boot
- **Pages:** Static HTML/CSS served from the `src/main/resources/static` folder
- **Health Check:** `GET /health` returns `OK`

## Local Development

1. Install Java 17 or newer and [Maven](https://maven.apache.org/).
2. Build and run the application:
   ```bash
   mvn package
   java -jar target/studentapp.war
   ```
3. Visit `http://localhost:8080` to see the application.

## Manual AWS Deployment Steps

### 1. Create a Key Pair
1. Open the EC2 console and create an SSH key pair for connecting to your instances.

### 2. Launch an EC2 Instance
1. Choose an Amazon Linux 2 AMI (free tier eligible).
2. Select a `t2.micro` instance type.
3. Attach the key pair created earlier and open port **80** and **8080** in the security group.
4. Install Java, Maven, and the application code on the instance.

### 3. Configure an Auto Scaling Group and Load Balancer
1. Create a launch template using the instance configuration above.
2. Create an Application Load Balancer (ALB) with a target group pointing to your instances on port 8080.
3. Create an Auto Scaling group linked to the launch template and target group.
4. Enable health checks using the `/health` endpoint.

### 4. Provision an RDS Instance
1. In the RDS console, create a MySQL database (free tier) with multi-AZ deployment enabled.
2. Configure connectivity so your EC2 instances can reach the database.
3. Store database credentials securely using AWS Secrets Manager or environment variables.

### 5. Set Up Monitoring
1. In CloudWatch, create alarms for CPU utilization and other metrics you wish to monitor.
2. Build a dashboard to visualize your application and database performance.

### 6. Build the CI/CD Pipeline
1. Launch a small EC2 instance and install Jenkins.
2. Create a Jenkins pipeline that checks out this repository.
3. Add stages to run `mvn package`, execute a SonarQube analysis, and upload `studentapp.war` to your Nexus repository.
4. Use `appspec.yml` and `scripts/restart.sh` in a final stage to deploy the artifact to your Auto Scaling group.

### 7. Optimize Costs
1. Use spot instances or reserved instances for the Auto Scaling group where appropriate.
2. Regularly review the AWS cost explorer to ensure you remain within the free tier limits.

## Additional Notes

- Ensure your security groups and IAM roles follow the principle of least privilege.
- The provided instructions focus on manual steps so you can learn the AWS console and how different services interact.

## License

MIT
