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
    @Published var patientName = ""
    @Published var phoneNumber = ""
    @Published var message = ""
    
    
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
                self.patientName = docData!["patientName"] as? String ?? ""
                self.message = "You have been invited to join " + self.patientName + "'s Circle in the Goals app! Use patient code " + self.patientId + " to register as a secondary user."
                
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
            Text("Send message with unique Patient ID for secondary user when registering")
                .padding(.all, 8)
                .padding(.bottom, 20)
                .padding(.vertical)
            Button {
                sendMessage()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color("DeepRed"))
                        .frame(width: 300, height: 38)
                    Text("Send message")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            Spacer()
        }.onAppear {
            model.getPatientId()
        }
        .navigationBarTitle("Add New User")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
    }
    
    func sendMessage() {
        let sms: String = "sms:\(model.phoneNumber)&body=\(model.message)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView()
    }
}
