//
//  MenuView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//

import SwiftUI

struct MenuView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(.white)
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
