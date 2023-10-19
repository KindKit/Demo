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
        case hosting
        case image
        case input
        case markdown
        case mask
        case progress
        case rate
        case rect
        case remoteImage
        case segmented
        case spinner
        case `switch`
        case video
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
        case .hosting: return "Hosting"
        case .image: return "Image"
        case .input: return "Input"
        case .markdown: return "Markdown"
        case .mask: return "Mask"
        case .progress: return "Progress"
        case .rate: return "Rate"
        case .rect: return "Rect"
        case .remoteImage: return "RemoteImage"
        case .segmented: return "Segmented"
        case .spinner: return "Spinner"
        case .switch: return "Switch"
        case .video: return "Video"
        case .text: return "Text"
        case .web: return "Web"
        }
    }
    
}
