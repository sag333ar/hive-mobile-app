//
//  AppBridge.swift
//  Runner
//
//  Created by Sagar on 16/10/23.
//

import UIKit
import Flutter

class AppBridge: NSObject {
    var window: UIWindow? = nil
    var webVC: WebViewController? = nil
    var controller: FlutterViewController? = nil

    func initiate(
        controller: FlutterViewController,
        window: UIWindow,
        webVC: WebViewController
    ) {
        self.window = window
        self.webVC = webVC
        self.controller = controller

        let bridgeChannel = FlutterMethodChannel(
            name: "app.the-hive-mobile/bridge",
            binaryMessenger: controller.binaryMessenger
        )

        bridgeChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard
                let arguments = call.arguments as? NSDictionary,
                let id = arguments ["id"] as? String
            else {
                debugPrint("Identifier for the flutter platform call not found")
                result(FlutterMethodNotImplemented)
                return
            }
            guard
                let webVC = self?.webVC
            else {
                debugPrint("WebView Controller is not set")
                result(FlutterMethodNotImplemented)
                return
            }
            switch (call.method) {
                case "getChainProps":
                    webVC.getChainProps(id: id) { text in result(text) }
                default:
                    result(FlutterMethodNotImplemented)
            }
        })
    }
}
