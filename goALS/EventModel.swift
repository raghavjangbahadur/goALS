//
//  EventModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class EventModel: ObservableObject {
    
    @Published var events = [Event]()
    @Published var totalEvents = [Event]()
    
    func getEvents(date: String) {
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
                db.collection("events").document(key).collection(key).whereField("date", isEqualTo: date)
                    .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querySnapshot = querySnapshot {
                            DispatchQueue.main.async {
                                self.events = querySnapshot.documents.map { d in
                                    return Event(id: d.documentID, title: d["title"] as? String ?? "", description: d["description"] as? String ?? "", date: d["date"] as? String ?? "", startTime: d["startTime"] as? String ?? "", endTime: d["endTime"] as? String ?? "")
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
    
    func sortEvents() {
        events = events.sorted(by: { $0.startTime > $1.startTime})
    }
    
    
    func getAllEvents() {
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
                db.collection("events").document(key).collection(key).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querySnapshot = querySnapshot {
                            DispatchQueue.main.async {
                                self.totalEvents = querySnapshot.documents.map { d in
                                    return Event(id: d.documentID, title: d["title"] as? String ?? "", description: d["description"] as? String ?? "", date: d["date"] as? String ?? "", startTime: d["startTime"] as? String ?? "", endTime: d["endTime"] as? String ?? "")
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
    
    func returnOpacity(date: Date) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        let stringified = dateFormatter.string(from: date)
        
        if totalEvents.contains(where: {$0.date == stringified}) {
            return 0.5
        }
        else {
            return 0
        }
    }
    
    func addEvent(_ title: String, _ description: String, _ date: String, _ startTime: String, _ endTime: String) {
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
                db.collection("events").document(key).collection(key).addDocument(data: ["title": title, "description": description, "date": date, "startTime" : startTime, "endTime" : endTime]) { error in
                    if error == nil {
                        self.getEvents(date: date)
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func deleteEvent(_ event: Event, _ date: String) {
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
                db.collection("events").document(key).collection(key).document(event.id).delete { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.events.removeAll { eventItem in
                                return eventItem.id == event.id
                            }
                        }
                        self.getEvents(date: date)
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
