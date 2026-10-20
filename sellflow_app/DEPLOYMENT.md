# Quick Deployment Guide

## 🚀 Deploy to Vercel (3 Steps)

### 1️⃣ Run Deployment Script

```powershell
# From sellflow_app directory
.\deploy.ps1
```

**What this does:**
- Builds Flutter web app
- Deploys to Vercel automatically

### 2️⃣ Set New Project Name (First Time Only)

If prompted by Vercel CLI:
- **Project name:** `sellflow-sf`
- **Team:** `tsg-bfe6`

### 3️⃣ Get Your URL

After deployment, you'll see:
```
✔ Production: https://sellflow-sf.vercel.app
```

---

## 📋 Troubleshooting

### "flutter: command not found"

Add Flutter to PATH:
```powershell
$env:Path += ";C:\Users\Sajidul Haque Sajid\AppData\Local\flutter\flutter\bin"
```

Then run `deploy.ps1` again.

### Vercel Deployment Fails

Create a new project manually:
1. Go to https://vercel.com/new
2. Upload the `build/web` folder
3. Name it `sellflow-sf`

---

## 🔄 GitHub Auto-Deploy (Optional)

If you want automatic deploys on push to GitHub:

### 1. Add GitHub Secrets
Go to: https://github.com/twosidegroup-spec/sellflow-backend/settings/secrets/actions

Add:
- `VERCEL_TOKEN` (Get from: https://vercel.com/account/tokens)
- `VERCEL_PROJECT_ID` (Get from Vercel project settings)
- `VERCEL_ORG_ID` (Get from: `vercel ls --json`)
- `RENDER_API_URL` = `https://sellflow-backend-0nyn.onrender.com/api/v1`

### 2. Enable GitHub Actions
GitHub Actions workflow is already set up in `.github/workflows/vercel-deploy.yml`

Push to main and watch it deploy automatically!

---

## ✅ What You Have

- **Backend:** `https://sellflow-backend-0nyn.onrender.com/api/v1` ✅
- **Frontend:** Deploy to Vercel next ⬆️
