# Deployment Guide

This guide will help you deploy the Knowledge Graph Extractor to various platforms for your portfolio.

## 🚀 Quick Deploy Options

### Option 1: Render (Recommended for Portfolios)

**Why Render?**
- ✅ Free tier available
- ✅ Easy setup
- ✅ Automatic HTTPS
- ✅ Great for portfolios

**Steps:**

1. **Sign up at [Render.com](https://render.com)**

2. **Set up Neo4j Database:**
   - Option A: Use [Neo4j Aura Free Tier](https://neo4j.com/cloud/aura/) (Recommended)
     - Sign up for free Neo4j Aura account
     - Create a free database instance
     - Copy the connection URI (looks like: `neo4j+s://xxxxx.databases.neo4j.io`)
   
   - Option B: Deploy Neo4j on Render (separate service)
     - Create a new "Web Service" on Render
     - Use Docker image: `neo4j:5-community`
     - Set environment variables in Render dashboard

3. **Deploy the FastAPI App:**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name**: `knowledge-graph-extractor`
     - **Environment**: `Python 3`
     - **Build Command**: 
       ```bash
       pip install -r requirements.txt && pip install baml-py baml-cli && baml-cli generate
       ```
     - **Start Command**: 
       ```bash
       uvicorn app:app --host 0.0.0.0 --port $PORT
       ```

4. **Set Environment Variables in Render:**
   - `GEMINI_API_KEY` - Your Google AI API key
   - `NEO4J_URI` - Your Neo4j connection URI (from step 2)
   - `NEO4J_USER` - Usually `neo4j`
   - `NEO4J_PASSWORD` - Your Neo4j password
   - `PORT` - Render sets this automatically

5. **Deploy!**
   - Click "Create Web Service"
   - Wait for deployment (5-10 minutes)
   - Your app will be live at: `https://your-app-name.onrender.com`

---

### Option 2: Railway

**Why Railway?**
- ✅ $5 free credit/month
- ✅ Excellent Docker support
- ✅ Easy database setup

**Steps:**

1. **Sign up at [Railway.app](https://railway.app)**

2. **Create a new project from GitHub**

3. **Add Neo4j:**
   - Click "+ New" → "Database" → "Add Neo4j"
   - Railway will provide connection details automatically

4. **Configure your app:**
   - Railway auto-detects Python
   - Add build command: `pip install -r requirements.txt && pip install baml-py baml-cli && baml-cli generate`
   - Start command: `uvicorn app:app --host 0.0.0.0 --port $PORT`

5. **Set Environment Variables:**
   - `GEMINI_API_KEY`
   - Railway auto-sets `NEO4J_URI`, `NEO4J_USER`, `NEO4J_PASSWORD` from the database

6. **Deploy!**

---

### Option 3: Fly.io

**Why Fly.io?**
- ✅ Free tier
- ✅ Great for Docker
- ✅ Global edge deployment

**Steps:**

1. **Install Fly CLI:**
   ```bash
   curl -L https://fly.io/install.sh | sh
   ```

2. **Create a Dockerfile** (see below)

3. **Deploy:**
   ```bash
   fly launch
   fly secrets set GEMINI_API_KEY=your-key
   fly deploy
   ```

---

## 📋 Pre-Deployment Checklist

- [ ] Get Google AI API key from [Google AI Studio](https://aistudio.google.com/)
- [ ] Set up Neo4j database (Aura free tier recommended)
- [ ] Test locally with `uv run python app.py`
- [ ] Ensure `baml-cli generate` runs successfully
- [ ] Check that all environment variables are set

## 🔧 Environment Variables Needed

```bash
GEMINI_API_KEY=your-google-ai-api-key
NEO4J_URI=bolt://your-neo4j-instance:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your-password
PORT=8000  # Usually set automatically by platform
```

## 🐳 Docker Deployment (Optional)

If you want to use Docker, create a `Dockerfile`:

```dockerfile
FROM python:3.13-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install baml-py baml-cli

# Copy project files
COPY . .

# Generate BAML client
RUN baml-cli generate

# Expose port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
```

## 📝 Post-Deployment

1. **Test your deployed app:**
   - Visit the URL provided by your platform
   - Try extracting a knowledge graph
   - Verify Neo4j connection works

2. **Add to your portfolio:**
   - Add the live link to your resume
   - Include in your GitHub README
   - Mention in your portfolio website

3. **Monitor:**
   - Check Render/Railway dashboard for logs
   - Monitor API usage (Google AI has free tier limits)
   - Keep an eye on Neo4j database usage

## 🆘 Troubleshooting

**Build fails:**
- Check that `baml-cli generate` runs in build command
- Verify all dependencies in `requirements.txt`

**App crashes:**
- Check environment variables are set correctly
- Verify Neo4j connection string format
- Check logs in platform dashboard

**Neo4j connection fails:**
- Verify URI format (bolt:// vs neo4j+s://)
- Check credentials are correct
- Ensure database is running

## 💡 Tips for Portfolio

- Use a custom domain (Render/Railway support this)
- Add a nice README with live demo link
- Include screenshots in your GitHub repo
- Document the tech stack clearly
- Add a "Try it live" badge to your README

---

**Need help?** Check the platform's documentation or open an issue on GitHub.

