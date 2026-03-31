#!/bin/bash

# 设置内核版本
KERNEL_VERSION="6.1.8"

# 确保以 root 权限运行
if [ "$EUID" -ne 0 ]; then 
  echo "错误: 请使用 root 权限运行此脚本 (sudo ./install_kernel.sh)"
  exit 1
fi

echo "--- 开始一键安装 Linux 内核 ${KERNEL_VERSION} ---"

# 1. 检查当前目录下的 .deb 文件
DEB_IMAGE=$(ls linux-image-${KERNEL_VERSION}_*.deb 2>/dev/null)
DEB_LIBC=$(ls linux-libc-dev_${KERNEL_VERSION}-*.deb 2>/dev/null)

if [ -z "$DEB_IMAGE" ] || [ -z "$DEB_LIBC" ]; then
  echo "错误: 未在当前目录找到内核安装包 (.deb 文件)。"
  echo "请确保脚本与 .deb 文件位于同一目录下。"
  exit 1
fi

# 2. 安装内核包
echo "[1/2] 正在安装内核安装包..."
dpkg -i "$DEB_IMAGE" "$DEB_LIBC"

# 3. 检查安装结果并更新引导
if [ $? -eq 0 ]; then
  echo "[2/2] 正在更新 GRUB 引导配置..."
  update-grub
  echo "--- 内核安装成功！ ---"
  echo "当前系统已配置为在下次启动时加载内核 ${KERNEL_VERSION}。"
  echo "请运行 'reboot' 重启服务器以使新内核生效。"
else
  echo "错误: 安装过程中出现问题，请检查上述错误信息。"
  echo "提示: 如果缺少依赖，请尝试运行 'apt-get install -f'。"
  exit 1
fi
