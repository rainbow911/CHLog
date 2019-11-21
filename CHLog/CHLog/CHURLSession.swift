//
//  CHURLSession.swift
//  DDDebug
//
//  Created by shenzhen-dd01 on 2019/1/18.
//  Copyright © 2019 shenzhen-dd01. All rights reserved.
//

import UIKit

class CHURLSession: NSObject {
    static let shared = CHURLSession()
    
    private override init() {
        super.init()
    }
}

// MARK: - Notification

extension CHURLSession {
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getRequestInfo), name: .hookRequest, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getResponseInfo), name: .HookResponse, object: nil)
    }
    
    @objc func getRequestInfo(noti: Notification) {
        if let userInfo = noti.userInfo {
            dealWithNotification(with: userInfo)
        }
        else {
            print("【CHLog: Notification(NSURLSession_Hook_Request): getRequestInfo，error info：noti.userInfo is nil】")
        }
    }
    
    @objc func getResponseInfo(noti: Notification) {
        if let userInfo = noti.userInfo {
             dealWithNotification(with: userInfo)
        }
        else {
            print("【CHLog: Notification(NSURLSession_Hook_Response): getResponseInfo，error info：noti.userInfo is nil】")
        }
    }
    
    func dealWithNotification(with userInfo: [AnyHashable: Any]) {
        var session = SessionItem()
        if let method = userInfo["method"] as? String,
            let url = userInfo["url"] as? String,
            let headers = userInfo["headers"] as? [String: Any],
            let parameters = userInfo["parameters"] as? [String: Any] {
            
            session.method = method
            session.url = url
            session.headers = headers
            session.parameters = parameters
        }
        
        if let httpCode = userInfo["httpCode"] as? String,
            let code = Int(httpCode) {
            session.isError = code == 200 ? false : true
            session.httpCode = code
        }
    
        if let response = userInfo["response"] as? [String: Any] {
            session.response = response
        }
        
        DDDebug.log(with: session)
    }
}

// MARK: -

extension Notification.Name {
    public static let hookRequest = NSNotification.Name(rawValue: "NSURLSession_Hook_Request")
    public static let HookResponse = NSNotification.Name(rawValue: "NSURLSession_Hook_Response")
}

public protocol DDRequstItemProtocol {
    var method: String? { get }
    var url: String? { get }
    var headers: [String: Any]? { get }
    var parameters: [String: Any]? { get }
    var httpCode: Int? { get }
    var response: [String: Any]? { get }
    var isError: Bool? { get }
}

struct SessionItem: DDRequstItemProtocol {
    var method: String?
    var url: String?
    var headers: [String : Any]?
    var parameters: [String : Any]?
    var httpCode: Int?
    var response: [String : Any]?
    var isError: Bool?
}
