//
//  ContentView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var model = Model()
    var body: some View {
        VStack{
            if model.loggedIn{
                HomeUIView(model: model).transition(.opacity)
            }else{
                LoginUIView(model: model).transition(.opacity)
            }
                   
        }.animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
