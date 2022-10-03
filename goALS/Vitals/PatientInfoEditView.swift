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
        "       ", "Early", "Medium", "Late"
    ]
    let options: [String] = [
        "       ", "High", "Medium", "Low"
    ]
    let optionsYN: [String] = [
        "       ", "Yes", "No"
    ]
    
    let optionsGender: [String] = [
        "Male", "Female", "Other"
    ]
    
    var body: some View {
        ScrollView {
            Text("Edit patient information")
                .foregroundColor(Color("DarkGrey"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.bottom, 10)
            VStack {
                HStack {
                    Text("Gender")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $newGender,
                           content: {
                        ForEach(optionsGender, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("Edit:")
                            Text(newGender)
                                .foregroundColor(.red)
                        } .onAppear() {
                            newGender = model.patient.gender
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Age")
                        .padding(.trailing, 10)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $newAge,
                           content: {
                        ForEach(1..<120) { number in
                            Text("\(number)")
                                .tag(number)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text("\(newAge)")
                                .foregroundColor(.red)
                        }.onAppear() {
                            newAge = model.patient.age
                        }
                    })
                    
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $newStage,
                           content: {
                        ForEach(optionsStage, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(newStage)
                                .foregroundColor(.red)
                        }.onAppear() {
                            newStage = model.patient.stage
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Use of feeding tube")
                        .padding(.horizontal, 5)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $tube,
                           content: {
                        ForEach(optionsYN, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(tube)
                                .foregroundColor(.red)
                        }.onAppear() {
                            tube = model.patient.tube
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Hand strength/control, clumsiness, inability to hold items, difficulty, etc")
                        .padding(.trailing, 10)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $hands,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("")
                            Text(hands)
                                .foregroundColor(.red)
                        }.onAppear() {
                            hands = model.patient.hands
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly)")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $speech,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(speech)
                                .foregroundColor(.red)
                        }.onAppear() {
                            speech = model.patient.speech
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Muscle cramps/twitches")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $muscles,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(muscles)
                                .foregroundColor(.red)
                        }.onAppear() {
                            muscles = model.patient.muscles
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Difficulty walking, without tripping or falling")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $walking,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(walking)
                                .foregroundColor(.red)
                        }.onAppear() {
                            walking = model.patient.walking
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $legs,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(legs)
                                .foregroundColor(.red)
                        }.onAppear() {
                            legs = model.patient.legs
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Difficult breathing")
                        .padding(.horizontal, 3)
                    Spacer()
                    Text("Edit:")
                        .font(.system(size: 15))
                    Picker(selection: $breathing,
                           content: {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(breathing)
                                .foregroundColor(.red)
                        }.onAppear() {
                            breathing = model.patient.breathing
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
                
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 5)
                    .padding(10)
            }
            .onAppear {
                model.getSingleData()
            }
            Button(action: updateData) {
                Text("Update")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding()
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("DeepRed"))
                    )
            }
            .padding(.bottom)
            .padding(.top)
            
        }
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
