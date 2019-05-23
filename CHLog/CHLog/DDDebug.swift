//
//  DDDebug.swift
//  DDDebug
//
//  Created by shenzhen-dd01 on 2019/1/16.
//  Copyright © 2019 shenzhen-dd01. All rights reserved.
//

import Foundation

// MARK: - CHLog

public struct DDDebug {
    
    /// 显示日志按钮
    ///
    /// - Parameters:
    ///   - showType: 显示类型
    ///   - listenUrls: 白名单
    public static func setup(with showType: CHLogShowType, listenUrls: [String]?) {
        CHURLSession.shared.addNotification()
        CHLog.setup(with: showType, listenUrls: listenUrls)
    }
    
    /// 显示终端打印的日志
    ///
    /// - Parameters:
    ///   - info: 终端print信息
    ///   - isError: 是否是错误信息
    public static func log(with info: String, isError: Bool = false) {
        CHLog.log(with: info, isError: isError)
    }
    
    /// 显示网络请求的日志
    ///
    /// - Parameter request: 网络请求描述
    public static func log(with request: DDRequstItemProtocol) {
        CHLog.log(with: request)
    }
}
