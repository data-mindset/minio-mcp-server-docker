FROM quay.io/minio/aistor/mcp-server-aistor:latest

# Expose port for StreamableHTTP transport
EXPOSE 8090

# Health check for Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8090/mcp || exit 1

# Run the MCP server with StreamableHTTP transport and write permissions
CMD ["--http", "--http-port", "8090", "--allow-write"]
