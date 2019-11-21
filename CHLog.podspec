#
# Be sure to run `pod lib lint CHHook.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
    s.name             = 'CHLog'
    s.version          = '0.0.3'
    s.summary          = 'CHLog is Debug Tool for Log SomeThing'

s.description      = <<-DESC
0.0.3：优化日志插件，增加httpCode显示
0.0.2：解决详情不能上下滑动的问题；详情页格式化打印 Header、Response
0.0.1：初始版本
CHLog is Debug Tool, let you log someThing for debug
DESC

s.homepage         = 'ttps://github.com/rainbow911'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Guowen Wang' => 'rainbow911@gmail.com' }
s.source           = { :git => 'https://github.com/rainbow911/CHLog.git', :tag => s.version.to_s}

s.swift_version = '4.2'
s.ios.deployment_target = '9.0'
s.source_files = 'CHLog/CHLog/*'

end
