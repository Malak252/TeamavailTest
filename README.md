# Version-1 Project

A Node.js Express application that serves static files and provides API endpoints for saving history data. The application is containerized with Docker and includes CI/CD pipeline configurations.

## Features

- **Static File Serving**: Serves frontend files from the `public` directory
- **API Endpoints**: RESTful API for saving history data
- **File Management**: Serves input JSON files and output data
- **Docker Support**: Fully containerized application
- **CI/CD Ready**: Includes Jenkins pipeline and shell script for automated deployment

## Prerequisites

- Node.js 18+ (for local development)
- Docker (for containerized deployment)
- Docker Compose (for orchestrated deployment)

## Installation

### Local Development

1. Clone the repository:
```bash
git clone <repository-url>
cd version-1
```

2. Install dependencies:
```bash
npm install
```

3. Start the application:
```bash
npm start
```

The application will be available at `http://localhost:3000`

### Docker Deployment

#### Using Docker Compose (Recommended)

1. Build and run the application:
```bash
docker-compose up -d --build
```

The application will be available at `http://localhost:4040`

#### Using Docker directly

1. Build the Docker image:
```bash
docker build -t coolestv .
```

2. Run the container:
```bash
docker run -p 4040:3000 coolestv
```

## Project Structure

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
├── public/            # Static frontend files (not included in files)
├── input/             # Input JSON files directory
└── output/            # Output files directory (history.json)
```

## API Endpoints

### POST `/save-history`
Saves history data to `output/history.json`

**Request Body:**
```json
{
  "data": "your history data here"
}
```

**Response:**
- `200 OK`: "Saved" - History successfully saved
- `500 Internal Server Error`: "Failed to save history.json" - Error occurred

### Static File Routes

- **Frontend**: `GET /` - Serves static files from `public/` directory
- **Input Files**: `GET /input/*` - Serves JSON files from `input/` directory  
- **Output Files**: `GET /output/*` - Serves files from `output/` directory

## Environment Variables

The application uses the following environment variables:

- `NODE_ENV`: Set to `development` in Docker Compose configuration
- `PORT`: Application port (defaults to 3000)

## Development

### Scripts

- `npm start`: Start the production server
- `npm test`: Run tests (currently not implemented)

### File Structure

- **server.js**: Main application server with Express configuration
- **public/**: Frontend static files (HTML, CSS, JS)
- **input/**: Directory for input JSON files
- **output/**: Directory for generated output files

## Docker Configuration

### Dockerfile
- Based on `node:20-alpine` for lightweight deployment
- Exposes port 3000
- Copies package files first for better layer caching
- Installs dependencies and copies application code

### Docker Compose
- Maps host port 4040 to container port 3000
- Mounts current directory for development
- Sets `NODE_ENV=development`
- Configured with `restart: unless-stopped`

## CI/CD Pipeline

### Jenkins Pipeline (Jenkinsfile)
The project includes a Jenkins pipeline with the following stages:

1. **Checkout**: Retrieves source code from SCM
2. **Install Dependencies**: Runs `npm install`
3. **Build Docker Image**: Creates Docker image tagged as `coolestv`
4. **Deploy**: Runs application using Docker Compose

### Shell Script (ci.sh)
Alternative deployment script that:
- Installs Node.js dependencies
- Builds Docker image
- Launches application with Docker Compose

## Usage Examples

### Save History Data
```bash
curl -X POST http://localhost:4040/save-history \
  -H "Content-Type: application/json" \
  -d '{"timestamp": "2024-01-01", "action": "user_login"}'
```

### Access Input Files
```bash
curl http://localhost:4040/input/data.json
```

### Access Output Files
```bash
curl http://localhost:4040/output/history.json
```

## Troubleshooting

### Common Issues

1. **Port Already in Use**
   - Change the port mapping in `docker-compose.yml`
   - Or stop other services using port 4040

2. **Docker Build Fails**
   - Ensure Docker is running
   - Check that all required files are present

3. **Permission Errors**
   - Ensure the `output` directory exists and is writable
   - Check Docker volume permissions

### Logs

View application logs:
```bash
# Docker Compose
docker-compose logs -f

# Docker container
docker logs <container-id>
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the ISC License.

## Support

For issues and questions, please create an issue in the project repository.
