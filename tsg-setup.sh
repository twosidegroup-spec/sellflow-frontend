# ============================================
# TSG SERVER SETUP SCRIPT
# ============================================
# Run this on your VPS/Server

echo "========================================"
echo "  TSG SERVER SETUP"
echo "========================================"

# Step 1: Install Docker
echo "
[1/4] Installing Docker..."
curl -fsSL https://get.docker.com | sh
usermod -aG docker $USER
newgrp docker

# Step 2: Create TSG Directory
echo -e "\n[2/4] Creating TSG directory..."
mkdir -p /opt/tsg
cd /opt/tsg

# Step 3: Copy Files
echo -e "\n[3/4] Uploading project files..."
echo "  Use scp or git clone to get your code here:"
echo "  scp -r ./SELLFLOW/* root@your-server:/opt/tsg/"

# Step 4: Setup Environment
echo -e "\n[4/4] Setting up environment..."
cp .env.template .env
echo "  Edit .env with your secrets:"
echo "  nano .env"

echo -e "\n========================================"
echo "  SERVER SETUP COMPLETE"
echo "========================================"
echo -e "\nTo deploy:"
echo "  cd /opt/tsg"
echo "  docker-compose up -d --build"
echo "  docker-compose exec tsg-backend alembic upgrade head"
echo -e "\nTo access:"
echo "  Frontend: http://your-server-ip"
echo "  Backend:  http://your-server-ip:8000"
