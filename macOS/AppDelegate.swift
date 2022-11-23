//
//  Demo
//

import Cocoa
import Application

class AppDelegate : NSObject, NSApplicationDelegate {
    
    private lazy var _wireframe = Application.Wireframe()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self._wireframe.launch()
        
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool{
        return true
    }

}
