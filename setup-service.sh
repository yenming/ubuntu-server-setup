# Download and import the Nodesource GPG key
echo "Download and import the Nodesource GPG key"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Create deb repository
echo "Create deb repository"
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Run Update and Install
echo "Run Update and Install"
sudo apt-get update
sudo apt-get install nodejs -y

# Make sure version
echo "Make sure version"
node -v
npm -v
git --version

# Install nginx
echo "Install nginx"
apt-get install nginx


# Install Docker
echo "Install Docker"
apt-get install docker.io
apt-get install docker-compose
