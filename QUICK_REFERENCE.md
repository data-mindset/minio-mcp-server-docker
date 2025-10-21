# Quick Reference - MinIO MCP Server

## ⚠️ Important: Environment Isolation

**The chatbot's code interpreter and MCP server run in SEPARATE environments!**

Files created by the chatbot are NOT accessible to the MCP server.

## ✅ Correct Patterns

### Upload Text Content
```
❌ DON'T: "Create report.txt then upload to MinIO"
✅ DO: "Create file report.txt in bucket mybucket with: content here"
```

### Upload JSON Data
```
❌ DON'T: "Generate data.json and upload it"
✅ DO: "Save this JSON to bucket mybucket as data.json: {\"key\": \"value\"}"
```

### Upload Images
```
❌ DON'T: "Generate image then upload to MinIO"
✅ DO: Upload manually to MinIO first, then organize with MCP
✅ OR: "Download image from [URL] and save to bucket X"
```

### Process and Upload
```
✅ DO: "Download data.csv from bucket source, analyze it, then create summary.txt in bucket dest with the results"
```

### Copy Between Buckets
```
✅ DO: "Copy file.pdf from bucket source to bucket destination"
```

## 📋 Command Cheat Sheet

| Task | Command Example |
|------|------------------|
| List buckets | `List all buckets` |
| List contents | `List contents of bucket echarts` |
| Create text file | `Create file notes.txt in bucket mybucket with: Hello World` |
| Create JSON | `Save this JSON to bucket data as config.json: {"port": 8080}` |
| Download file | `Download report.pdf from bucket reports` |
| Copy file | `Copy report.pdf from bucket temp to bucket archive` |
| Move file | `Move old-data.csv from bucket staging to bucket prod` |
| Get metadata | `Get metadata of file.pdf in bucket mybucket` |
| Get presigned URL | `Create a presigned URL for file.pdf in bucket mybucket` |
| Create bucket | `Create a bucket called new-bucket` |
| Tag file | `Tag file.pdf in bucket mybucket with type:report year:2024` |

## 🎯 Common Workflows

### Generate and Save Report
```
You: "Create file daily-report.txt in bucket reports with content: Sales: $10,000, Status: Complete"
```

### Download, Process, Save Results
```
You: "Download input.csv from bucket raw, analyze the data, and create results.json in bucket processed with the summary"
```

### Backup Files
```
You: "Copy all files from bucket production to bucket backup"
```

### Organize Images
```
You: "Copy photo.jpg from bucket uploads to bucket gallery"
You: "Tag photo.jpg in bucket gallery with: location:beach date:2024-01"
You: "Create a presigned URL for photo.jpg in bucket gallery"
```

## 💡 Pro Tips

1. **Use `text_to_object` for all text content** - Don't create files locally first
2. **MinIO is your primary storage** - Download → Process → Create new file
3. **For images:** Upload to MinIO first, then use MCP to organize
4. **Be specific in prompts** - Include bucket name and exact file name
5. **Check your work** - Use "List contents of bucket X" to verify

## 🔗 Full Documentation

- **Chatbot Solutions:** [CHATBOT_UPLOAD_SOLUTIONS.md](./CHATBOT_UPLOAD_SOLUTIONS.md)
- **Image Upload:** [IMAGE_UPLOAD_GUIDE.md](./IMAGE_UPLOAD_GUIDE.md)
- **Upload Guide:** [UPLOAD_GUIDE.md](./UPLOAD_GUIDE.md)
- **README:** [README.md](./README.md)

## 📞 Your MCP Server

- **URL:** `https://minio-mcp-server.onrender.com/mcp`
- **Type:** StreamableHTTP
- **Bucket:** echarts
- **Status:** Live ✅

## 🚀 Quick Start

1. Connect your MCP client to the URL above
2. Try: `List all buckets`
3. Then: `Create file test.txt in bucket echarts with: Hello from MCP!`
4. Verify: `List contents of bucket echarts`
