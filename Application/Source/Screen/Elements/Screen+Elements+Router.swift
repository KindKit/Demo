//
//  Docusketch
//

import Foundation
import KindKit

protocol IScreenElementsRouter {
    
    func open(_ screen: Screen.Elements, elements: Screen.Elements.Item)
    
}

extension Screen.Elements {
    
    struct Router< RouterType : AnyObject & IScreenElementsRouter > : IScreenElementsRouter {
        
        private weak var _router: RouterType?
        
        init(
            _ router: RouterType
        ) {
            self._router = router
        }
        
        func open(_ screen: Screen.Elements, elements: Screen.Elements.Item) {
            self._router?.open(screen, elements: elements)
        }
        
    }
    
}
