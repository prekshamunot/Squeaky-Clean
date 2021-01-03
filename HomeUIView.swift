//
//  HomeUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI

struct HomeUIView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var model: Model
    @EnvironmentObject var usersettings: UserSettings
    @State private var isActive1: Bool = false
    @State private var isActive2: Bool = false
    @State private var isActive3: Bool = false
    var gscore: Int {
        var score = 0
        if model.enterHome > 0 {
            score = (model.agreeWash/model.enterHome) * 100
        } else {
            score = 100
        }
        return score
    }
    var body: some View {
        NavigationView{
        ZStack{
    
        Image("background2")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
        .navigationBarItems(leading: Button(action: {
            self.isActive1 = true
        }) {
            Image(systemName: "person.crop.circle")
            .imageScale(.large)
            .foregroundColor(.black)
        })
        NavigationLink(destination: SettingsUIView(model: model), isActive: $isActive1){
            Text("")
            }.isDetailLink(false)
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100, alignment: .top)
            Text("Welcome, \(model.name)!")
            .font(.custom("American Typewriter", size: 30))
            
            NavigationLink(destination: BeginUIView(model: model), isActive: self.$isActive2){
                Text("")
            }.isDetailLink(false)
            Button(action: {
                self.isActive2 = true
            }) {
                Image("log handwash")
                    .renderingMode(.original)
            }
            Group{
            Text("TODAY'S PROGRESS:")
            .font(.custom("American Typewriter", size: 35))
            Text("You washed your hands: ")
            .font(.custom("American Typewriter", size: 25))
                Text("\(self.model.logWash) times today")
            .font(.custom("American Typewriter", size: 25))
            Text("Goodness score:")
            .font(.custom("American Typewriter", size: 25))
                Text("\(self.gscore)%")
            .font(.custom("American Typewriter", size: 25))
            }
            NavigationLink(destination: StatsUIView(), isActive: self.$isActive3){
                Text("")
            }
            Button(action: {
                self.isActive3 = true
            }) {
                Image("check progress")
                .renderingMode(.original)
            }
            
        }
        .padding(.bottom,250)
            if $usersettings.userIsHome.wrappedValue {
                // But it will not show unless this variable is true
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.vertical)
                    // This VStack is the popup
                    VStack(spacing: 20){
                        Text("Wash Your Hands!")
                            .font(.custom("American Typewriter", size: 25))
                        Text("Welcome back home \(self.model.name)").font(.custom("American Typewriter", size: 20))
                        Text("Get to the soap before the germs get to you!").frame(alignment: .center).font(.custom("American Typewriter", size: 20))
                        Button(action: {
                            self.model.agreeWash += 1
                            self.model.enterHome += 1
                            self.isActive2 = true
                            self.usersettings.userIsHome = false
                        }) {
                            Text("Wash")
                        }
                        Button(action: {
                            self.model.enterHome += 1
                            self.usersettings.userIsHome = false
                        }) {
                            Text("Close")
                        }
                    }
                    .frame(width: 300, height: 250)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius: 20)
                }
            }
        }
        .onReceive(self.usersettings.$moveToHome){
            moveToHome in
            if moveToHome{
                self.isActive2 = false
                self.usersettings.moveToHome = false
            }
        }
        .onReceive(self.usersettings.$moveToHomeSettings){
            moveToHomeSettings in
            if moveToHomeSettings{
                self.isActive1 = false
                self.usersettings.moveToHomeSettings = false
            }
        }
            
        }
    }
}
