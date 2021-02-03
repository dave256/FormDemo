//
//  DogInfoView.swift
//  FormDemo
//
//  Created by David M Reed on 2/3/21.
//

import SwiftUI

struct DogInfo {
    var dogName = ""
    var ownerFirstName = ""
    var ownerLastName = ""
    var streetAddress = ""
    var city = ""
    var state = ""
    var zipcode = ""
    var phone = ""
    var dogWeightString = "0.0"
    var licensed = false

    var isLicensed: String { "Licensed: " + (licensed ? "Yes" : "No") }

    var dogWeight: Double {
        get { Double(dogWeightString) ?? 0.0 }
        set { dogWeightString = String(format: "%0.1f", newValue) }
    }
}

extension DogInfo: CustomStringConvertible {
    var description: String {
        "\(dogName)\n\(ownerFirstName) \(ownerLastName)\n\(streetAddress)\n\(city), \(state) \(zipcode)\n\(phone)\n\(dogWeightString) lbs\n\(isLicensed)"
    }
}

struct DogInfoView: View {
    @Binding var info: DogInfo
    @State private var alertPresented = false
    @State private var alertMessage = ""

    var body: some View {
        Form {
            Group {
                TextField("dog name", text: $info.dogName)
                TextField("owner first", text: $info.ownerFirstName)
                TextField("owner last", text: $info.ownerLastName)
                TextField("address", text: $info.streetAddress)
                TextField("city", text: $info.city)
                TextField("state", text: $info.state)
            }
            .disableAutocorrection(true)
            Group {
                TextField("zipcode", text: $info.zipcode)
                // clear out textfied on begin editing
                TextField("dog weight", text: $info.dogWeightString) { editing in
                    if editing {
                        $info.dogWeightString.wrappedValue = ""
                    }
                }
            }
            .keyboardType(.numberPad)
            Toggle("Licensed", isOn: $info.licensed)
        }
        // validation of weight and zipcode
        .onChange(of: info.dogWeightString) { value in
            if !value.isEmpty && Double(value) == nil {
                alertMessage = "Invalid Weight"
                alertPresented = true
            }
        }
        .onChange(of: info.zipcode) { value in
            if !value.isEmpty && (value.count > 5 || Int(value) == nil) {
                alertMessage = "Invalid Zipcode"
                alertPresented = true
                info.zipcode = ""
            }
        }
        // alert for error messages
        .alert(isPresented: $alertPresented) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct DogInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(DogInfo()) {
            DogInfoView(info: $0)
        }
    }
}
