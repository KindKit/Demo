//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Button : IScreen, IScreenStackable, IScreenViewable {
        
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
                    entities: [
                        .view(Self._fill(
                            title: "Button #1",
                            titleAlignment: .left
                        )),
                        .view(Self._fill(
                            title: "Button #2",
                            titleAlignment: .center
                        )),
                        .view(Self._fill(
                            title: "Button #3",
                            titleAlignment: .right
                        ))
                    ]
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

fileprivate extension Screen.Elements.Button {
    
    static func _fill(
        title: String,
        titleAlignment: UI.Text.Alignment
    ) -> UI.View.Button {
        let background = UI.View.Rect()
            .fill(.hunterGreen)
            .cornerRadius(.manual(radius: 4))
        let title = UI.View.Text()
            .size(.fill, .fit)
            .text(title)
            .textFont(.init(weight: .bold))
            .textColor(.white)
            .alignment(titleAlignment)
        return UI.View.Button()
            .background(background)
            .primary(title)
            .onStyle({
                if $0.isHighlighted == true {
                    background.fill = .hunterGreen.with(alpha: 0.8)
                    title.textColor = .white.with(alpha: 0.8)
                } else {
                    background.fill = .hunterGreen
                    title.textColor = .white
                }
            })
    }
    
}
