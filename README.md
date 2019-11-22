# CHLog

## 说明

* 一个简单的日志查看小插件，主要有下面的两个功能：
    * 1、打印网络请求的日志
    * 2、打印 Print 日志
* 如果项目中集成了[CHHook](https://github.com/rainbow911/CHHook)，则可以自动打印网络请求
 
## 安装

使用CocoaPods集成到项目中，在`Podfile`文件中添加：

```ruby
target '<Your Target Name>' do
    pod 'CHLog'
end
```

然后运行下面的命令：

```bash
$ pod install
```

## 使用

初始化：

```swift
DDDebug.setup(with: .all, listenUrls: nil)
```

打印网络请求信息：

```swift
DDDebug.log(with: DDRequstItemProtocol)
```

打印日志信息：

```swift
DDDebug.log(with: "这是日志信息...", isError: true)
```
