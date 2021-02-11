//
//  TextField.swift
//  gymbuddies
//
//  Created by Kareha on 2/10/21.
//

import SwiftUI
import Combine


//struct TextView: UIViewRepresentable {
//    var placeholder: String
//    @Binding var text: String
//
//    var minHeight: CGFloat
//    @Binding var calculatedHeight: CGFloat
//
//    init(placeholder: String, text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>) {
//        self.placeholder = placeholder
//        self._text = text
//        self.minHeight = minHeight
//        self._calculatedHeight = calculatedHeight
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.delegate = context.coordinator
//
//        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
//        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//
//        textView.isScrollEnabled = false
//        textView.isEditable = true
//        textView.isUserInteractionEnabled = true
//        textView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
//
//        // Set the placeholder
//        textView.text = placeholder
//        textView.textColor = UIColor.lightGray
//
//        return textView
//    }
//
//    func updateUIView(_ textView: UITextView, context: Context) {
//        textView.text = self.text
//
//        recalculateHeight(view: textView)
//    }
//
//    func recalculateHeight(view: UIView) {
//        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
//        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
//            DispatchQueue.main.async {
//                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
//            }
//        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
//            DispatchQueue.main.async {
//                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
//            }
//        }
//    }
//
//    class Coordinator : NSObject, UITextViewDelegate {
//
//        var parent: TextView
//
//        init(_ uiTextView: TextView) {
//            self.parent = uiTextView
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            // This is needed for multistage text input (eg. Chinese, Japanese)
//            if textView.markedTextRange == nil {
//                parent.text = textView.text ?? String()
//                parent.recalculateHeight(view: textView)
//            }
//        }
//
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            if textView.textColor == UIColor.lightGray {
//                textView.text = nil
//                textView.textColor = UIColor.black
//            }
//        }
//
//        func textViewDidEndEditing(_ textView: UITextView) {
//            if textView.text.isEmpty {
//                textView.text = parent.placeholder
//                textView.textColor = UIColor.lightGray
//            }
//        }
//    }
//}

//final class UserData: BindableObject  {
//    let didChange = PassthroughSubject<UserData, Never>()
//
//    var text = "" {
//        didSet {
//            didChange.send(self)
//        }
//    }
//
//    init(text: String) {
//        self.text = text
//    }
//}
//
//struct MultilineTextView: UIViewRepresentable {
//    @Binding var text: String
//
//    func makeUIView(context: Context) -> UITextView {
//        let view = UITextView()
//        view.isScrollEnabled = true
//        view.isEditable = true
//        view.isUserInteractionEnabled = true
//        return view
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//    }
//}
//
//struct ContentView : View {
//    @State private var selection = 0
//    @EnvironmentObject var userData: UserData
//
//    var body: some View {
//        TabbedView(selection: $selection){
//            MultilineTextView(text: $userData.text)
//                .tabItemLabel(Image("first"))
//                .tag(0)
//            Text("Second View")
//                .font(.title)
//                .tabItemLabel(Image("second"))
//                .tag(1)
//        }
//    }
//}
//
//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(UserData(
//                text: """
//                        Some longer text here
//                        that spans a few lines
//                        and runs on.
//                        """
//            ))
//
//    }
//}
//#endif

//
//struct CustomTextField: UIViewRepresentable {
//    class Coordinator: NSObject, UITextFieldDelegate {
//        @Binding var text: String
//        var onCommit: (_ value: String) -> Void
//        var didBecomeFirstResponder = false
//        init(text: Binding<String>, onCommit: @escaping (_ value: String) -> Void) {
//            _text = text
//            self.onCommit = onCommit
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            text = textField.text ?? ""
//        }
//
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            onCommit(textField.text ?? "")
//            return true
//        }
//    }
//    @Binding var text: String
//    var onCommit: (_ value: String) -> Void
//    var isFirstResponder: Bool = false
//
//    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
//        let textField = UITextField(frame: .zero)
//        textField.delegate = context.coordinator
//        return textField
//    }
//    func makeCoordinator() -> CustomTextField.Coordinator {
//        return Coordinator(text: $text, onCommit: onCommit)
//    }
//    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
//        uiView.text = text
//        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
//            uiView.becomeFirstResponder()
//            context.coordinator.didBecomeFirstResponder = true
//        }
//    }
//}
//
//struct TextView: UIViewRepresentable {
//
//    @Binding var text: String
//    @Binding var textStyle: UIFont.TextStyle
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//
//        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
//        textView.autocapitalizationType = .sentences
//        textView.isSelectable = true
//        textView.isUserInteractionEnabled = true
//
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
//    }
//}

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
