#!/bin/bash

# Auto-configures GitHub repo for Vercel deployment

set -e

echo "========================================"
echo "  SellFlow Setup Script"
echo "========================================"

echo -e "\n1️⃣  Check if Vercel CLI is installed..."
if ! command -v vercel &> /dev/null; then
    echo "  Installing Vercel CLI..."
    npm install -g vercel
else
    echo "  ✓ Vercel CLI already installed"
fi

echo -e "\n2️⃣  Login to Vercel..."
vercel login

echo -e "\n3️⃣  Get your project info..."
vercel ls

echo -e "\n4️⃣  Link this project to Vercel..."
vercel link

echo -e "\n5️⃣  Add GitHub Secrets..."
echo ""
echo "Go to: https://github.com/USERNAME/SELLFLOW/settings/secrets/actions"
echo ""
echo "Add these secrets:"
echo "  VERCEL_TOKEN        = (from vercel link output or https://vercel.com/account/tokens)"
echo "  VERCEL_ORG_ID     = (from vercel ls --json)"
echo "  VERCEL_PROJECT_ID = (from vercel ls --json)"
echo "  RENDER_API_URL    = https://sellflow-backend-0nyn.onrender.com/api/v1"
echo ""

echo -e "\n6️⃣  Push to GitHub to trigger deployment..."
echo "  git add ."
echo "  git commit -m 'Deploy Flutter frontend to Vercel'"
echo "  git push origin main"

echo -e "\n========================================"
echo "  After push, check GitHub Actions tab!"
echo "========================================"
