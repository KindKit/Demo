//
//  KindDemo
//

import KindKit

extension Wireframe.Group {
    
    class Layouts : IUIWireframe {
        
        lazy var container = UI.Container.Stack(
            screen: ContainerScreen(),
            root: Screen.Layouts(
                router: self
            )
        )
        
        init() {
        }
        
    }
    
}

extension Wireframe.Group.Layouts : IScreenLayoutsRouter {
    
    func open(_ screen: Screen.Layouts, layouts: Screen.Layouts.Item) {
        switch layouts {
        case .composition:
            break
        case .expand:
            break
        case .list:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Layouts.List()
                ),
                animated: true,
                completion: nil
            )
        case .grid:
            self.container.push(
                container: UI.Container.Screen(
                    Screen.Layouts.Grid()
                ),
                animated: true,
                completion: nil
            )
        case .state:
            break
        }
    }
    
}

extension Wireframe.Group.Layouts {
    
    class ContainerScreen : IStackScreen, IScreenGroupable {
        
        unowned var container: IUIContainer?
        
        lazy var groupItem = UI.View.GroupBar.Item()
            .content(self.title)
        
        lazy var title = UI.View.Text()
            .text("Layouts")
            .textColor(.black)
            .alignment(.center)
        
        init() {
        }
        
        func setup() {
            self.groupItem.onStyle(self, { $0._onSelected() })
        }
        
    }
    
}

private extension Wireframe.Group.Layouts.ContainerScreen {
    
    func _onSelected() {
        if self.groupItem.isSelected == true {
            self.title.textColor = .blueGray
        } else {
            self.title.textColor = .black
        }
    }
    
}
