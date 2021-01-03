//
//  BeginUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI

struct BeginUIView: View {
    @ObservedObject var model: Model
    @EnvironmentObject var usersettings: UserSettings
    @State private var isActive: Bool = false
    var body: some View {
        ZStack{
        Image("background2")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10){
                Image("soap")
                .resizable()
                .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .top)
                Text("Get your soap ready!")
                    .multilineTextAlignment(.center)
                    .font(.custom("American Typewriter", size: 50))
                NavigationLink( destination: TimerUIView(model: model), isActive: self.$isActive){
                    Text(" ")
                    .navigationBarHidden(true)
                }
                Button(action: {
                    self.isActive = true
                }) {
                    Image("begin button")
                    .renderingMode(.original)
                }
            }.padding(.bottom, 50)
        }
        }
    }
