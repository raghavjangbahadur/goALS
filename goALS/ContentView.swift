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
        TabView {
            goalsView()
                .tabItem {
                    Label("Home", image: "home_logo_grey")
                }
            vitalsView()
                .tabItem {
                    Label("View Patient Info", image:"vitals_logo_grey")
                }
            tribalsView()
                .tabItem {
                    Label("Community", image:"tribals_logo_grey")
                }
            verbalsView()
                .tabItem {
                    Label("Communicate", image:"verbals_logo_grey")
                }
        }
        Divider()
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
