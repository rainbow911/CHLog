
//
//  CHLogItem.swift
//  CHLog
//
//  Created by wanggw on 2018/6/30.
//  Copyright © 2018年 UnionInfo. All rights reserved.
//

import UIKit

public class CHLogItem: NSObject {
    var logTime: String = ""                //日志时间
    
    var logInfo: String = ""                //日志内容
    var isError: Bool = false               //是否是错误信息
    
    var isRequest: Bool = true              //是否是网络请求
    var isRequestError: Bool = false        //是否是请求失败

    var requstType: String = ""             //请求类型
    var requstBaseUrl: String = ""          //请求地址
    var requstFullUrl: String = ""          //请求完整地址
    var requstHeader: [String: Any] = [:]   //请求头
    var requstParams: [String: Any] = [:]   //请求参数
    
    var httpCode: Int = -1                  //请求HttpCode
    var response: [String: Any] = [:]       //请求返回数据
    
    var responses: [CHLogItem] = []         //请求返回数据列表

    var rowHeight: CGFloat = 0              //缓存高度
}

extension CHLogItem {
    
    public class func item(with item: DDRequstItemProtocol) -> CHLogItem {
        let logItem: CHLogItem = CHLogItem()
        logItem.isRequest = true
        
        if let method = item.method,
            let url = item.url,
            let headers = item.headers,
            let parameters = item.parameters {
            logItem.requstType = method
            logItem.requstFullUrl = url
            logItem.requstHeader = headers
            logItem.requstParams = parameters
        }
        
        if let response = item.response {
            logItem.response = response
        }
        if let httpCode = item.httpCode {
            logItem.httpCode = httpCode
        }
        if let isRequestError = item.isError {
            logItem.isRequestError = isRequestError
        }
    
        return logItem
    }
}

extension CHLogItem {
    
    public func cellRowHeigt() -> CGFloat {
        if rowHeight != 0 {
            return rowHeight
        }
        
        let nsInfo = describeString() as NSString
        let size = nsInfo.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 30, height: 1000),
                                       options: .usesLineFragmentOrigin,
                                       attributes: [.font: UIFont.systemFont(ofSize: 12)],
                                       context: nil)
        rowHeight = size.height + 10
        return rowHeight
    }
}

extension CHLogItem {
 
    public func detail_describeString() -> String {
        if !isRequest {
            return logInfo
        }
        
        let info = """
            Type：\(requstType)
         FullUrl：\(requstFullUrl)
          Header：\((requstHeader as Dictionary).debug_Format_String)
          Params：\((requstParams as Dictionary).debug_Format_String)
        HttpCode：\(httpCode)
        Response：\((response as Dictionary).debug_Format_String)
        """
        
        return info
    }
    
    //计算高度，用于拷贝内容
    public func describeString() -> String {
        if !isRequest {
            return logInfo
        }
        
        let info = """
            Type：\(requstType)
         FullUrl：\(requstFullUrl)
          Header：\(requstHeader)
          Params：\(requstParams)
        Response：\(response)
        """
        return info
    }
    
    public func requestItemString() -> NSMutableAttributedString {
        if !isRequest {
            let color = isError ? UIColor.red : UIColor.white
            let attributedString = normalString(with: logInfo, color: color)
            return attributedString
        }
        
        //-----
        let attributedString = hightlightString(with: "    type：")
        attributedString.append(normalString(with: "\(requstType)\n"))
        //-----
        attributedString.append(hightlightString(with: " fullUrl："))
        attributedString.append(normalString(with: "\(requstFullUrl)\n", color: UIColor.blue))
        //-----header
        attributedString.append(hightlightString(with: "header："))
        attributedString.append(normalString(with: "\(requstHeader)\n"))
        //-----params
        attributedString.append(hightlightString(with: "params："))
        attributedString.append(normalString(with: "\(requstParams)\n"))
        //-----
        
        return attributedString
    }
    
    private func normalString(with value: String, color: UIColor = UIColor.black) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: value, attributes: [.font: UIFont.systemFont(ofSize: 12.0),
                                                                     .foregroundColor: color])
    }
    
    private func hightlightString(with value: String, color: UIColor = UIColor.black) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: value, attributes: [.font: UIFont.boldSystemFont(ofSize: 14.0),
                                                                     .foregroundColor: color])
    }
}

extension Dictionary {
    
    /// 格式化打印字典
    var debug_Format_String: String {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let formatString = String(data: data, encoding: .utf8) {
            return formatString
        }
        return ""
    }

}

extension Dictionary where Key == String {
    func compare(with params: [String: Any]) -> Bool {
        var isSame = true
        
        //比较两个字典的元素个数，个数不相同，肯定不相同
        if self.values.count != params.values.count {
            isSame = false
        }
        else {
            
            //元素可能的值，int、string、array、dictionary
            
            for (key, value) in self {
                
                if let value2 = params[key], "\(value)" == "\(value2)" {
                        
                }
                
                
            }
        }
        
        
        //给字典增加一个限定类型，下面的比较非常不准确，因为两个字符串里面的顺序会是错乱的
        //let value1 = "\(self)"
        //let value2 = "\(params)"
        //print("value1 = " + value1)
        //print("value2 = " + value2)
        //if value1 != value2 {
        //    isSame = false
        //}
    
        return isSame
    }
}
