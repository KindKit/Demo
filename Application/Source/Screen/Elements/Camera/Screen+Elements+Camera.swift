//
//  KindDemo
//

import KindKit

extension Screen.Elements {
    
    class Camera : IScreen, IScreenStackable, IScreenViewable {
        
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
            entity: .zStack([
                .view(self.cameraView),
                .margin(
                    inset: .init(horizontal: 12, vertical: 12),
                    entity: .position(
                        mode: .bottom,
                        entity: .hStack(
                            alignment: .center,
                            spacing: 8,
                            entities: [
                                .view(self.swapCamera),
                                .view(self.takePhoto)
                            ]
                        )
                    )
                )
            ])
        )
        
        lazy var swapCamera = Self._swapCamera()
        lazy var takePhoto = Self._takePhoto()
        
        lazy var cameraView = UI.View.CameraPreview(self.cameraSession)
            .size(.fill, .fill)
            .mode(.aspectFit)
            .color(.lightGray)
        
        lazy var cameraPermission = Permission.Camera()
        
        lazy var cameraSession = CameraSession(
            self.cameraPermission
        )
        
        lazy var frontVideoDevice = self.cameraSession.videoDevice(
            positions: [ .front ],
            builtIns: [ .triple, .dualWide, .ultraWide, .dual, .wideAngle ],
            presets: [ .high, .medium, .low ]
        )
        
        lazy var rearVideoDevice = self.cameraSession.videoDevice(
            positions: [ .rear ],
            builtIns: [ .triple, .dualWide, .ultraWide, .dual, .wideAngle ],
            presets: [ .high, .medium, .low ]
        )
        
        lazy var externalVideoDevice = self.cameraSession.videoDevice(
            positions: [ .unspecified ],
            builtIns: [ .wideAngle, .external ],
            presets: [ .high, .medium, .low ]
        )
        
        lazy var availableDevices: [CameraSession.Discovery.Video] = {
            var devices: [CameraSession.Discovery.Video] = []
            if let device = self.rearVideoDevice {
                devices.append(device)
            }
            if let device = self.frontVideoDevice {
                devices.append(device)
            }
            if let device = self.externalVideoDevice {
                devices.append(device)
            }
            return devices
        }()
        
        lazy var takePhotoRecorder = CameraSession.Recorder.Photo()

        init() {
            self.cameraSession.add(observer: self, priority: .public)
        }
        
        deinit {
            self.cameraSession.remove(observer: self)
        }
        
        func setup() {
            self.swapCamera.isHidden = self.availableDevices.count < 2
            self.takePhoto.isHidden = true
            
            self.stackBarBack.onPressed(self, { $0.close() })
            self.swapCamera.onPressed(self, { $0.onPressedSwapCamera() })
            self.takePhoto.onPressed(self, { $0.onPressedTakePhoto() })
        }
        
        func destroy() {
            self.cameraSession.stop()
        }
        
        func apply(inset: UI.Container.AccumulateInset) {
            self.viewLayout.inset = inset.natural
        }
        
        func finishShow(interactive: Bool) {
            if let video = self.availableDevices.first {
                self.cameraSession.start(
                    video: video,
                    recorders: [ self.takePhotoRecorder ]
                )
            } else {
            }
        }
        
        func finishHide(interactive: Bool) {
            self.cameraSession.stop()
        }
        
    }
    
}

private extension Screen.Elements.Camera {
    
    static func _swapCamera() -> UI.View.Button {
        let background = UI.View.Rect()
            .fill(.apricot)
            .cornerRadius(.manual(radius: 4))
        let title = UI.View.Text()
            .text("Toggle")
            .textFont(.init(weight: .bold))
            .textColor(.white)
        return UI.View.Button()
            .background(background)
            .primary(title)
            .inset(.init(horizontal: 8, vertical: 8))
            .onStyle({
                if $0.isHighlighted == true {
                    background.fill = .apricot.with(alpha: 0.8)
                    title.textColor = .white.with(alpha: 0.8)
                } else {
                    background.fill = .apricot
                    title.textColor = .white
                }
            })
    }
    
    static func _takePhoto() -> UI.View.Button {
        let background = UI.View.Rect()
            .fill(.apricot)
            .cornerRadius(.manual(radius: 4))
        let title = UI.View.Text()
            .text("Take photo")
            .textFont(.init(weight: .bold))
            .textColor(.white)
        return UI.View.Button()
            .background(background)
            .primary(title)
            .inset(.init(horizontal: 8, vertical: 8))
            .onStyle({
                if $0.isHighlighted == true {
                    background.fill = .apricot.with(alpha: 0.8)
                    title.textColor = .white.with(alpha: 0.8)
                } else {
                    background.fill = .apricot
                    title.textColor = .white
                }
            })
    }
    
}

extension Screen.Elements.Camera {
    
    func onPressedSwapCamera() {
        guard let activeVideoDevice = self.cameraSession.activeVideoDevice else { return }
        guard let index = self.availableDevices.firstIndex(where: { $0.device === activeVideoDevice }) else { return }
        let nextVideo: CameraSession.Discovery.Video
        if index == self.availableDevices.endIndex - 1 {
            nextVideo = self.availableDevices[0]
        } else {
            nextVideo = self.availableDevices[index + 1]
        }
        self.cameraSession.set(video: nextVideo)
    }
    
    func onPressedTakePhoto() {
        self.takePhotoRecorder.start(
            onSuccess: { [weak self] in self?.onTakePhoto($0) },
            onFailure: { [weak self] in self?.onTakePhoto($0) }
        )
    }
    
    func onTakePhoto(_ image: UI.Image) {
    }
    
    func onTakePhoto(_ error: CameraSession.Recorder.Photo.Error) {
    }

}

extension Screen.Elements.Camera : ICameraSessionObserver {
    
    func started(_ camera: CameraSession) {
        self.takePhoto.isHidden = false
    }
    
    func stopped(_ camera: CameraSession) {
        self.takePhoto.isHidden = true
    }
    
    func startConfiguration(_ camera: KindKit.CameraSession) {
        self.swapCamera.isLocked = true
        self.takePhoto.isLocked = true
    }
    
    func finishConfiguration(_ camera: KindKit.CameraSession) {
        self.takePhoto.isLocked = false
        self.swapCamera.isLocked = false
    }
    
}
