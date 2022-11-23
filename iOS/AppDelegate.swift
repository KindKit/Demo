//
//  Demo
//

import UIKit
import Application

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var _wireframe = Application.Wireframe()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self._wireframe.launch()
        return true
    }

}
