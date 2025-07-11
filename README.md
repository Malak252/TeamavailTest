# Team Availability Tracker - CI/CD Pipeline Project

A Node.js Express application with Docker containerization and CI/CD pipeline.

**## Resources helped me with the task**
https://www.youtube.com/watch?v=tK9Oc6AEnR4&ab_channel=freeCodeCamp.org
https://www.youtube.com/watch?v=dfTco9hmXEM&ab_channel=RoadsideCoder
https://www.youtube.com/watch?v=l5k1ai_GBDE&ab_channel=TechWorldwithNana
https://www.youtube.com/watch?v=Op5jZTQaUgo&ab_channel=CloudKode  
https://www.youtube.com/watch?v=RFOAPeJiTwU&ab_channel=S3CloudHub

**## Project Tasks**
1. **Set Up the Project**                                                                         [Done]
   -  Clone the project repository.
   -  Create a `.gitignore` file if missing.
   -  Install the required dependencies locally.
2. **Write a Bash Script (`ci.sh`)**                                                              [Done]
   This script should:
   -  Run code formatting and linting.
   -  Run tests.
   -  Build a Docker image of the application.
   -  Start the application using Docker Compose.
3. **Dockerize the App**                                                                          [Done]
   -  Write a `Dockerfile` to build the application image.
   -  Use best practices for image building (e.g., smaller base images, clean layers).
4. **Use Docker Compose**                                                                         [Done]
   -  Create a `docker-compose.yml` file.
   -  Include the app and any required services like Redis or PostgreSQL.
   -  Configure volumes and ports properly.
5. **Validate and Document**                                                                      [Done]
   -  Run your full pipeline locally to ensure it works.
   -  Create a `README.md` file that explains:
     -  How to run the app locally.
     -  How your pipeline works.
     -  What each part of your code and setup does.

**## Steps**

**How to write ci.sh file**
1. echo $SHELL >> output is first line in our file "path"
2. set -e >> that line tells bash to immediately stop if any command fails
3. after that you write what u would like to run in your CMD
4. to run "./ci.sh" u should run "chmod u+x ci.sh" first

**why .gitignore**
1. Here I add the files that I don't want to push
   - node_modules/
   - .env
   - .DS_Store

**why .dockerignore**
1. so that I don't copy certain files (in my case node_modules)

**Docker**
**Dockerfile**
- FROM node:20-alpine >> lightweight base image
- WORKDIR /app >> set working directory
- COPY package*.json ./ >> copy package files first for better caching
- RUN npm install >> install dependencies
- COPY . . >> copy application code
- EXPOSE 3000 >> 3000 is the port my app exposed on
- CMD ["npm","start"] >> start the application

**docker-compose.yml**
- services: app >> define the app service
- build: . >> build from current directory
- ports: "4040:3000" >> map host port 4040 to container port 3000
- environment: NODE_ENV=development >> set environment variable
- restart: unless-stopped >> restart policy

**Jenkins Pipeline**
**Jenkinsfile**
- pipeline with agent any >> run on any available agent
- stages: checkout, install dependencies, build docker image, run docker compose
- post actions: success and failure messages

**Terraform**
**main.tf**
- provider: docker >> use Docker provider
- docker_network: teamavail_network >> create custom network
- docker_image: coolestv >> build image from Dockerfile
- docker_container: app >> deploy container with proper configuration

**## Project Structure**
```
version-1/
├── server.js              # Main Express server
├── package.json          # Node.js dependencies and scripts
├── package-lock.json     # Lockfile for dependencies
├── Dockerfile           # Docker configuration
├── docker-compose.yml   # Docker Compose configuration
├── Jenkinsfile         # Jenkins CI/CD pipeline
├── ci.sh              # Bash script for CI/CD
├── .gitignore         # Git ignore rules
├── .dockerignore      # Docker ignore rules
├── terraform/         # Terraform infrastructure configuration
│   └── main.tf        # Main Terraform configuration
├── public/            # Static frontend files
├── input/             # Input JSON files directory
└── output/            # Output files directory (history.json)
```

**## How to run the app locally**

**Local Development**
```bash
npm install
npm start
```
App available at: http://localhost:3000

**Using Docker Compose**
```bash
docker-compose up -d --build
```
App available at: http://localhost:4040

**Using CI Script**
```bash
chmod +x ci.sh
./ci.sh
```

**Using Terraform**
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

**## How the pipeline works**

**ci.sh Script Flow:**
1. #!/bin/bash >> defines shell interpreter
2. set -e >> exit on any command failure
3. echo "installing dependencies" >> install npm packages
4. echo "building docker image" >> build Docker image tagged as 'coolestv'
5. echo "launching app with docker Compose" >> start with docker-compose

**Jenkins Pipeline Flow:**
1. **checkout** >> get source code from SCM
2. **install dependencies** >> npm install
3. **build docker image** >> docker build -t coolestv .
4. **run docker compose** >> docker compose up -d --build
5. **post actions** >> success/failure messages

**## API Endpoints**

**POST `/save-history`**
- Saves history data to output/history.json
- Request: JSON with data field
- Response: "Saved" or error message

**Static Routes:**
- GET / >> serves public/ directory
- GET /input/* >> serves input/ JSON files
- GET /output/* >> serves output/ files

**## Environment Variables**
- NODE_ENV: development (set in docker-compose)
- PORT: 3000 (default application port)

**## Troubleshooting**

**Common Issues:**
1. **Port 4040 already in use** >> change port in docker-compose.yml
2. **Docker build fails** >> ensure Docker is running and files exist
3. **Permission errors** >> check output directory permissions
4. **ci.sh won't run** >> run chmod +x ci.sh first

**View Logs:**
```bash
# Docker Compose
docker-compose logs -f

# Specific container
docker logs coolestv
```

**## What each part does**

**server.js** >> Express application with static file serving and API endpoints
**package.json** >> Node.js dependencies and scripts configuration
**Dockerfile** >> Instructions to build the application Docker image
**docker-compose.yml** >> Orchestration configuration for running containers
**Jenkinsfile** >> CI/CD pipeline definition for automated deployment
**ci.sh** >> Bash script for manual deployment automation
**.gitignore** >> Files to exclude from Git version control
**.dockerignore** >> Files to exclude from Docker build context
**terraform/main.tf** >> Infrastructure as Code for Docker deployment

**## License**
ISC License
