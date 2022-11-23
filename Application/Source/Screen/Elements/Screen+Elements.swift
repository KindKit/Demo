//
//  KindDemo
//

import KindKit

extension Screen {
    
    class Elements : IScreen, IScreenStackable, IScreenViewable {
        
        let router: IScreenElementsRouter
        
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
        
        lazy var view = UI.View.Scroll()
            .width(.fill)
            .height(.fill)
            .direction([ .vertical, .bounds ])
            .content(self.layout)
            .color(.lightGray)
        
        lazy var layout = UI.Layout.List()
            .direction(.vertical)
            .views(
                Item.allCases
                    .map(self._cell)
                    .kk_processing(separator: self._separator)
            )

        init< RouterType : AnyObject & IScreenElementsRouter >(
            router: RouterType
        ) {
            self.router = Router(router)
        }
        
        deinit {
        }
        
        func apply(inset: UI.Container.AccumulateInset) {
            self.view.contentInset = inset.natural
        }
        
    }
    
}

extension Screen.Elements {
    
    func _onPressed(_ item: Item) {
        self.router.open(self, elements: item)
    }
    
}

extension Screen.Elements {
    
    func _cell(_ item: Item) -> UI.View.Cell {
        return .init()
            .background(
                UI.View.Color()
                    .color(.white)
            )
            .content(
                UI.View.Custom()
                    .content(.composition(
                        inset: .init(horizontal: 12, vertical: 8),
                        entity: .view(
                            UI.View.Text()
                                .text(item.title)
                                .color(.white)
                        )
                    ))
            )
            .onPressed(self, { $0._onPressed(item) })
    }
    
    func _separator() -> UI.View.Rect {
        return .init()
            .size(.fill, .fixed(1))
            .color(.darkGray)
    }
    
}
