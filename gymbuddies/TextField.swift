//
//  TextField.swift
//  gymbuddies
//
//  Created by Kareha on 2/10/21.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onCommit: (_ value: String) -> Void
        var didBecomeFirstResponder = false
        init(text: Binding<String>, onCommit: @escaping (_ value: String) -> Void) {
            _text = text
            self.onCommit = onCommit
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCommit(textField.text ?? "")
            return true
        }
    }
    @Binding var text: String
    var onCommit: (_ value: String) -> Void
    var isFirstResponder: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

//public extension Binding where Value: Equatable {
//    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
//        self.init(
//            get: { source.wrappedValue ?? nilProxy },
//            set: { newValue in
//                if newValue == nilProxy {
//                    source.wrappedValue = nil
//                }
//                else {
//                    source.wrappedValue = newValue
//                }
//        })
//    }
//
//struct TextEditorView: View {
//   @State private var objectDescription: String?
//    public var body: some View {
//        VStack(alignment: .leading) {
//            let placeholder = "enter detailed Description"
//            Text("Description")
//            ZStack(alignment: .topLeading) {
//                TextEditor(text: Binding($objectDescription, replacingNilWith: ""))
//                    .frame(minHeight: 30, alignment: .leading)
//                    // following line is a hack to force TextEditor to appear
//                    //  similar to .textFieldStyle(RoundedBorderTextFieldStyle())...
//                    .cornerRadius(6.0)
//                    .foregroundColor(Color(.labelColor))
//                    .multilineTextAlignment(.leading)
//                Text(objectDescription ?? placeholder)
//                    // following line is a hack to create an inset similar to the TextEditor inset...
//                    .padding(.leading, 4)
//                    .foregroundColor(Color(.placeholderTextColor))
//                    .opacity(objectDescription == nil ? 1 : 0)
//            }
//            .font(.body) // if you'd prefer the font to appear the same for both iOS and macOS
//        }
//    }
//}
