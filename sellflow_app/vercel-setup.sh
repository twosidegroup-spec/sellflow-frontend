#!/bin/bash

echo "========================================"
echo "  Vercel Setup Guide"
echo "========================================"

echo -e "\nStep 1: Login to Vercel"
echo "  Run: vercel login"

echo -e "\nStep 2: Get Your Project Info"
echo "  Run: vercel ls"

echo -e "\nStep 3: Get Your Org ID"
echo "  Run: vercel ls --json"

echo -e "\nStep 4: Get Vercel Token"
echo "  Visit: https://vercel.com/account/tokens"

echo -e "\n========================================"
echo "  Store These Secrets in GitHub"
echo "========================================"

echo -e "\nGitHub Secrets Location:"
echo "  https://github.com/USERNAME/REPO/settings/secrets/actions"

echo -e "\nRequired Secrets:"
echo "  VERCEL_TOKEN        - Your Vercel API token"
echo "  VERCEL_ORG_ID     - Your organization ID"
echo "  VERCEL_PROJECT_ID - The project ID"
echo "  RENDER_API_URL    - https://sellflow-backend-0nyn.onrender.com/api/v1"

echo -e "\n========================================"
echo "  After Adding Secrets"
echo "========================================"

echo -e "\n  Then push to main:"
echo "  git add ."
echo "  git commit -m 'Deploy Flutter frontend'"
echo "  git push origin main"

echo -e "\nGitHub Actions will automatically deploy to Vercel!"
