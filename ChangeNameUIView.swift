//
//  ChangeNameUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI
struct ChangeNameUIView: View {
    @ObservedObject var model: Model
    @State var isActive8: Bool = false
    @State var dontsave: Bool = false
    @EnvironmentObject var usersettings: UserSettings
    var body: some View {
        ZStack{
            Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack{
                Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100, alignment: .top)
                    .padding(.bottom, 70)
                Image("enter name")
                    .resizable()
                    .scaledToFit()
                    .overlay(NameTextFieldOverlay(), alignment: .center)
                NavigationLink(destination: HomeUIView(model:model), isActive: self.$isActive8){
                    Text(" ")
                }
                Button(action: {
                    if self.usersettings.enviormentName.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                            self.model.name = self.usersettings.enviormentName
                    }
                    if self.usersettings.enviormentName.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                        self.dontsave = true
                    }else{
                        self.dontsave = false
                        self.usersettings.moveToHomeSettings = true
                    }
                }) {
                    Image("done button")
                    .renderingMode(.original)
                }.alert(isPresented: $dontsave){
                    return Alert(title: Text("Fill out the following field!"))
                }
                .padding(.top,20)
            }.padding(.bottom,100)
        }
    }
}
