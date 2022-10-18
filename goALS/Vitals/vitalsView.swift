//
//  vitalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct vitalsView: View {
    
    @State var showQuiz = false
    @State var showLearn = false
    
    @State var correct = 0
    @State var incorrect = 0
    @State var answered = 0
    
    @Environment(\.presentationMode) var present
    
    @ObservedObject var InfoModel = PatientInfoModel()
    @ObservedObject var QuizModel = QuizViewModel()
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Spacer()
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                                .offset(x: 20)
                            Image("goals_logo_white")
                                 .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                            
                        }
                    }
                    .offset(x:10)
                    Text("> > >")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Image("vitals_logo_white")
                         .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 115)
                        .offset(x:-15)
                    Spacer()
                }
            }
            .background(Color("DarkGrey"))
            NavigationLink(destination: PatientInfoView(model: InfoModel)) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
                    Text("Key details and information")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
                .padding(.top, 30)
            }
            .padding(.bottom, 30)
            
            NavigationLink(destination: TodosView(model: InfoModel)) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
                    Text("Daily Checklist")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 30)

            NavigationLink(destination: Calendar()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
                    Text("Calendar")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 30)
            
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 320, height: 45)
                    .foregroundColor(Color("LightGrey"))
                    .shadow(color: Color.black.opacity(0.4), radius: 4)
                Text("Learn more about ALS")
                    .foregroundColor(Color("DarkGrey"))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 30)
            .onTapGesture(perform: {
                showLearn.toggle()
            })
            
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 320, height: 45)
                    .foregroundColor(Color("LightGrey"))
                    .shadow(color: Color.black.opacity(0.4), radius: 4)
                Text("Take the ALS Quiz!")
                    .foregroundColor(Color("DarkGrey"))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 30)
            .onTapGesture(perform: {
                showQuiz.toggle()
            })
            Spacer()
        }
        .background(Color.white)
        .sheet(isPresented: $showQuiz, content: {
            QuizView(model: QuizModel)
        })
        .sheet(isPresented: $showLearn, content: {
            LearnView()
        })
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)

    }
}

struct vitalsView_Previews: PreviewProvider {
    static var previews: some View {
        vitalsView()
    }
}
