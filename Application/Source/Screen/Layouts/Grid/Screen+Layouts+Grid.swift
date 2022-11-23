//
//  KindDemo
//

import KindKit

extension Screen.Layouts {
    
    class Grid : IScreen, IScreenStackable, IScreenViewable {
        
        unowned var container: IUIContainer?
        
#if os(iOS)
        var statusBar: UIStatusBarStyle {
            if #available(iOS 13.0, *) {
                return .darkContent
            }
            return .default
        }
#endif
        
        lazy var stackBar = UI.View.StackBar()
            .color(.white)
            .size(50)
            .leadings([ self.stackBarBack ])
        
        lazy var stackBarBack = UI.View.Button()
            .size(.fit, .fill)
            .primary(
                .text("Back")
                .textFont(.init(weight: .regular))
                .textColor(.babyBlue)
            )
        
        lazy var view = UI.View.Scroll()
            .size(.fill, .fill)
            .direction([ .vertical, .bounds ])
            .color(.lightGray)
            .content(self.viewLayout)
        
        lazy var viewLayout = UI.Layout.Grid(
            direction: .vertical,
            alignment: .center,
            inset: .init(horizontal: 12, vertical: 8),
            columns: 2,
            spacing: .init(x: 12, y: 8),
            views: Self.views()
        )

        init() {
        }
        
        func setup() {
            self.stackBarBack.onPressed(self, { $0.close() })
        }
        
        func apply(inset: UI.Container.AccumulateInset) {
            self.view.contentInset = inset.natural
        }
        
    }
    
}

private extension Screen.Layouts.Grid {
    
    static func views() -> [IUIView] {
        let count = Int.random(in: 64..<128)
        return (0 ..< count).map({ _ in 
            return Self.colorView()
        })
    }
    
    static func colorView() -> IUIView {
        return .color(.init(
            r: 0 ..< 1,
            g: 0 ..< 1,
            b: 0 ..< 1
        )).size(.fill, .fixed(Double.random(in: 96 ..< 142)))
    }
    
}
