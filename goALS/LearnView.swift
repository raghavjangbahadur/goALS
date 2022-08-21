//
//  LearnView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/21/22.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 350, height: 100)
                    .foregroundColor(.gray)
                    .padding(.all, 15)
                Text("Learn more about ALS")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            Text("[Understanding ALS](https://www.als.org/understanding-als)")
                .padding(.bottom, 20)
            Text("[Learn about dealing with ALS](https://iamals.org/get-help//#learn-about-als-understanding-als)")
                .padding(.bottom, 20)
            
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
