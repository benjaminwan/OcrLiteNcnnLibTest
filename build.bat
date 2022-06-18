@ECHO OFF
chcp 65001
cls
@SETLOCAL
echo ========请先参考OCR项目相关说明准备好编译环境========
echo.

set BUILD_TYPE=Release

echo "请选择要使用的lib库选项并回车: 1)CPU，2)vulkan"
set BUILD_VULKAN="CPU"
set /p flag=
if %flag% == 1 (set BUILD_VULKAN="CPU")^
else if %flag% == 2 (set BUILD_VULKAN="GPU")^
else (echo "输入错误！Input Error!")
echo.

echo VS版本: 1)vs2019-x64, 2)vs2019-x86
set BUILD_CMAKE_T="v142"
set BUILD_CMAKE_A="x64"
set /p flag=
if %flag% == 1 (
    set BUILD_CMAKE_T=v142
    set BUILD_CMAKE_A=x64
)^
else if %flag% == 2 (
    set BUILD_CMAKE_T=v142
    set BUILD_CMAKE_A=Win32
)^
else (echo 输入错误！Input Error!)
echo.

mkdir win-%BUILD_CMAKE_A%-%BUILD_VULKAN%
pushd win-%BUILD_CMAKE_A%-%BUILD_VULKAN%

cmake -T "%BUILD_CMAKE_T%,host=x64" -A %BUILD_CMAKE_A% ^
  -DCMAKE_INSTALL_PREFIX=install -DOCR_VULKAN=%BUILD_VULKAN% ..
cmake --build . --config %BUILD_TYPE% -j %NUMBER_OF_PROCESSORS%
cmake --build . --config %BUILD_TYPE% --target install

popd

echo ========输出文件夹:win-%BUILD_CMAKE_A%-%BUILD_VULKAN%\install========
echo 请运行输出文件夹内的run-test.bat脚本进行测试
echo.
PAUSE

GOTO:EOF

@ENDLOCAL
