#!/usr/bin/env bash

echo "========请先参考OCR项目相关说明准备好编译环境========"
echo

echo "========编译选项========"
echo "请输入编译选项并回车: 1)Release, 2)Debug"
read -p "" BUILD_TYPE
if [ $BUILD_TYPE == 1 ]; then
  BUILD_TYPE=Release
elif [ $BUILD_TYPE == 2 ]; then
  BUILD_TYPE=Debug
else
  echo -e "输入错误！Input Error!"
fi

echo "请选择要使用的lib库选项并回车: 1)CPU，2)GPU"
read -p "" BUILD_VULKAN
if [ $BUILD_VULKAN == 1 ]; then
  BUILD_VULKAN="CPU"
elif [ $BUILD_VULKAN == 2 ]; then
  BUILD_VULKAN="GPU"
else
  echo -e "输入错误！Input Error!"
fi

sysOS=$(uname -s)
NUM_THREADS=1
if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
else
  echo "Other OS: $sysOS"
fi

mkdir -p $sysOS-$BUILD_VULKAN
pushd $sysOS-$BUILD_VULKAN

echo "cmake -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DOCR_VULKAN=$BUILD_VULKAN .."
cmake -DCMAKE_INSTALL_PREFIX=install -DOCR_VULKAN=$BUILD_VULKAN ..
cmake --build . --config $BUILD_TYPE -j $NUM_THREADS
cmake --build . --config $BUILD_TYPE --target install
popd

echo "========输出文件夹:$sysOS-$BUILD_VULKAN/install========"
echo "请运行输出文件夹内的run-test.sh脚本进行测试"
echo "cd $sysOS-$BUILD_VULKAN/install"
echo "chmod a+x run-test.sh"
echo "./run-test.sh"
echo