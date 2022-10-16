//
//  ContentView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 6/28/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(.white)
    }

    var body: some View {
        VStack {
            TabView {
                goalsView()
                    .navigationBarHidden(true)
                    .tabItem {
                        Label(title: {
                            Text("Home")
                        }, icon: {
                            Image(systemName: "house.fill")
                        })
                    }
                vitalsView()
                    .accentColor(Color("DeepRed"))
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("View Patient Info", image:"vitals_logo_grey")
                    }
                tribalsView()
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("Community", image:"tribals_logo_grey")
                    }
                verbalsView()
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("Communicate", image:"verbals_logo_grey")
                    }
            }
        }
        .accentColor(Color("DeepRed"))
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
