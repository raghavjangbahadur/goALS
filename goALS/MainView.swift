//
//  MainView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/14/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var model = LoginModel()
    var body: some View {
        if(model.loggedIn) {
            ContentView()
        }
        else {
            LoginView(model: model)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
