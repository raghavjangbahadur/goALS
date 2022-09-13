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
                .foregroundColor(.teal)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            VStack {
                HStack {
                    Text("Gender")
                        .padding(.horizontal, 3)
                    Spacer()
                    Picker(selection: $newGender,
                           content: {
                        ForEach(optionsGender, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }, label: {
                        HStack {
                            Text("       ")
                            Text(newGender)
                                .foregroundColor(.red)
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Age")
                        .padding(.trailing, 10)
                    Spacer()
                    Stepper("\(newAge)", value: $newAge)
                    
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                        .padding(.horizontal, 3)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Use of feeding tube")
                        .padding(.horizontal, 5)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Hand strength/control, clumsiness, inability to hold items, difficulty, etc")
                        .padding(.trailing, 10)
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
                            Text(hands)
                                .foregroundColor(.red)
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly)")
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
                            Text("       ")
                            Text(speech)
                                .foregroundColor(.red)
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                HStack {
                    Text("Muscle cramps/twitches")
                        .padding(.horizontal, 3)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Difficulty walking, without tripping or falling")
                        .padding(.horizontal, 3)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .padding(.horizontal, 3)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Difficult breathing")
                        .padding(.horizontal, 3)
                    Spacer()
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
                        }
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
            }.onAppear {
                model.getSingleData()
            }
            
            Button("Update", action: updateData)
                .padding(.bottom)
            
        }
    }
    func updateData() {
        var values = [String: Any]()
        if newGender != "       " {
            values["patientGender"] = newGender
        }
        if newAge != 0 {
            values["patientAge"] = newAge
        }
        if newStage != "       " {
            values["stage"] = newStage
        }
        if tube != "       " {
            values["feedingTube"] = tube
        }
        if hands != "       " {
            values["hands"] = hands
        }
        if speech != "       " {
            values["speech"] = speech
        }
        if muscles != "       " {
            values["muscles"] = muscles
        }
        if !values.isEmpty {
            model.updateData(values)
        }
    }
}

struct PatientInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoEditView()
    }
}
