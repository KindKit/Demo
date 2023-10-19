//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Video : IScreen, IScreenStackable, IScreenViewable {
        
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
        
        lazy var player = Player()
            .item(.url(URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!))
            .options([ .autoplay, .autorepeat ])
            .mute(true)
        
        lazy var view = UI.View.Video()
            .size(.fill, .fill)
            .color(.black)
            .player(self.player)

        init() {
        }
        
        func setup() {
            self.stackBarBack.onPressed(self, { $0.close() })
        }
        
    }
    
}
