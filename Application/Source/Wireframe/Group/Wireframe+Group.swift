//
//  KindDemo
//

import KindKit

extension Wireframe {
    
    class Group : IUIWireframe {
        
        lazy var container = UI.Container.Group(
            screen: ContainerScreen(),
            containers: [
                self.elementsWireframe.container,
                self.layoutsWireframe.container
            ],
            current: self.elementsWireframe.container
        )
        
        lazy var elementsWireframe = Elements()
        lazy var layoutsWireframe = Layouts()
        
        init() {
        }
        
    }
    
}

extension Wireframe.Group {
    
    class ContainerScreen : IGroupScreen {
        
        unowned var container: IUIContainer?
        
        lazy var groupBar = UI.View.GroupBar()
            .size(50)
            .color(.white)
        
        init() {
        }

    }
    
}
