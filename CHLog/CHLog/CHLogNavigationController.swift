//
//  CHLogNavigationController.swift
//  Demo
//
//  Created by shenzhen-dd01 on 2019/6/3.
//  Copyright © 2019 shenzhen-dd01. All rights reserved.
//

import UIKit

let backImageBase64String = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAsCAYAAAB7aah+AAAAAXNSR0IArs4c6QAAAbJJREFUWAm1mO1GBkEYhlff36oTqGNIp5BSShFRiiiiKPoRRVEUnUQ/IiL6EYmISCTSiZT+9d12ReO9W7uJ7hke+8zjdV0za9+dmU2SSC1N07ZI6BIWyTbxQHSWquYM+BYR2j1Jh1mRJEA3gkGud+TtNhmwNYFrukOnzCICtKJkyXedkiUBa7pHp9w1k0UlS77vlCwIWNMDOhWumcwpWfJD8kqXZEbAmh7RqXJJpoF9KP07P3ZKJgskJ9SrXTOZAPZOZNsphRqXZAxYnuSMeq1LMgLsjci2cwr1LskwsNesgf4F0eCSDBVILqk3uiQDwF6IbLui0OSS9AF7zhroXxPNLkkPsKccyQ21FpekC9hjjuSWWqtDEla+1AH7E4ORdxNxb10YCaJeIu7DILJ+ZHEfb5ENIst7K/j+sCKL/woS2W8v1brwO8uVWzhKxF0mwkgRjRfIfAufyOIv5SKbYmZxNyci+9pu5cl82y2RzSLLa74NpMjm80zUfFtikcXf5Iss/rFFZMsFt9F3EBPZaoFsh3pYYMPP/3cFuJ4j8x6WwxARbYoszvFfZPE/aIjsxyeaT6YUkS8sA/lcAAAAAElFTkSuQmCC"

class CHLogNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let leftBarButtonItem = UIBarButtonItem(image: chBase64StringToUIImage(base64String: backImageBase64String),
                                                    style: .plain, target: self,
                                                    action: #selector(base_nav_backAction))
            viewController.navigationItem.leftBarButtonItem = leftBarButtonItem
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func base_nav_backAction() {
        self.popViewController(animated: true)
    }
}

extension CHLogNavigationController {
    
}

///传入base64的字符串，可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串，然后转换成UIImage
func chBase64StringToUIImage(base64String: String) -> UIImage? {
    //参考：https://blog.csdn.net/u011690583/article/details/51438423
    var str = base64String
    
    // 1、判断用户传过来的base64的字符串是否是以data开口的，
    // 如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
    if str.hasPrefix("data:image") {
        guard let newBase64String = str.components(separatedBy: ",").last else {
            return nil
        }
        str = newBase64String
    }
    // 2、将处理好的base64String代码转换成NSData
    guard let imgNSData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
        return nil
    }
    // 3、将NSData的图片，转换成UIImage
    guard let codeImage = UIImage(data: imgNSData as Data) else {
        return nil
    }
    return codeImage
}
