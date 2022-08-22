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
    @Published var patient = PatientInfo(id: "", name: "", gender: "", age: 0, stage: "", tube: "", hands: "", speech: "", muscles: "", walking: "", legs: "", breathing: "")
    @Published var user = User(uuid: "", firstName: "", lastName: "",  patientID: "", patientName: "")
     
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
                self.user = User(uuid: userID, firstName: docData!["firstName"] as? String ?? "",
                                 lastName: docData!["lastName"] as? String ?? "",
                                 patientID: docData!["patient uuid"] as? String ?? "",
                                 patientName: docData!["patientName"] as? String ?? "")
                let patientId = docData!["patient uuid"] as? String ?? ""
                let docRef = db.collection("patients").document(patientId)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let docData = document.data()
                        self.patient = PatientInfo(id: patientId, name: docData!["patientName"] as? String ?? "",
                                                   gender: docData!["patientGender"] as? String ?? "lol",
                                                   age: docData!["patientAge"] as? Int ?? 0,
                                                   stage: docData!["stage"] as? String ?? "",
                                                   tube: docData!["feedingTube"] as? String ?? "",
                                                   hands: docData!["hands"] as? String ?? "",
                                                   speech: docData!["speech"] as? String ?? "",
                                                   muscles: docData!["muscles"] as? String ?? "",
                                                   walking: docData!["walking"] as? String ?? "",
                                                   legs: docData!["legs"] as? String ?? "",
                                                   breathing: docData!["breathing"] as? String ?? "")
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
                                               stage: d["stage"] as? String ?? "",
                                               tube: d["feedingTube"] as? String ?? "",
                                               hands: d["hands"] as? String ?? "",
                                               speech: d["speech"] as? String ?? "",
                                               muscles: d["muscles"] as? String ?? "",
                                               walking: d["walking"] as? String ?? "",
                                               legs: d["legs"] as? String ?? "",
                                               breathing: d["breathing"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                
            }
            
        }
    }
}
