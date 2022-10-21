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
    @Published var errorMessage = ""
    @Published var loaded = false
    var totalEvents = Set<Event>()
    
    func getEvents(date: String, completion: (([Event]) -> Void)? = nil) {
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
                            let totalEvents = querySnapshot.documents.map { d in
                                return Event(id: d.documentID,
                                             title: d["title"] as? String ?? "",
                                             description: d["description"] as? String ?? "",
                                             date: d["date"] as? String ?? "",
                                             startTime: d["startTime"] as? String ?? "",
                                             endTime: d["endTime"] as? String ?? "")
                            }

                            self.totalEvents = Set(totalEvents)
                            var events = Array(self.totalEvents.filter { $0.date == date })
                            events = events.sorted (by: { lhs, rhs in
                                if(((lhs.startTime.contains("AM") && rhs.startTime.contains("AM")) || (lhs.startTime.contains("PM") && rhs.startTime.contains("PM"))) && lhs.startTime.count == 7 && rhs.startTime.count == 7) {
                                    return lhs.startTime < rhs.startTime
                                }
                                else if (((lhs.startTime.contains("AM") && rhs.startTime.contains("AM")) || (lhs.startTime.contains("PM") && rhs.startTime.contains("PM"))) && lhs.startTime.count == 8 && rhs.startTime.count == 7) {
                                    return false
                                }
                                else if ((lhs.startTime.contains("AM") && rhs.startTime.contains("AM")) || (lhs.startTime.contains("PM") && rhs.startTime.contains("PM")) && lhs.startTime.count == 7 && rhs.startTime.count == 8) {
                                    return true
                                }
                                else if (lhs.startTime.contains("AM") && rhs.startTime.contains("PM")) {
                                    return true
                                }
                                else {
                                    return false
                                }
                            })
                            DispatchQueue.main.async {
                                self.events = events
                                completion?(events)
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
    
    func getTotalEvents() {
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
                            let totalEvents = querySnapshot.documents.map { d in
                                return Event(id: d.documentID,
                                             title: d["title"] as? String ?? "",
                                             description: d["description"] as? String ?? "",
                                             date: d["date"] as? String ?? "",
                                             startTime: d["startTime"] as? String ?? "",
                                             endTime: d["endTime"] as? String ?? "")
                            }
                            
                            self.totalEvents = Set(totalEvents)
                            self.loaded = true
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
    
    func addEvent(_ title: String,
                  _ description: String,
                  _ date: String,
                  _ startTime: String,
                  _ endTime: String,
                  completion: (([Event]) -> Void)? = nil) {
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
                        self.getEvents(date: date, completion: completion)
                        self.errorMessage = ""
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func deleteEvent(_ event: Event, _ date: String, completion: (([Event]) -> Void)? = nil) {
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
                        self.getEvents(date: date, completion:completion)
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
