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
            ZStack{
                HStack{
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    Spacer()
                }
                HStack{
                    Image("vitals_logo_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120, alignment: .center)
                        .offset(y: 2)
                }
            }
            .background(Color("DarkGrey"))
            NavigationLink(destination: PatientInfoView(model: InfoModel)) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
                    Text("Key Details and Information")
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
        .navigationBarHidden(true)

    }
}

struct vitalsView_Previews: PreviewProvider {
    static var previews: some View {
        vitalsView()
    }
}
