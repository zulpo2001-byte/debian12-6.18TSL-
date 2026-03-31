# Debian 12 内核 6.1.8 一键部署升级指南

本仓库提供了一套用于 Debian 12 系统的 Linux 内核 6.1.8 快速升级方案。

## 📦 包含组件

| 文件名 | 说明 |
| :--- | :--- |
| `linux-image-6.1.8_6.1.8-2_amd64.deb` | Linux 内核 6.1.8 镜像安装包 |
| `linux-libc-dev_6.1.8-2_amd64.deb` | Linux 内核 6.1.8 开发头文件包 |
| `install_kernel.sh` | 自动化一键部署脚本 |

## 🚀 快速开始

### 1. 克隆仓库或下载部署包
```bash
git clone git@github.com:zulpo2001-byte/debian12-6.18TSL-.git
cd debian12-6.18TSL-
```

### 2. 赋予脚本执行权限
```bash
chmod +x install_kernel.sh
```

### 3. 执行一键部署
```bash
sudo ./install_kernel.sh
```

## 🛠️ 脚本功能说明

1. **环境检查**：自动检测是否具备 root 权限及系统架构是否匹配。
2. **依赖补全**：安装过程中若缺少依赖，脚本会提示并尝试修复。
3. **内核安装**：自动安装镜像包和开发包。
4. **引导更新**：自动执行 `update-grub` 确保新内核被加入启动项。
5. **清理工作**：安装完成后提示重启。

## ⚠️ 注意事项

- **备份数据**：在进行内核升级前，请务必备份重要数据。
- **重启生效**：安装完成后，必须运行 `sudo reboot` 重启系统。
- **验证安装**：重启后运行 `uname -r` 确认内核版本是否为 `6.1.8`。

## 🔄 回滚方案

如果新内核无法启动，请在开机 GRUB 菜单中选择 `Advanced options for Debian GNU/Linux`，然后选择旧版本的内核启动进入系统，随后可使用 `apt remove` 卸载新内核。
