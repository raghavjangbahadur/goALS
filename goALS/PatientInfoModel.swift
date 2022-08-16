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
    @Published var checklist = [ChecklistItem]()
    @Published var patient = PatientInfo(id: "", name: "", gender: "", age: 0, stage: "")
    @Published var newId : String = ""
    @Published var newName : String = ""
    @Published var newGender : String = ""
    @Published var newAge : Int = 0
    @Published var newStage : String = ""
    
    
    /*func getPatientId() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
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
    }*/
    
    func deleteCheckListItem(_ item: ChecklistItem) {
        let db = Firestore.firestore()
        db.collection("checklist").document(item.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.list.removeAll { checklistItem in
                        return checklistItem.id == item.id
                    }
                }
                self.getChecklist()
            }
        }
    }
    func getChecklist() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let key = docData!["patient uuid"] as? String ?? ""
                db.collection("checklist").whereField("patientId", isEqualTo: key)
                  .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querySnapshot = querySnapshot {
                            DispatchQueue.main.async {
                                self.checklist = querySnapshot.documents.map { d in
                                    return ChecklistItem(id: d.documentID, patientId: d["patientId"] as? String ?? "", name: d["name"] as? String ?? "", notes: d["notes"] as? String ?? "")
                                }
                            }
                        }
                        else {
                            print("No document")
                        }
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func addChecklistItem(_ n: String, _ no: String) {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let key = docData!["patient uuid"] as? String ?? ""
                db.collection("checklist").addDocument(data: ["patientId": key, "name": n, "notes": no]) { error in
                    if error == nil {
                        self.getChecklist()
                    }
                }
            } else {
                print("Document does not exist")
            }
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
