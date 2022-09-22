//
//  QuizView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/21/22.
//

import SwiftUI

struct QuizView: View {
    @Binding var correct: Int
    @Binding var incorrect: Int
    @Binding var answered: Int
    
    @ObservedObject var model = QuizViewModel()
    
    @Environment(\.presentationMode) var present
    var body: some View {
        ZStack {
            if model.questions.isEmpty {
                Text("Loading")
            }
            else {
                if (answered == model.questions.count) {
                    VStack(spacing: 25) {
                        Spacer()
                        Image(systemName: "trophy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 225, height: 225)
                            .foregroundColor(Color.yellow)
                            .padding()
                        
                        HStack(spacing: 15) {
                            Text("\(correct)/\(correct + incorrect)")
                                .font(.largeTitle)
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(Color.green)
                        }
                        .padding()
                        
                        if (correct > 12) {
                            Text("Amazing job!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding()
                        }
                        else if(correct > 8) {
                            Text("Good job!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding()
                        }
                        else{
                            Text("Learn about ALS using the links!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding()
                        }
                        
                        Button(action: {
                            present.wrappedValue.dismiss()
                        }, label: {
                            Text("Exit")
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 250, height: 30)
                                .background(Color.red)
                                .cornerRadius(15)
                        })
                        Spacer()
                    }
                }
                else {
                    VStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                            Capsule()
                                .fill(Color.gray.opacity(0.6))
                                .frame(height: 6)
                            Capsule()
                                .fill(Color.green)
                                .frame(width: userProgress(), height: 6)
                        })
                        .padding()
                        ZStack {
                            ForEach(model.questions.reversed().indices) { q in
                                QuestionView(question: $model.questions[q], correct: $correct, incorrect: $incorrect, answered: $answered)
                                    .offset(x: model.questions[q].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: model.questions[q].completed ? 10 : 0))
                            }
                        }
                        Label(title: { Text("\(correct)/\(correct + incorrect)")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                        }, icon: { Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(Color.green)
                        })
                    }
                    .padding()
                }
            }
        }.onAppear {
            model.getQuestion()
        }
    }
    
    func userProgress() -> CGFloat {
        let percentage = CGFloat(answered) / CGFloat(model.questions.count)
        let width = UIScreen.main.bounds.width - 30
        return percentage * width
    }
}


struct QuestionView: View{
    
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var incorrect: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack {
            Text(question.question!)
                .font(.title2)
                .padding(.top, 25)
            
            Spacer()
            
            if(question.answer == "All of the above") {
                VStack {
                    Button(action: {selected = question.option1!}, label: {
                        Text(question.option1!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.option1!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                    
                    Button(action: {selected = question.option2!}, label: {
                        Text(question.option2!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.option2!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                    
                    Button(action: {selected = question.answer!}, label: {
                        Text(question.answer!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.answer!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                }
            }
            else if(question.answer! == "speak, eat, move, hold, write, breathe, drink" || question.answer! == "Motor Neurons" || question.answer! == "Muscle cramps (or twitching), spasms, weakness in hands and feet, loss of balance, slurring of speech" || question.answer! == "Voluntary (in our control)") {
                VStack {
                    Button(action: {selected = question.option1!}, label: {
                        Text(question.option1!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.option1!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                    
                    Button(action: {selected = question.answer!}, label: {
                        Text(question.answer!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.answer!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                    
                    Button(action: {selected = question.option2!}, label: {
                        Text(question.option2!)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(outlineColor(userChoice: question.option2!), lineWidth: 1)
                            )
                    })
                    .padding(.bottom, 20)
                }
            }
            else {
                Button(action: {selected = question.answer!}, label: {
                    Text(question.answer!)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(outlineColor(userChoice: question.answer!), lineWidth: 1)
                        )
                })
                .padding(.bottom, 20)
                
                Button(action: {selected = question.option1!}, label: {
                    Text(question.option1!)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(outlineColor(userChoice: question.option1!), lineWidth: 1)
                        )
                })
                .padding(.bottom, 20)
                
                Button(action: {selected = question.option2!}, label: {
                    Text(question.option2!)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(outlineColor(userChoice: question.option2!), lineWidth: 1)
                        )
                })
                .padding(.bottom, 20)
            }
            HStack(spacing: 10) {
                Button(action: check, label: {
                    Text("Submit")
                        .padding(.vertical)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                .disabled(question.submitted ? true : false)
                .opacity(question.submitted ? 1 : 0.7)
                .padding()
                
                Button(action: {
                    withAnimation {
                        question.completed.toggle()
                        answered += 1
                    }
                }, label: {
                    Text("Next")
                        .padding(.vertical)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                .disabled(!question.submitted ? true : false)
                .opacity(!question.submitted ? 1 : 0.7)
            }
        }
        .background(Color.white)
        .cornerRadius(25)
        
    }
    
    func outlineColor(userChoice: String) -> Color {
        
        if (userChoice == selected) {
            if(question.submitted) {
                if(selected != question.answer!) {
                    return Color.red
                }
                else {
                    return Color.green
                }
            }
            else {
                return Color.blue
            }
        }
        else {
            if(question.submitted && userChoice != question.answer! && userChoice == selected) {
                return Color.red
            }
            if(question.submitted && userChoice == question.answer) {
                return Color.green
            }
            return Color.gray
        }
        
    }
    
    func check() {
        if (selected == question.answer!) {
            correct += 1
        }
        else {
            incorrect += 1
        }
        
        question.submitted.toggle()
    }
    
}

/*struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(correct: 0, incorrect: 0)
    }
}*/
