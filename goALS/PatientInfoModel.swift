//
//  PatientInfoModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PatientInfoModel: ObservableObject {
    
    @Published var list = [PatientInfo]()
    @Published var todoList = [Todo]()
    @Published var patient = PatientInfo(id: "", name: "", gender: "", age: 0, stage: "")
    @Published var newId : String = ""
    @Published var newName : String = ""
    @Published var newGender : String = ""
    @Published var newAge : Int = 0
    @Published var newStage : String = ""
    @Published var patientId : String = ""
    
    
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
                print("Document does not exist here")
            }
        }
    }
    
    func getTodos() {
        getPatientId()
        let db = Firestore.firestore()
        db.collection("todos").whereField("id", isEqualTo: self.patientId)
          .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    DispatchQueue.main.async {
                        self.todoList = querySnapshot.documents.map { d in
                            return Todo(id: d["id"] as? String ?? "", name: d["name"] as? String ?? "", notes: d["notes"] as? String ?? "")
                        }
                    }
                }
                else {
                    print("No document")
                }
            }
        }
    }
    
    func addTodoItem(_ n: String, _ no: String) {
        getPatientId()
        let db = Firestore.firestore()
        if self.patientId != "" {
            db.collection("todos").addDocument(data: ["name": n, "notes": no]) { error in
                if error == nil {
                    self.getTodos()
                }
            }
        }
        else {
            print("patient id could not be found")
        }
        
        
    }
    /* let docRef = db.collection("patients").document(patientId)
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let docData = document.data()
            self.patient = PatientInfo(id: patientId, name: docData!["patientName"] as? String ?? "",
                                       gender: docData!["patientGender"] as? String ?? "lol",
                                       age: docData!["patientAge"] as? Int ?? 0,
                                       stage: docData!["stage"] as? String ?? "")
        } else {
            print("Document does not exist")
        }
    }
} else {
    print("Document does not exist here")
} */
    
    func getSingleData() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let patientId = docData!["patient uuid"] as? String ?? ""
                let docRef = db.collection("patients").document(patientId)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let docData = document.data()
                        self.patient = PatientInfo(id: patientId, name: docData!["patientName"] as? String ?? "",
                                                   gender: docData!["patientGender"] as? String ?? "lol",
                                                   age: docData!["patientAge"] as? Int ?? 0,
                                                   stage: docData!["stage"] as? String ?? "")
                    } else {
                        print("Document does not exist")
                    }
                }
            } else {
                print("Document does not exist here")
            }
        }
    }
    /* func updateData() {
        
        //need to implement this for the primary caregiver
        
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("patients").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let patientId = docData!["patient uuid"] as? String ?? ""
                db.collection("patients").document(patientId).setData(["patientAge" : self.newAge, "patientGender" : self.newGender, "stage" : self.newStage], merge: true) { error in
                    if error == nil {
                        self.getSingleData()
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    */
        
    func updateData(_ value: [String : Any]) {
            let db = Firestore.firestore()
            guard let userID = Auth.auth().currentUser?.uid else {
                return
            }
            let docRef = db.collection("users").document(userID)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let docData = document.data()
                    let patientId = docData!["patient uuid"] as? String ?? ""
                    db.collection("patients").document(patientId).setData(value, merge: true) { error in
                        if error == nil {
                            self.getSingleData()
                        }
                    }
                } else {
                    print("Document does not exist")
                }
        }
    }

    func getData() {
        let db = Firestore.firestore()
        db.collection("patients").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            return PatientInfo(id: d.documentID, name: d["patientName"] as? String ?? "",
                                               gender: d["patientGender"] as? String ?? "",
                                               age: d["patientAge"] as? Int ?? 0,
                                               stage: d["stage"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                
            }
            
        }
    }
}
