//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    enum Item : CaseIterable {
        
        case button
        case camera
        case color
        case gradient
        case image
        case input
        case mask
        case progress
        case rate
        case rect
        case remoteImage
        case segmented
        case spinner
        case `switch`
        case text
        case web
        
    }
    
}

extension Screen.Elements.Item {
    
    var title: String {
        switch self {
        case .button: return "Button"
        case .camera: return "Camera"
        case .color: return "Color"
        case .gradient: return "Gradient"
        case .image: return "Image"
        case .input: return "Input"
        case .mask: return "Mask"
        case .progress: return "Progress"
        case .rate: return "Rate"
        case .rect: return "Rect"
        case .remoteImage: return "RemoteImage"
        case .segmented: return "Segmented"
        case .spinner: return "Spinner"
        case .switch: return "Switch"
        case .text: return "Text"
        case .web: return "Web"
        }
    }
    
}
