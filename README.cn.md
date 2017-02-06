# appetizer-toolkit [![Build Status](https://travis-ci.org/appetizerio/appetizer-toolkit.svg?branch=master)](https://travis-ci.org/appetizerio/appetizer-toolkit) [![Windows Build](https://ci.appveyor.com/api/projects/status/github/appetizerio/appetizer-toolkit)](https://ci.appveyor.com/project/mingyuan-xia/appetizer-toolkit)
`appetizer-toolkit` 是 [Appetizer](https://www.appetizer.io) 的核心功能，它提供了如下功能:
* 从单台设备录制屏幕触碰事件，在多台设备上重放（需要屏幕横宽比一致）
* 同时控制多台设备（例如, 运行一个 shell 命令，安装 apk 等）
* 将一台设备的屏幕触碰事件，镜像操作到多台设备上（需要屏幕横宽比一致）

`appetizer-toolkit` 是一个命令行工具，能够运行在 Windows 7+，MacOS Mavericks+ 和 Linux 操作系统上。一同提供的还包括 [Python SDK](https://github.com/appetizerio/appetizer-toolkit-py) 和 [Nodejs SDK](https://github.com/appetizerio/appetizer-toolkit-js)。 `appetizer-toolkit` 要求 `adb` 已添加到 `PATH` 环境变量上.

欢迎提交关于 bug，功能和特性的 issues 以及 Pull requests。

## 安装
不同系统的可执行文件可以在如下文件夹下找到， MacOS 系统的在 `darwin/` 文件夹下， Windows 系统的在 `win32/` 文件夹下， Ubuntu Fedora 和 CentOS 系统的在 `linux/` 文件夹下。 可以将路径添加到 `PATH` 下全局运行。 Linux 和 MacOS 需要在64位环境下运行，Windows 可以在32位环境下运行（兼容64位环境)

```
用法: appetizer [-h] {version,trace,adb,devices,plan} ...

参数说明:
  {version,trace,adb,devices,plan}
                        说明
    version             显示版本并退出程序
    trace               录制或重放触屏事件
    adb                 控制本地 adb
    devices             控制设备
    plan                运行一个测试计划文件

可选参数:
  -h, --help            显示帮助说明并退出程序

```

## 录制和重放
录制或重放触屏事件，输入 `appetizer trace`:
```
用法: appetizer trace [-h] {info,replay,record} ...

参数说明:
  {info,replay,record}  操作
    info                获取录制文件的信息
    replay              在若干设备上重放录制文件的操作
    record              录制触屏操作

可选参数:
  -h, --help            显示帮助说明并退出程序
```

录制和重放的演示：
[![Record and replay](https://i.vimeocdn.com/video/583660790_640.jpg)](http://www.bilibili.com/video/av6725203/index_2.html)

## 控制多设备和镜像操作
同时控制多台设备，输入 `appetizer devices`:
```
用法: appetizer devices [-h]
                                           {list,screenshot,mirror,control}
                                           ...

参数说明:
  {list,screenshot,mirror,control}
                        在设备上的操作
    list                显示连接的设备列表
    screenshot          截屏
    mirror              实时将一台设备的屏幕触碰事件，镜像到多台设备上
    control             控制设备

可选参数:
  -h, --help            显示帮助说明并退出程序
```

实时将一台设备的屏幕触碰事件，镜像到多台设备上的演示：
[![mirroring](https://i.vimeocdn.com/video/585120374_640.jpg)](http://www.bilibili.com/video/av6725203/index_3.html)

## ADB 相关
Android SDK 的 `adb` 是 `appetizer-toolkit` 的必要依赖。toolkit 本身可以检测是否有 adb 二进制环境并且可以控制 adb server。
```
用法: appetizer adb [-h]
                                       
                                       {check-server,start-server,kill-server,detectadb}
                                       ...

参数说明:
  {check-server,start-server,kill-server,detectadb}
                        在 adb server 上的操作
    check-server        确认 adb server 的状态
    start-server        启动 adb server
    kill-server         杀死 adb server 进程
    detectadb           检测 adb 路径

可选参数:
  -h, --help            显示帮助说明并退出程序
```
