//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Markdown : IScreen, IScreenStackable, IScreenViewable {
        
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
                    entities: (0 ..< Self.Texts.count).map({
                        UI.Layout.Composition.View(
                            .markdown()
                            .text(Self.Texts[$0])
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

extension Screen.Elements.Markdown {
    
    static let Texts: [String] = [
        """
        # Start heading
        Line 1
        Line 2
        End heading
        
        $ Start code
        Line 1
        Line 2
        End code
        
        > Start quote
        Line 1
        Line 2
        End quote
        
        [1.] Start list
        Line 1
        Line 2
        End list
        
        [•] Start list
        Line 1
        Line 2
        End list
        
        Start paragraph
        Line 1
        Line 2
        End paragraph
        
        //Italic//
        **Bold**
        __Underline__
        --Strikethrough--
        """
    ]
    
}
