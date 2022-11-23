//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Mask : IScreen, IScreenStackable, IScreenViewable {
        
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
                entity: .hFill(
                    .vStack(
                        alignment: .center,
                        spacing: 8,
                        entities: [
                            .view(
                                .mask(
                                    .text("Color")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                            ),
                            .view(
                                .mask(
                                    .text("Color & Border")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                                .border(.manual(width: 1, color: .scarlet))
                            ),
                            .view(
                                .mask(
                                    .text("Color & CornerRadius")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .cornerRadius(.manual(radius: 12, edges: .top))
                                .color(.amaranth)
                            ),
                            .view(
                                .mask(
                                    .text("Color & Shadow")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                                .shadow(.init(
                                    color: .black,
                                    opacity: 0.5,
                                    radius: 4,
                                    offset: .zero
                                ))
                            ),
                            .view(
                                .mask(
                                    .text("Color & Border & Shadow")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                                .border(.manual(width: 1, color: .scarlet))
                                .shadow(.init(
                                    color: .black,
                                    opacity: 0.5,
                                    radius: 4,
                                    offset: .zero
                                ))
                            ),
                            .view(
                                .mask(
                                    .text("Color & Border & CornerRadius")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .border(.manual(width: 1, color: .scarlet))
                                .cornerRadius(.manual(radius: 12, edges: .top))
                                .color(.amaranth)
                            ),
                            .view(
                                .mask(
                                    .text("Color & CornerRadius & Shadow")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                                .cornerRadius(.manual(radius: 12, edges: .top))
                                .shadow(.init(
                                    color: .black,
                                    opacity: 0.5,
                                    radius: 4,
                                    offset: .zero
                                ))
                            ),
                            .view(
                                .mask(
                                    .text("Color & Border & CornerRadius & Shadow")
                                    .alignment(.center)
                                )
                                .size(.parent(.half), .fixed(92))
                                .color(.amaranth)
                                .border(.manual(width: 1, color: .scarlet))
                                .cornerRadius(.manual(radius: 12, edges: .top))
                                .shadow(.init(
                                    color: .black,
                                    opacity: 0.5,
                                    radius: 4,
                                    offset: .zero
                                ))
                            )
                        ]
                    )
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
