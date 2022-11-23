//
//  KindDemo
//

import KindKit

public final class Wireframe : IUIWireframe {
    
#if os(macOS)
    public private(set) lazy var window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 600, height: 400),
        styleMask: [ .resizable, .miniaturizable, .closable, .titled ],
        backing: .buffered,
        defer: false
    )
#elseif os(iOS)
    public private(set) lazy var window = UIWindow(
        frame: UIScreen.main.bounds
    )
#endif
    public private(set) lazy var container = UI.Container.Root(
        content: UI.Container.None()
    )
    
    private var _state: State = .none {
        didSet {
            switch self._state {
            case .none:
                self.container.content = UI.Container.None()
            case .group(let wireframe):
                self.container.content = wireframe.container
            }
        }
    }
    
    public init() {
    }
    
    public func launch() {
        self._state = .group(Group())
#if os(macOS)
        do {
            let frame = self.window.frame
            self.window.contentViewController = UI.ViewController(self.container)
            self.window.setFrame(frame, display: true)
        }
        self.window.title = "Demo"
        self.window.center()
        self.window.makeKeyAndOrderFront(nil)
#elseif os(iOS)
        self.window.rootViewController = UI.ViewController(self.container)
        self.window.makeKeyAndVisible()
#endif
    }
    
}
