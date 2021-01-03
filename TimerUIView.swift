//
//  TimerUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI

struct TimerUIView: View {
    @EnvironmentObject var usersettings: UserSettings
    @ObservedObject var model: Model
    @State var start = false
    @State var to : CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive6: Bool = false
    var body: some View{
        ZStack{
                
            Image("background2")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
                
                
            VStack{
                    
                ZStack{
                        
                    Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 220, height: 220)
                    Circle()
                    .trim(from: 0, to: self.to)
                    .stroke(Color.blue.opacity(0.7), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 220, height: 220)
                    .rotationEffect(.init(degrees: -90))
                        
                        
                    VStack{
                            
                        Text("\(self.count)")
                        .font(.system(size: 65))
                        .fontWeight(.bold)
                            
                        Text("Of 20")
                        .font(.title)
                        .padding(.top)
                        }
                    }
                    .padding(.top, 20)
                if(self.count < 5){
                    Image("handwash1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                        .animation(.default)
                        .padding(.top,20)
                }
                if(self.count > 4 && self.count < 9){
                    Image("handwash2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.top,20)
                }
                if(self.count > 8 && self.count < 13){
                    Image("handwash3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.top,20)
                }
                if(self.count > 12 && self.count < 17){
                    Image("handwash4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.top,20)
                }
                if(self.count > 16 && self.count <= 20){
                    Image("handwash5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.top,25)
                }
                NavigationLink(destination: ContentView().navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: self.$isActive6){
                    Text("")
                }
                Button(action: {
                    if self.count == 20{
                        self.model.logWash += 1
                        self.usersettings.moveToHome = true
                    }
                }) {
                    Image("done button")
                    .renderingMode(.original)
                }.padding(.top,10)

            }.padding(.bottom,60)
                
            }
            .onReceive(self.time) { (_) in
                
                    if self.count != 20{
                        
                        self.count += 1
                        
                        withAnimation(.default){
                            
                            self.to = CGFloat(self.count) / 20
                        }
                    }
                
            }
        }
    }
