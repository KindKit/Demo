//
//  Docusketch
//

import Foundation
import KindKit

protocol IScreenElementsInputRouter {
    
    func open(_ screen: Screen.Elements.Input, item: Screen.Elements.Input.Item)
    
}

extension Screen.Elements.Input {
    
    struct Router< RouterType : AnyObject & IScreenElementsInputRouter > : IScreenElementsInputRouter {
        
        private weak var _router: RouterType?
        
        init(
            _ router: RouterType
        ) {
            self._router = router
        }
        
        func open(_ screen: Screen.Elements.Input, item: Screen.Elements.Input.Item) {
            self._router?.open(screen, item: item)
        }
        
    }
    
}
