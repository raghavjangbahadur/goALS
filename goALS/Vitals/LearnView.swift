//
//  LearnView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/21/22.
//

import SwiftUI

struct LearnView: View {
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 350, height: 100)
                    .foregroundColor(Color("DarkGrey"))
                    .padding(.all, 15)
                Text("Learn more about ALS")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.all, 20)
            List(){
                Text("[Understanding ALS](https://www.als.org/understanding-als)")
                    .padding(10)
                Text("[Learn about dealing with ALS](https://iamals.org/get-help//#learn-about-als-understanding-als)")
                    .padding(10)
                Text("[ALS Fact Sheet](https://www.ninds.nih.gov/Disorders/Patient-Caregiver-Education/Fact-Sheets/Amyotrophic-lateral-Sclerosis-ALS-Fact-Sheet)")
                    .padding(10)
                Text("[ALS FAQs](https://iamals.org/get-help/frequently-asked-questions-about-als/)")
                    .padding(10)
                Text("[ALS Guide](https://youralsguide.com)")
                    .padding(10)
            }
            Spacer()
        }
        .padding()
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
