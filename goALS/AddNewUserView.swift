//
//  AddNewUserView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/25/22.
//
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AddNewUserModel: ObservableObject {
    @Published var patientId = ""
    
    
    func getPatientId() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                self.patientId = docData!["patient uuid"] as? String ?? ""
                
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct AddNewUserView: View {
    @ObservedObject var model = AddNewUserModel()
    var body: some View {
        VStack {
            Spacer()
            Text("Use unique Patient ID when secondary user registers for authentication")
                .padding(.all, 8)
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 370, height: 25)
                Text(model.patientId)
                    .textSelection(.enabled)
            }
            .padding(.bottom, 20)
            Button {
                model.getPatientId()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 370, height: 38)
                    Text("Generate Patient Unique ID")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            Divider()
            Spacer()
        }
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView()
    }
}
