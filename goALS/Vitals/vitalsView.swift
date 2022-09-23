//
//  vitalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct vitalsView: View {
    
    @State var showQuiz = false
    
    @State var correct = 0
    @State var incorrect = 0
    @State var answered = 0
    
    var body: some View {
        VStack {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 75)
                .padding(.all)
            NavigationLink(destination: PatientInfoView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Key details and information")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 20)
            
            NavigationLink(destination: TodosView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Daily Checklist")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 20)
            
            NavigationLink(destination: LearnView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Learn more about ALS")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 20)

            NavigationLink(destination: Calendar()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Calendar")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 320, height: 45)
                    .foregroundColor(.gray)
                Text("Take the ALS Quiz!")
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            .onTapGesture(perform: {
                showQuiz.toggle()
            })
            Divider()
            Spacer()
        }
        .background(Color.red)
        .sheet(isPresented: $showQuiz, content: {
            QuizView(correct: $correct, incorrect: $incorrect, answered: $answered)
        })
    }
}

struct vitalsView_Previews: PreviewProvider {
    static var previews: some View {
        vitalsView()
    }
}
