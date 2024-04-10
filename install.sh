#!/bin/bash

# 编译版本和架构
version="v4.0.3"
arch="amd64"

# 确保在项目的根目录中
cd ~/my-chatgpt-plus/build

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 在本地执行构建脚本
./build.sh $version $arch push

# SSH连接到服务器
ssh root@45.76.173.237 -A << EOF

    # 进入目录
    cd ~/chatgpt-plus

    # 拉取最新的代码
    git pull

    # 进入部署目录
    cd deploy

    # 停止并移除容器
    docker-compose down

    # 启动所有容器
    docker-compose up -d

EOF
