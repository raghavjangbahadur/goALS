//
//  QuizViewModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/21/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class QuizViewModel: ObservableObject {
    
    @Published var questions = [Question]()
    
    func getQuestion() {
        let db = Firestore.firestore()
        
        db.collection("quiz").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    DispatchQueue.main.async {
                        self.questions = querySnapshot.documents.map { d in
                            return Question(id: d.documentID, question: d["question"] as? String ?? "", option1: d["option1"] as? String ?? "", option2: d["option2"] as? String ?? "", answer: d["answer"] as? String ?? "")
                        }
                    }
                }
                else {
                    print("No document")
                }
            }
        }
        print(questions)
    }
}
