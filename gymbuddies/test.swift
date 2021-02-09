//
//  test.swift
//  gymbuddies
//
//  Created by Kareha on 2/8/21.
//

import SwiftUI

struct test: View {
    var body: some View {
        Picker_Callback()
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}

import SwiftUI

class PickerModel:ObservableObject{
    @Published var picked: Int = 0 {didSet{print("here")}}
}

struct Picker_Callback: View {
   @ObservedObject var pickerModal = PickerModel()
    var someData = ["a", "b", "c"]
    var body: some View {

        VStack {
            Picker(selection: self.$pickerModal.picked,
                   label: Text("")) {
                    ForEach(0 ..< someData.count)     {Text(self.someData[$0]).tag($0)}
            }
            //.pickerStyle(.wheel)
            Text("you picked: \(someData[self.pickerModal.picked])")
        }
    }
}
