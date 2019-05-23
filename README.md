# CHLog

## 说明

* 实现日志打印功能
    * 1、打印网络请求的日志，需要配合 [CHHook](https://github.com/rainbow911/CHHook) 使用
    * 2、打印 Print 日志
 
## 使用说明：

1. Podfile中添加：`pod 'CHLog'`
2. 执行：`pod install`

## Pod Update
* 执行命令验证库：`pod lib lint --allow-warnings`
* 添加Tag并推送：`git tag -a 0.0.1 -m 'Version_0.0.1'; git push origin --tags`
    * 删除Tag本地/远端：`git tag -d 0.0.1; git push origin :refs/tags/0.0.1`
* 推送到 Cocoapod 版本库：`pod trunk push CHLog.podspec`