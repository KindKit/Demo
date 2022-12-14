//
//  KindDemo
//

import KindKit

extension Wireframe.Group {
    
    class Elements : IUIWireframe {
        
        lazy var container = UI.Container.Stack(
            screen: ContainerScreen(),
            root: Screen.Elements(
                router: self
            )
        )
        
        init() {
        }
        
    }
    
}

extension Wireframe.Group.Elements : IScreenElementsRouter {
    
    func open(_ screen: Screen.Elements, elements: Screen.Elements.Item) {
        switch elements {
        case .button:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Button()
                ),
                animated: true,
                completion: nil
            )
        case .camera:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Camera()
                ),
                animated: true,
                completion: nil
            )
        case .color:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Color()
                ),
                animated: true,
                completion: nil
            )
        case .gradient:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Gradient()
                ),
                animated: true,
                completion: nil
            )
        case .image: break
        case .input: break
        case .mask:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Mask()
                ),
                animated: true,
                completion: nil
            )
        case .progress: break
        case .rate: break
        case .rect:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Elements.Rect()
                ),
                animated: true,
                completion: nil
            )
        case .remoteImage: break
        case .segmented: break
        case .spinner: break
        case .switch: break
        case .text: break
        case .web: break
        }
    }
    
}

extension Wireframe.Group.Elements {
    
    class ContainerScreen : IUIStackScreen, IUIScreenGroupable {
        
        unowned var container: IUIContainer?
        
        lazy var groupItem = UI.View.GroupBar.Item()
            .content(self.title)
        
        lazy var title = UI.View.Text()
            .text("Elements")
            .textColor(.black)
            .alignment(.center)
        
        init() {
        }
        
        func setup() {
            self.groupItem.onStyle(self, { $0._onSelected() })
        }
        
    }
    
}

private extension Wireframe.Group.Elements.ContainerScreen {
    
    func _onSelected() {
        if self.groupItem.isSelected == true {
            self.title.textColor = .blueGray
        } else {
            self.title.textColor = .black
        }
    }
    
}
