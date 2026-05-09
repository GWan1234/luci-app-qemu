# luci-app-qemu

OpenWrt/LEDE QEMU 虚拟机管理器

## 简介

luci-app-qemu 是一个基于 LuCI 的 Web 界面，用于在 OpenWrt/LEDE 系统上管理 QEMU 虚拟机。它提供了友好的网页界面，可以直接通过浏览器创建、配置、启动、停止和监控虚拟机。

## 截图

### 虚拟机列表
![VM List](docs/screenshots/vm_list.png)

### 添加新虚拟机
![Wizard](docs/screenshots/wizard.png)

### 基本设置
![Basic](docs/screenshots/basic.png)

### 存储配置
![Storage](docs/screenshots/storage.png)

### 网络配置
![Network](docs/screenshots/network.png)

### PCI 设备直通
![Passthrough](docs/screenshots/passthrough.png)

### 全局设置
![Enable](docs/screenshots/enable.png)

## 功能特性

- **虚拟机管理**
  - 向导式创建新虚拟机
  - 启动、停止、重启虚拟机
  - 查看虚拟机状态和资源使用情况
  - 强制停止无响应的虚拟机
  - 自动启动配置

- **硬件配置**
  - CPU 和内存分配
  - 存储设备管理（磁盘镜像、VirtIO、IDE、SCSI、USB）
  - 网络接口配置
  - 显示设置（VNC）
  - 输入设备（键盘、鼠标）
  - 声音设备
  - 控制器设备（USB、SCSI、VirtIO Serial）
  - 主机设备直通（PCI Passthrough）
  - 看门狗定时器

- **高级设置**
  - 启动选项（传统 BIOS/UEFI）
  - VNC 显示密码保护
  - 串口控制台访问
  - QMP 接口高级管理

- **存储管理**
  - 创建和管理磁盘镜像
  - 支持多种磁盘格式（qcow2、raw 等）
  - 磁盘镜像扩容

- **网络配置**
  - 用户模式 NAT 网络
  - Tap 网络
  - Bridge 网桥网络
  - Socket 网络
  - 端口转发

## 系统要求

- OpenWrt/LEDE 系统
- QEMU 软件包：
  - `qemu-system-x86_64`（或其他架构）
  - `qemu-img`
  - `qemu-bridge-helper`
  - `qemu-firmware-seabios`（传统 BIOS 支持）
- OVMF 软件包（UEFI 支持）：
  - 从 [edk2-ovmf](https://github.com/hoyoho/edk2-ovmf) 编译适用于 OpenWrt 的版本
- 内核模块：
  - `kmod-tun`
  - `kmod-kvm-amd` 或 `kmod-kvm-intel`（硬件加速）
- 额外软件包：
  - `socat`（QMP 通信）
  - `luci-compat`（LuCI 兼容性）

## 安装

### 通过 IPK 包安装

1. 从 [ releases ](https://github.com/yourusername/luci-app-qemu/releases) 页面下载最新的 IPK 包
2. 将 IPK 上传到 OpenWrt 设备
3. 安装软件包：
   ```bash
   opkg install luci-app-qemu_*.ipk
   ```
4. 安装依赖：
   ```bash
   opkg install qemu-system-x86_64 qemu-img qemu-bridge-helper qemu-firmware-seabios kmod-tun kmod-kvm-amd socat
   ```

### 从源码编译

1. 克隆仓库：
   ```bash
   git clone https://github.com/yourusername/luci-app-qemu.git
   ```
2. 编译软件包：
   ```bash
   cd luci-app-qemu
   make package/luci-app-qemu/compile V=99
   ```
3. 安装生成的 IPK 包：
   ```bash
   opkg install bin/packages/*/luci-app-qemu_*.ipk
   ```

## 使用说明

### 访问界面

1. 打开网页浏览器，访问 OpenWrt 路由器的 Web 管理界面
2. 进入 **服务 → QEMU 虚拟机**

### 创建虚拟机

1. 点击 **添加新虚拟机** 启动向导
2. 按步骤配置：
   - 基本设置（名称、描述）
   - 硬件配置（CPU、内存）
   - 存储设备（磁盘镜像）
   - 网络接口
   - 显示设置（VNC）
   - 高级选项
3. 点击 **创建** 完成

### 管理虚拟机

- **启动**：点击 **启动** 按钮启动虚拟机
- **停止**：点击 **停止** 按钮正常关机
- **强制停止**：点击 **强制停止** 按钮立即终止虚拟机
- **重启**：点击 **重启** 按钮重启虚拟机
- **编辑**：点击 **编辑** 按钮修改虚拟机设置
- **删除**：点击 **删除** 按钮删除虚拟机

### VNC 访问

1. 确保在虚拟机显示设置中已启用 VNC
2. 使用 VNC 客户端连接到 `路由器IP:590X`（X 是 VNC 端口偏移量）
3. 如果设置了密码，输入密码

### 存储管理

1. 进入 **存储** 选项卡
2. 点击 **添加磁盘镜像** 创建新磁盘
3. 选择磁盘格式和大小
4. 点击 **创建** 生成磁盘镜像

## 配置说明

### 全局设置

- **存储路径**：磁盘镜像的默认存储位置
- **启用**：QEMU 全局启用/禁用开关

### 虚拟机设置

每个虚拟机都有独立的配置，包括：
- 名称和描述
- CPU 和内存分配
- 存储设备
- 网络接口
- 显示设置
- 启动选项
- 自动启动配置

## 故障排除

### 常见问题

1. **虚拟机启动失败**
   - 检查 QEMU 软件包是否已安装
   - 验证磁盘镜像是否存在且可访问
   - 检查端口冲突（尤其是 VNC 端口）

2. **VNC 连接被拒绝**
   - 确保在虚拟机设置中启用了 VNC
   - 检查虚拟机是否正在运行
   - 验证防火墙设置允许 VNC 流量

3. **性能问题**
   - 启用 KVM 硬件加速（如果可用）
   - 调整 CPU 和内存分配
   - 使用 SSD 存储以获得更好的性能

### 日志

- 查看系统日志中的 QEMU 相关消息：
  ```bash
  logread | grep qemu
  ```
- 在 Web 界面中查看虚拟机专用日志

## 参与贡献

欢迎提交 Pull Request！

### 开发指南

- 遵循现有的代码风格
- 彻底测试更改
- 提供清晰的提交信息
- 必要时更新文档

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。
