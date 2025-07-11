# 项目概述

本项目是对sylar服务器框架的改编和简化，专注于协程库的部分。通过引入协程、调度器和定时器等核心模块，利用HOOK技术将Linux系统中的传统同步函数（如 `sleep`、`read`、`write` 等）转化为异步版本。此改造允许保持同步I/O的编程方式，同时享受异步执行的效率和响应速度提升。

## 运行环境

Ubuntu 22.04 LTS

## 编译指令



## 主要模块介绍

### 协程类
* 使用非对称的独立栈协程。
* 支持调度协程与任务协程之间的高效切换。

### 调度器
* 结合线程池和任务队列维护任务。
* 工作线程采用FIFO策略运行协程任务，并负责将epoll中就绪的文件描述符事件和超时任务加入队列。

### 定时器
* 利用set重定义比较算法管理定时器，优化获取最小超时时间的效率。

## 关键技术点

* 线程同步与互斥
* epoll的事件驱动模型
* Linux网络编程
* 泛型编程
* 同步与异步I/O
* HOOK技术

## 待优化和扩展功能
1.协程池
2.内存池
3，嵌套协程

### 内存池优化
当前协程在创建时自动分配独立栈空间，销毁时释放，引入频繁的系统调用。通过内存池技术优化可减少系统调用，提高内存使用效率。

### 协程嵌套支持
目前只支持主协程与子协程之间的切换，无法实现协程的嵌套。参考libco的设计，实现更复杂的协程嵌套功能，允许在协程内部再次创建新的协程层级。

### 复杂调度算法
引入类似操作系统的进程调度算法，如优先级、响应比和时间片等，以支持更复杂的调度策略，满足不同场景下的需求。

## 核心概念详解
### 同步I/O（Synchronous I/O）
应用程序执行I/O操作必须等待操作完成，期间应用程序被阻塞，无法执行其他任务。

### 异步I/O（Asynchronous I/O）
应用程序可以在I/O操作执行过程中继续执行其他代码，I/O操作通过事件回调机制完成通知。

### HOOK技术
对系统底层函数进行封装，增强功能且保持原有调用接口的兼容性，使函数在保持原有调用方式的同时，增加新的功能实现。

