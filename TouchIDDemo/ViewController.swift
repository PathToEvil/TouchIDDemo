//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by rayootech on 16/11/23.
//  Copyright © 2016年 demon. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = UIColor.cyan
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.addSubview(btn)
        
        let btn2 = UIButton(type: .custom)
        btn2.frame = CGRect(x: 100, y: 250, width: 100, height: 100)
        btn2.backgroundColor = UIColor.cyan
        btn2.addTarget(self, action: #selector(test2), for: .touchUpInside)
        view.addSubview(btn2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test() {
        let la = LAContext()
        var requestError: NSError? = nil
        let canUseLa = la.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &requestError)
        let reasionStr = "Just do it"
        if canUseLa {
            la.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasionStr, reply: { (success, error) in
                if success {
                    print("deviceOwnerAuthenticationWithBiometrics")
                }else {
                    if let error1 = (error as? NSError) {
                        switch error1.code {
                        case LAError.userCancel.rawValue:
                            print("用户取消")
                        case LAError.userFallback.rawValue:
                            print("用户输入密码")
                        case LAError.systemCancel.rawValue:
                            print("系统取消")
                        default:
                            break
                        }
                    }
                }
            })
        }else {
            switch requestError!.code {
            case LAError.touchIDNotEnrolled.rawValue:
                print("touchId")
            default:
                break
            }
        }
    }
    func test2() {
        let la = LAContext()
        let canUseLa = la.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil)
        if canUseLa {
            la.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Just do it", reply: { (success, error) in
                if success {
                    print("deviceOwnerAuthentication")
                }else {
                    print("+++++++++++++++++\(error?.localizedDescription ?? "")")
                }
            })
        }
    }
}

