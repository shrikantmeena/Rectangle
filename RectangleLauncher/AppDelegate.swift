//
//  AppDelegate.swift
//  RectangleLauncher
//
//  Created by Ryan Hanson on 6/14/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if #available(macOS 13, *) {
            terminate()
            return
        }
        let mainAppIdentifier = "com.knollsoft.Rectangle"
        let running = NSWorkspace.shared.runningApplications
        let isRunning = !running.filter({$0.bundleIdentifier == mainAppIdentifier}).isEmpty
        
        if isRunning {
            self.terminate()
        } else {
            let killNotification = Notification.Name("killLauncher")
            DistributedNotificationCenter.default().addObserver(self,
                                                                selector: #selector(self.terminate),
                                                                name: killNotification,
                                                                object: mainAppIdentifier)
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("Rectangle")
            let newPath = NSString.path(withComponents: components)
            
            let appURL = URL(fileURLWithPath: newPath)

            NSWorkspace.shared.openApplication(at: appURL,
                                               configuration: NSWorkspace.OpenConfiguration(),
                                               completionHandler: { app, error in
                if let error = error {
                    print("Failed to launch application: \(error)")
                } else if let app = app {
                    print("Successfully launched application: \(app.localizedName ?? "Unknown App")")
                }
            })
        }
    }
    
    @objc func terminate() {
        NSApp.terminate(nil)
    }

}

