//
//  SettingsUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    @ObservedObject var model: Model
    @State private var isActive4: Bool = false
    @State private var isActive5: Bool = false
    @State private var isActive6: Bool = false
    var body: some View {
        ZStack{
        Image("background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                
                Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100, alignment: .top)
                NavigationLink(destination: ChangeNameUIView(model:model), isActive: self.$isActive4){
                    Text("")
                }
                Button(action: {
                    self.isActive4 = true
                }) {
                    Image("change name")
                    .renderingMode(.original)
                    NavigationLink(destination: ChangeAddUIView(model: model), isActive: self.$isActive5){
                    Text("")
                }
                }
                Button(action: {
                    self.isActive5 = true
                }) {
                    Image("change address")
                    .renderingMode(.original)
                }
            }.padding(.bottom,350)
        }
        }
    }
