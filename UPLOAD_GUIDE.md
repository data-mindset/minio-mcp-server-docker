# File Upload Guide - MinIO MCP Server

This guide explains how to upload files to MinIO using natural language prompts with the MCP server.

## Prerequisites

1. MCP server connected to your chatbot (Cherry Studio, Claude Desktop, etc.)
2. MinIO server accessible and credentials configured
3. File must be in an allowed directory

## Upload Methods

### Method 1: Direct Upload from Allowed Directory

**For Render Deployment (Limited):**

Since Render uses ephemeral storage, you need to:

1. First download or create files in the allowed directory (`/tmp/uploads`)
2. Then upload them to MinIO

**Example Workflow:**

```
You: "Download example.pdf from bucket source-bucket"
Bot: ✓ Downloaded example.pdf to /tmp/downloads

You: "Now upload example.pdf from downloads to bucket destination-bucket"
Bot: ✓ Uploaded example.pdf to bucket destination-bucket
```

### Method 2: Using Text-to-Object Tool

For text content, you can use the `text_to_object` tool:

**Example Prompts:**

```
You: "Create a file called notes.txt in bucket mybucket with content: This is my note"
Bot: ✓ Created notes.txt in bucket mybucket

You: "Save this JSON data to bucket analytics as data.json: {\"value\": 100}"
Bot: ✓ Created data.json in bucket analytics
```

### Method 3: Local Development Upload

**For Local Docker Compose Setup:**

1. Place your file in the local `./uploads/` directory:
   ```bash
   cp /path/to/your/file.pdf ./uploads/
   ```

2. Use natural language to upload:
   ```
   You: "Upload file.pdf from uploads directory to bucket echarts"
   Bot: ✓ Uploaded file.pdf to bucket echarts
   ```

3. The file will now be in your MinIO server!

## Natural Language Prompt Examples

### Basic Upload
```
"Upload report.pdf to bucket reports"
"Upload the document.txt file to bucket documents"
"Upload invoice-2024.pdf from uploads to bucket invoices"
```

### Upload with Tags
```
"Upload report.pdf to bucket reports with tags type:financial year:2024"
"Upload document.txt to bucket docs and tag it as draft"
```

### Upload with Metadata
```
"Upload image.jpg to bucket photos with content-type image/jpeg"
```

### Copy/Move Between Buckets
```
"Copy report.pdf from bucket source to bucket destination"
"Move document.txt from bucket old-docs to bucket new-docs"
```

## Complete Example Conversation

```
You: "List all buckets"
Bot: Here are your buckets:
     - echarts
     - reports
     - documents

You: "List contents of bucket echarts"
Bot: Objects in echarts:
     - chart1.png (45 KB)
     - data.json (2 KB)

You: "Download data.json from bucket echarts"
Bot: ✓ Downloaded data.json to /tmp/downloads/data.json

You: "Upload data.json from downloads to bucket reports"
Bot: ✓ Uploaded data.json to bucket reports

You: "Verify it's there - list contents of bucket reports"
Bot: Objects in reports:
     - data.json (2 KB)
     ✓ Upload successful!
```

## Important Notes

### For Render Deployment

⚠️ **Ephemeral Storage Limitation:**
- Files in `/tmp/downloads` and `/tmp/uploads` are temporary
- They're deleted when the container restarts
- Best for: temporary operations, copy/move between buckets

💡 **Recommended Approach:**
- Use MinIO as your primary storage
- Download → Process → Upload workflow
- Use `text_to_object` for creating text files directly

### For Local Development

✅ **Persistent Storage:**
- Files in `./uploads/` and `./downloads/` persist on your computer
- Perfect for testing and development
- Can upload files from your local filesystem

## Available Tools

The MCP server provides these file operation tools:

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `upload_object` | Upload file to bucket | "Upload file.pdf to bucket mybucket" |
| `download_object` | Download file from bucket | "Download file.pdf from bucket mybucket" |
| `text_to_object` | Create text/JSON object | "Create notes.txt in bucket mybucket with: Hello" |
| `copy_object` | Copy between buckets | "Copy file.pdf from bucket A to bucket B" |
| `move_object` | Move between buckets | "Move file.pdf from bucket A to bucket B" |
| `list_local_files` | List files in allowed dirs | "List files in uploads directory" |

## Troubleshooting

### "File not found" Error
```
Problem: The file doesn't exist in the allowed directory
Solution: First download it or ensure it's in ./uploads/ (local) or /tmp/uploads (Render)
```

### "Access denied to directory" Error
```
Problem: Trying to access a directory outside allowed directories
Solution: Only /tmp/downloads and /tmp/uploads are accessible
```

### "Bucket not found" Error
```
Problem: Target bucket doesn't exist
Solution: Create bucket first: "Create a bucket called mybucket"
```

## Security Best Practices

1. **Only allow necessary permissions**
   - Remove `--allow-delete` if not needed
   - Be cautious with `--allow-admin`

2. **Use specific prompts**
   - Specify exact file names and bucket names
   - Review what the bot plans to do before confirming

3. **Monitor uploads**
   - Check bucket contents after upload
   - Use: "List contents of bucket mybucket"

## Quick Reference

### Upload Workflow (Local)
```bash
# 1. Place file in uploads directory
cp myfile.pdf ./uploads/

# 2. Tell chatbot to upload
"Upload myfile.pdf from uploads to bucket mybucket"

# 3. Verify
"List contents of bucket mybucket"
```

### Upload Workflow (Render)
```
# 1. Download or create file first
"Download source.pdf from bucket temp"

# 2. Upload to destination
"Upload source.pdf from downloads to bucket archive"

# 3. Verify
"List contents of bucket archive"
```

### Direct Text Upload
```
"Create file hello.txt in bucket mybucket with content: Hello World!"
```

## Advanced Usage

### Batch Operations
```
You: "Copy all files from bucket source to bucket backup"
Bot: I'll copy each file individually:
     ✓ Copied file1.pdf
     ✓ Copied file2.jpg
     ✓ Copied file3.txt
     Done! 3 files copied.
```

### With Metadata
```
You: "Upload report.pdf to bucket reports and set tags: department:sales quarter:Q1"
Bot: ✓ Uploaded report.pdf with tags
```

## Need Help?

If uploads aren't working:

1. Check if file exists: "List files in uploads directory"
2. Check bucket exists: "List all buckets"
3. Check credentials: "Show server health status" (if --allow-admin enabled)
4. Check Render logs for errors

## Examples by Use Case

### Document Management
```
"Upload contract.pdf to bucket legal-docs with tags: status:pending year:2024"
"Download contract.pdf from bucket legal-docs"
"Copy contract.pdf from bucket legal-docs to bucket archive"
```

### Data Pipeline
```
"Download raw-data.csv from bucket input"
"Upload processed-data.csv from downloads to bucket output"
"Tag processed-data.csv in bucket output with status:processed"
```

### Backup & Archive
```
"Copy all files from bucket active to bucket backup"
"Move old-report.pdf from bucket active to bucket archive"
```

---

**Remember:** Natural language is powerful! The MCP server understands intent, so you can phrase your requests naturally.
