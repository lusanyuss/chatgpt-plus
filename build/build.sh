#!/bin/bash
# ./build.sh v4.0.2 amd64 push
version=$1
arch=${2:-amd64}

# build go api program
cd ../api
make clean amd64

# build web app
cd ../web
npm run build

cd ../build

docker login --username=312832473@qq.com --password=yl,870606 registry.cn-beijing.aliyuncs.com

#docker rmi -f registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-api:latest
docker build -t registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-api:latest -f dockerfile-api-go ../
#docker rmi -f registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-web:latest
docker build --platform linux/amd64 -t registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-web:latest -f dockerfile-vue ../

if [ "$3" = "push" ];then
  docker push registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-api:latest
  docker push registry.cn-beijing.aliyuncs.com/yuliu_geekmaster/chatgpt-plus-web:latest
fi
