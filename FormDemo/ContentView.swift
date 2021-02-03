//
//  ContentView.swift
//  FormDemo
//
//  Created by David M Reed on 2/3/21.
//

import SwiftUI

// SwiftUI doesn't currently have a way to dismiss keyboard so use UIKit responder chain
// from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView: View {

    @State private var info = DogInfo()

    var body: some View {
        VStack {
            Image("Marly")
                .resizable()
                .frame(width: 320, height: 320)
                .cornerRadius(16)
                .padding(.bottom, 16)

            DogInfoView(info: $info)
            Button("Submit") {
                print(info)
                hideKeyboard()
            }
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
