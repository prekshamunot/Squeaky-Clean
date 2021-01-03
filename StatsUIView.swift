//
//  StatsUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI

struct StatsUIView: View {
    @State var pickerSelectorItem = 0
    @State var dataPoints: [[CGFloat]] = [
        [50,150,100,30,180],
        [150,50,180,30,100]
    ]
    @State var axis: [[Int]] = [
        [100,0],
        [30,0]
    ]
    var fivedate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    var fourdate: String{
        let date = Date().addingTimeInterval(-86400)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    var threedate: String{
        let date = Date().addingTimeInterval(-172800)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    var twodate: String{
        let date = Date().addingTimeInterval(-259200)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    var onedate: String{
        let date = Date().addingTimeInterval(-345600)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    var body: some View {
        ZStack{
            Image("background2")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Handwash")
                .font(.system(size: 34))
                .fontWeight(.heavy)
                Picker(selection: $pickerSelectorItem, label: Text("")){
                    Text("Score").tag(0)
                    Text("Daily Washes").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal,24)
                HStack{
                VStack{
                Text("\(axis[pickerSelectorItem][0])")
                Rectangle()
                .fill(Color.black)
                .frame(width: 2, height: 180)
                    Text("\(axis[pickerSelectorItem][1])")
                }
                HStack(spacing:16){
                            VStack{
                                   ZStack(alignment: .bottom){
                                       Capsule().frame(width:30,height:200)
                                           .foregroundColor(Color(#colorLiteral(red: 0.5599757473, green: 0.7403558964, blue: 0.8839412035, alpha: 1)))
                                       Capsule().frame(width:30,height: dataPoints[pickerSelectorItem][0])
                                           .foregroundColor(.white)
                                   }
                                Text(self.onedate).padding(.top,8)
                                   
                               }
                               VStack{
                                   ZStack(alignment: .bottom){
                                       Capsule().frame(width:30,height:200)
                                           .foregroundColor(Color(#colorLiteral(red: 0.5599757473, green: 0.7403558964, blue: 0.8839412035, alpha: 1)))
                                       Capsule().frame(width:30,height: dataPoints[pickerSelectorItem][1])
                                           .foregroundColor(.white)
                                   }
                                Text(self.twodate).padding(.top,8)
                                   
                               }
                               VStack{
                                   ZStack(alignment: .bottom){
                                       Capsule().frame(width:30,height:200)
                                           .foregroundColor(Color(#colorLiteral(red: 0.5599757473, green: 0.7403558964, blue: 0.8839412035, alpha: 1)))
                                       Capsule().frame(width:30,height: dataPoints[pickerSelectorItem][2])
                                           .foregroundColor(.white)
                                   }
                                Text(self.threedate).padding(.top,8)
                                   
                               }
                               VStack{
                                   ZStack(alignment: .bottom){
                                       Capsule().frame(width:30,height:200)
                                           .foregroundColor(Color(#colorLiteral(red: 0.5599757473, green: 0.7403558964, blue: 0.8839412035, alpha: 1)))
                                       Capsule().frame(width:30,height: dataPoints[pickerSelectorItem][3])
                                           .foregroundColor(.white)
                                   }
                                Text(self.fourdate).padding(.top,8)
                                   
                               }
                               VStack{
                                   ZStack(alignment: .bottom){
                                       Capsule().frame(width:30,height:200)
                                           .foregroundColor(Color(#colorLiteral(red: 0.5599757473, green: 0.7403558964, blue: 0.8839412035, alpha: 1)))
                                       Capsule().frame(width:30,height: dataPoints[pickerSelectorItem][4])
                                           .foregroundColor(.white)
                                   }
                                Text(self.fivedate).padding(.top,8)
                                   
                               }
                           }.padding(.top,24)
                               .animation(.default)
                }
            }.padding(.bottom, 200)
                   }
               }
           }
