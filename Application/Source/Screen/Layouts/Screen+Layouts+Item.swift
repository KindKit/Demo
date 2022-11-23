//
//  KindDemo
//

import KindKit

extension Screen.Layouts {
    
    enum Item : CaseIterable {
        
        case composition
        case expand
        case list
        case grid
        case state

    }
    
}

extension Screen.Layouts.Item {
    
    var title: String {
        switch self {
        case .composition: return "Composition"
        case .expand: return "Expand"
        case .list: return "List"
        case .grid: return "Grid"
        case .state: return "State"
        }
    }
    
}
