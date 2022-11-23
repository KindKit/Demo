//
//  Docusketch
//

import Foundation
import KindKit

protocol IScreenLayoutsRouter {
    
    func open(_ screen: Screen.Layouts, layouts: Screen.Layouts.Item)
    
}

extension Screen.Layouts {
    
    struct Router< RouterType : AnyObject & IScreenLayoutsRouter > : IScreenLayoutsRouter {
        
        private weak var _router: RouterType?
        
        init(
            _ router: RouterType
        ) {
            self._router = router
        }
        
        func open(_ screen: Screen.Layouts, layouts: Screen.Layouts.Item) {
            self._router?.open(screen, layouts: layouts)
        }
        
    }
    
}
