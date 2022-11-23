//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Color : IScreen, IScreenStackable, IScreenViewable {
        
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
        
        lazy var view = UI.View.Custom()
            .size(.fill, .fill)
            .color(.lightGray)
            .content(self.viewLayout)
        
        lazy var viewLayout = UI.Layout.Composition(
            entity: .margin(
                inset: .init(horizontal: 12, vertical: 8),
                entity: .vStack(
                    alignment: .fill,
                    spacing: 8,
                    entities: (0 ..< max(Self.Sizes.count, Self.Colors.count)).map({
                        UI.Layout.Composition.View(
                            .color(Self.Colors[$0])
                            .size(Self.Sizes[$0])
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
            self.viewLayout.inset = inset.natural
        }
        
    }
    
}

extension Screen.Elements.Color {
    
    static let Sizes: [UI.Size.Static] = [
        .init(.fill, .fixed(24)),
        .init(.fill, .fixed(28)),
        .init(.fill, .fixed(42)),
        .init(.fill, .fixed(36)),
        .init(.fill, .fixed(42)),
        .init(.fill, .fixed(24)),
        .init(.fill, .fixed(36)),
        .init(.fill, .fixed(52)),
        .init(.fill, .fixed(48)),
        .init(.fill, .fixed(32)),
        .init(.fill, .fixed(28)),
        .init(.fill, .fixed(44))
    ]
    
    static let Colors: [UI.Color] = [
        .cherry,
        .beige,
        .amaranth,
        .babyBlue,
        .blue,
        .cadetBlue,
        .hunterGreen,
        .bronze,
        .cordovan,
        .jade,
        .brightYellow,
        .flax
    ]
    
}
