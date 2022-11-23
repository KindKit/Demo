//
//  KindDemo
//

import KindKit

extension Screen.Elements.Input {
    
    enum Item : CaseIterable {
        
        case date
        case list
        case measurement
        case string
        case secure
        case text
        
    }
    
}

extension Screen.Elements.Input.Item {
    
    var title: String {
        switch self {
        case .date: return "Date"
        case .list: return "List"
        case .measurement: return "Measurement"
        case .string: return "String"
        case .secure: return "Secure"
        case .text: return "Text"
        }
    }
    
}
