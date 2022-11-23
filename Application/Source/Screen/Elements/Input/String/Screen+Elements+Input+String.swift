//
//  KindDemo
//

import KindKit

#if os(iOS)

extension Screen.Elements.Input {
    
    class String : IScreen, IScreenStackable, IScreenViewable {
        
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
                        .view(self.field)
                    ]
                )
            )
        )
        
        lazy var field = UI.View.Input.String()
            .placeholder("Enter string")
            .placeholderFont(.init(weight: .regular))
            .placeholderColor(.darkGray)
            .toolbar([
                .flexible(),
                .plain("Done").onPressed(self, { $0._onDone() })
            ])
            .suggestion(.static(
                items: [ "Adam", "Smith", "Lion" ],
                limit: 2
            ))

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

private extension Screen.Elements.Input.String {
    
    func _onDone() {
        self.field.endEditing()
    }
    
}

#endif
