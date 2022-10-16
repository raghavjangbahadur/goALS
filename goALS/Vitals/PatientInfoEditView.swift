//
//  PatientInfoEditView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//
import SwiftUI

struct PatientInfoEditView: View {
    
    @ObservedObject var model = PatientInfoModel()
    @State private var newGender: String = ""
    @State private var newStage: String = ""
    @State private var newAge: Int = 0
    @State private var tube: String = ""
    @State private var hands: String = ""
    @State private var speech: String = ""
    @State private var muscles: String = ""
    @State private var walking: String = ""
    @State private var legs: String = ""
    @State private var breathing: String = ""
    
    init() {
        model.getSingleData()
    }
    
    let optionsStage: [String] = [
        "Early", "Medium", "Late"
    ]
    let options: [String] = [
        "Low", "Medium", "High"
    ]
    let optionsYN: [String] = [
        "No", "Yes"
    ]
    
    let optionsGender: [String] = [
        "Male", "Female", "Other"
    ]
    
    var body: some View {
        VStack{
            List{
                HStack {
                    Text("Gender")
                        .padding(.horizontal, 3)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $newGender,
                           content: {
                        ForEach(optionsGender, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        } .onAppear() {
                            newGender = model.patient.gender
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("Age")
                        .padding(.trailing, 10)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $newAge,
                           content: {
                        ForEach(1..<120) { number in
                            Text("\(number)")
                                .tag(number)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            newAge = model.patient.age
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                    
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("[Stage of ALS](https://alsnewstoday.com/stages-of-als/)")
                        .padding(.horizontal, 3)
                        .accentColor(.blue)
                    Spacer()
                    Picker(selection: $newStage,
                           content: {
                        ForEach(optionsStage, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            newStage = model.patient.stage
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("Use of feeding tube")
                        .padding(.horizontal, 5)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $tube,
                           content: {
                        ForEach(optionsYN, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            tube = model.patient.tube
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("Hand strength/control, clumsiness, inability to hold items, difficulty, etc")
                        .padding(.trailing, 10)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $hands,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            hands = model.patient.hands
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly)")
                        .foregroundColor(Color("DarkGrey"))
                        .padding(.horizontal, 3)
                    Spacer()
                    Picker(selection: $speech,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            speech = model.patient.speech
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                HStack {
                    Text("Muscle cramps/twitches")
                        .padding(.horizontal, 3)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $muscles,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            muscles = model.patient.muscles
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                
                HStack {
                    Text("Difficulty walking, without tripping or falling")
                        .padding(.horizontal, 3)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $walking,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            walking = model.patient.walking
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .padding(.horizontal, 3)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $legs,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            legs = model.patient.legs
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
                
                HStack {
                    Text("Difficult breathing")
                        .padding(.horizontal, 3)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Picker(selection: $breathing,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                        }.onAppear() {
                            breathing = model.patient.breathing
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)

            }
            Button(action: updateData) {
                Text("Update")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding(10)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("DeepRed"))
                    )
            }
            .padding()
        }
        .navigationBarColor(.white)
        .onAppear {
            model.getSingleData()
        }
        .navigationTitle("Edit Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    func updateData() {
        var values = [String: Any]()
        values["patientGender"] = newGender
        values["patientAge"] = newAge
        values["stage"] = newStage
        values["feedingTube"] = tube
        values["hands"] = hands
        values["speech"] = speech
        values["muscles"] = muscles
        values["walking"] = walking
        values["legs"] = legs
        values["breathing"] = breathing
        model.updateData(values)
    }
}

struct PatientInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoEditView()
    }
}
