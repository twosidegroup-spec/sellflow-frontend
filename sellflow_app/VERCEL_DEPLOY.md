# Vercel Deployment Setup Guide

This guide helps you deploy your Flutter frontend to Vercel automatically via GitHub Actions.

## 📋 Quick Setup (5 Minutes)

### Step 1: Install Vercel CLI
```bash
npm install -g vercel
```

### Step 2: Login & Link Project
```bash
# Login to your account
vercel login

# Link the Flutter project to Vercel
cd sellflow_app
vercel link
```

### Step 3: Get Your Credentials

**From `vercel link` output:**
```
✔ Get information about your project? Yes
? Project URL https://sellflow-sf.vercel.app
? Project ID: <this-is-your-project-id>
? Team ID: <this-is-your-org-id>
```

**From Vercel Dashboard:**
1. Go to https://vercel.com/dashboard
2. Click on your project
3. Settings → API Tokens → Generate Token

### Step 4: Add GitHub Secrets

1. Go to your GitHub repo: `https://github.com/USERNAME/SELLFLOW/settings/secrets/actions`
2. Click **"New repository secret"**

| Name | Value |
|------|-------|
| `VERCEL_TOKEN` | Your Vercel API token (Step 3) |
| `VERCEL_ORG_ID` | Your team/org ID (from `vercel ls`) |
| `VERCEL_PROJECT_ID` | Your project ID (from `vercel link`) |
| `RENDER_API_URL` | `https://sellflow-backend-0nyn.onrender.com/api/v1` |

### Step 5: Deploy!

```bash
git add .
git commit -m "Deploy Flutter frontend to Vercel"
git push origin main
```

---

## 🔄 Automatic Deployment

After setup, **any push to `main`** will trigger:

1. ✅ Build Flutter web app
2. ✅ Deploy to Vercel
3. ✅ Generate production URL

Check results at: `https://github.com/USERNAME/SELLFLOW/actions`

---

## 🎯 Custom Domain

1. Go to your Vercel project → Settings → Domains
2. Add: `SELLFLOW-SF.vercel.app`
3. Click **Verify**

---

## 🐛 Troubleshooting

### Build Fails?
```bash
# Test locally first
flutter build web --release --dart-define=RENDER_API_URL=https://sellflow-backend-0nyn.onrender.com/api/v1
```

### GitHub Action Fails?
- Check that secrets are added correctly
- Verify Vercel token is active

### CORS Errors?
Add your Vercel URL to backend CORS settings:
```
CORS_ORIGINS=https://sellflow-sf.vercel.app
```

---

## ✅ Checklist

- [ ] Vercel CLI installed
- [ ] Logged into Vercel
- [ ] Project linked (`vercel link`)
- [ ] GitHub secrets added (4 secrets)
- [ ] Pushed to main
- [ ] Check GitHub Actions → Deployments
- [ ] Custom domain configured (optional)
