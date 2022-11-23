//
//  KindDemo
//

import KindKit

#if os(iOS)

extension Screen.Elements.Input {
    
    class Measurement : IScreen, IScreenStackable, IScreenViewable {
        
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
                        .view(self.plainField),
                        .view(self.complexField1),
                        .view(self.complexField2)
                    ]
                )
            )
        )
        
        lazy var plainField = UI.View.Input.Measurement.Plain(unit: UnitLength.meters)
            .placeholder("Enter measurement")
            .placeholderFont(.init(weight: .regular))
            .placeholderColor(.darkGray)
            .toolbar([
                .flexible(),
                .plain("Done").onPressed(self, { $0._onDone() })
            ])
        
        lazy var complexField1 = UI.View.Input.Measurement.Complex(unit: UnitLength.meters)
            .parts(self._complexParts1())
            .default(.init(value: 1.80, unit: UnitLength.meters))
            .placeholder("Enter measurement")
            .placeholderFont(.init(weight: .regular))
            .placeholderColor(.darkGray)
            .toolbar([
                .flexible(),
                .plain("Done").onPressed(self, { $0._onDone() })
            ])
        
        lazy var complexField2 = UI.View.Input.Measurement.Complex(unit: UnitLength.meters)
            .parts(self._complexParts2())
            .default(.init(value: 1.6666, unit: UnitLength.meters))
            .placeholder("Enter measurement")
            .placeholderFont(.init(weight: .regular))
            .placeholderColor(.darkGray)
            .toolbar([
                .flexible(),
                .plain("Done").onPressed(self, { $0._onDone() })
            ])

        init() {
        }
        
        func setup() {
            self.stackBarBack.onPressed(self, { $0.close() })
            self.plainField.onEditing(self, { $0._onChangedPlain() })
            self.complexField1.onEditing(self, { $0._onChangedComplex1() })
            self.complexField2.onEditing(self, { $0._onChangedComplex2() })
        }
        
        func apply(inset: UI.Container.AccumulateInset) {
            self.viewLayout.inset = inset.natural
        }
        
    }
    
}

private extension Screen.Elements.Input.Measurement {
    
    func _complexParts1() -> [UI.View.Input.Measurement.Complex< UnitLength >.Part] {
        return [
            .init(
                unit: UnitLength.meters,
                unitStyle: .short,
                range: 0.0 ..< 2.0
            ),
            .init(
                unit: UnitLength.centimeters,
                unitStyle: .short,
                range: 0.0 ..< 100.0,
                step: 10
            )
        ]
    }
    
    func _complexParts2() -> [UI.View.Input.Measurement.Complex< UnitLength >.Part] {
        return [
            .init(
                unit: UnitLength.meters,
                unitStyle: .short,
                range: 0.0 ..< 2.0
            ),
            .init(
                unit: UnitLength.centimeters,
                unitStyle: .short,
                range: 0.0 ..< 100.0,
                step: 10.0
            ),
            .init(
                unit: UnitLength.centimeters,
                unitStyle: .short,
                range: 0.0 ..< 10.0
            )
        ]
    }
    
}

private extension Screen.Elements.Input.Measurement {
    
    func _onChangedPlain() {
        print("Measurement plain = \(self.plainField.value)")
    }
    
    func _onChangedComplex1() {
        print("Measurement complex 1 = \(self.complexField1.value)")
    }
    
    func _onChangedComplex2() {
        print("Measurement complex 2 = \(self.complexField2.value)")
    }
    
    func _onDone() {
        self.endEditing()
    }
    
}

#endif
