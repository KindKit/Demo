//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Gradient : IScreen, IScreenStackable, IScreenViewable {
        
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
            .color(.lightGray)
            .content(self.viewLayout)
        
        lazy var viewLayout = UI.Layout.Composition(
            entity: .margin(
                inset: .init(horizontal: 12, vertical: 8),
                entity: .vStack(
                    alignment: .fill,
                    spacing: 8,
                    entities: (0 ..< Self.Fills.count).map({
                        UI.Layout.Composition.View(
                            .gradient(Self.Fills[$0])
                            .size(.fill, .fixed(92))
                        )
                    })
                )
            )
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

extension Screen.Elements.Gradient {
    
    static let Fills: [UI.View.Gradient.Fill] = [
        .init(
            mode: .axial,
            points: [
                .init(color: .blueGreen, location: 0.0),
                .init(color: .darkPink, location: 0.5),
                .init(color: .mocha, location: 1.0)
            ],
            start: .init(x: 0, y: 0),
            end: .init(x: 0, y: 1)
        ),
        .init(
            mode: .axial,
            points: [
                .init(color: .cognac, location: 0.0),
                .init(color: .puce, location: 0.5),
                .init(color: .raspberry, location: 1.0)
            ],
            start: .init(x: 0, y: 0),
            end: .init(x: 1, y: 0)
        ),
        .init(
            mode: .radial,
            points: [
                .init(color: .camel, location: 0.0),
                .init(color: .garnet, location: 0.5),
                .init(color: .persimmon, location: 1.0)
            ],
            start: .init(x: 0.5, y: 0.5),
            end: .init(x: 1, y: 1)
        )
    ]
    
}
