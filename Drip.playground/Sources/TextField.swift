import SwiftUI

public struct FocusableTextField: UIViewRepresentable {
    @Binding public var isFirstResponder: Bool
    @Binding public var text: String
    var placeholder: String = ""
    var oncommit: (UITextField) -> Void

    public var configuration = { (view: UITextField) in }

    public init(text: Binding<String>, isFirstResponder: Binding<Bool>, placeholder: String = "", configuration: @escaping (UITextField) -> () = { _ in }, oncommit: @escaping (UITextField) -> Void) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
        self.placeholder = placeholder
        self.oncommit = oncommit
    }

    public func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.placeholder = placeholder
        view.keyboardType = .numberPad
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder, self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        var parent: FocusableTextField
        

        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>, _ parent: FocusableTextField) {
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.parent = parent
        }

        @objc public func textViewDidChange(_ textField: UITextField) {
            self.text.wrappedValue = textField.text ?? ""
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            self.isFirstResponder.wrappedValue = true
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            self.isFirstResponder.wrappedValue = false
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.oncommit(textField)
            self.isFirstResponder.wrappedValue = false
            
            return true
        }
    }
}
