//
//  KindDemo
//

import KindKit
import SwiftUI

extension Screen.Elements {
    
    class Hosting : IScreen, IScreenStackable, IScreenViewable {
        
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
                        .view(UI.View.Hosting(content: ContentView())),
                        .view(UI.View.Hosting(content: ContentView()))
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

private extension Screen.Elements.Hosting {
    
    struct ContentView : SwiftUI.View {
        
        @State var isExpanded = false
            
        var body: some View {
            VStack {
                Text("Headline")
                if isExpanded {
                    Text("More Info")
                    Text("And more")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))
            .background(Color.gray.cornerRadius(10.0))
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
        
    }
    
}
