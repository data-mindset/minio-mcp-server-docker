# MinIO MCP Server - Docker Deployment

This repository contains the deployment configuration for running the [MinIO MCP Server (mcp-server-aistor)](https://github.com/minio/mcp-server-aistor) using Docker on Render.

The MCP (Model Context Protocol) server enables AI assistants to interact with MinIO/AIStor object storage through a standardized interface.

## Features

This deployment includes:
- ✅ StreamableHTTP transport for MCP communication
- ✅ Write operations enabled (`--allow-write` flag)
- ✅ Docker-based deployment for easy portability
- ✅ Health checks for service monitoring
- ✅ Automatic deployment via Render
- ✅ Environment-based configuration (no hardcoded secrets)

## Quick Deploy to Render

### Prerequisites

1. A GitHub account
2. A Render account (free tier available)
3. MinIO server credentials (endpoint, access key, secret key)

### Deployment Steps

1. **Fork this repository** to your GitHub account

2. **Create a new Web Service on Render:**
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Render will auto-detect the `render.yaml` configuration

3. **Configure Environment Variables:**
   
   In the Render dashboard, set the following environment variables:
   
   ```
   MINIO_ENDPOINT=your-minio-server.example.com
   MINIO_PORT=443
   MINIO_USE_SSL=true
   MINIO_ACCESS_KEY=your-access-key
   MINIO_SECRET_KEY=your-secret-key
   MINIO_BUCKET_NAME=your-bucket-name
   ```

4. **Deploy:**
   - Click "Create Web Service"
   - Render will build and deploy your service
   - Wait for the deployment to complete

5. **Get Your Service URL:**
   - Your MCP server will be available at: `https://your-service-name.onrender.com/mcp`

## Local Development

### Using Docker Compose

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/minio-mcp-docker.git
   cd minio-mcp-docker
   ```

2. **Create `.env` file:**
   ```bash
   cp .env.example .env
   ```

3. **Edit `.env` with your MinIO credentials:**
   ```bash
   nano .env  # or use your preferred editor
   ```

4. **Start the service:**
   ```bash
   docker-compose up -d
   ```

5. **Test the connection:**
   ```bash
   curl http://localhost:8090/mcp
   ```

6. **View logs:**
   ```bash
   docker-compose logs -f
   ```

7. **Stop the service:**
   ```bash
   docker-compose down
   ```

## Configuration

### Environment Variables

| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `MINIO_ENDPOINT` | MinIO server endpoint (without protocol) | Yes | `minio.example.com` |
| `MINIO_PORT` | MinIO server port | Yes | `443` |
| `MINIO_USE_SSL` | Use SSL/TLS connection | Yes | `true` |
| `MINIO_ACCESS_KEY` | MinIO access key (username) | Yes | `minio-admin` |
| `MINIO_SECRET_KEY` | MinIO secret key (password) | Yes | `your-secret-key` |
| `MINIO_BUCKET_NAME` | Default bucket name | No | `mybucket` |

### MCP Server Flags

This deployment includes the following flags:
- `--http`: Enable StreamableHTTP transport
- `--http-port 8090`: Listen on port 8090
- `--allow-write`: Enable write operations (create buckets, upload objects, etc.)

To modify flags, edit the `CMD` line in `Dockerfile`.

## Using with MCP Clients

### Cherry Studio (or other StreamableHTTP-compatible clients)

1. Open your MCP client settings
2. Add a new MCP server:
   - **Name:** MinIO AIStor
   - **Type:** StreamableHTTP
   - **URL:** `https://your-service-name.onrender.com/mcp`
3. Save and test the connection

### Example Queries

Once connected, you can use natural language to interact with your MinIO server:

- "List all buckets on my MinIO server"
- "List the contents of bucket echarts"
- "Upload file.pdf to bucket mybucket"
- "Get metadata of document.pdf in bucket mybucket"
- "Create a bucket called new-bucket"

## Available MCP Tools

The server provides the following tools:

**Read Operations:**
- `list_buckets` - List all buckets
- `list_bucket_contents` - List objects in a bucket
- `get_object_metadata` - Get object metadata
- `get_object_tags` - Get object tags
- `get_object_presigned_url` - Create presigned URL for an object
- `download_object` - Download an object

**Write Operations** (enabled in this deployment):
- `create_bucket` - Create a new bucket
- `upload_object` - Upload a file to a bucket
- `set_object_tags` - Set tags for an object
- `copy_object` - Copy an object
- `move_object` - Move an object

**AI Operations:**
- `ask_object` - Ask questions about object contents using AI

For the complete list of tools, see the [official documentation](https://github.com/minio/mcp-server-aistor).

## Security Notes

⚠️ **Important Security Information:**

- **Never commit `.env` files** containing real credentials
- All sensitive data is stored as environment variables in Render
- The repository contains only configuration templates
- Use strong, unique passwords for MinIO access keys
- Enable SSL/TLS for production deployments
- Consider using additional flags like `--allow-delete` only when necessary

## Troubleshooting

### Service Won't Start

1. Check Render logs for error messages
2. Verify all environment variables are set correctly
3. Ensure MinIO endpoint is accessible from Render servers
4. Confirm MinIO credentials are valid

### Health Check Failing

- The health check endpoint is `/mcp`
- Ensure port 8090 is properly exposed in the Dockerfile
- Check if the service is listening on the correct port

### Connection Timeout

- Verify `MINIO_ENDPOINT` doesn't include `https://` prefix
- Check firewall rules on your MinIO server
- Ensure MinIO server is accessible from public internet (if using Render)

## Additional Resources

- [MinIO MCP Server Documentation](https://github.com/minio/mcp-server-aistor)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [Render Documentation](https://render.com/docs)
- [MinIO Documentation](https://min.io/docs/)

## License

This deployment configuration follows the same license as the [mcp-server-aistor](https://github.com/minio/mcp-server-aistor) project.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
