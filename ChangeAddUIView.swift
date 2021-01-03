//
//  ChangeAddUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI
import CoreLocation

enum ActiveAlert3 {
    case first, second
}
struct ChangeAddUIView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var model: Model
    @EnvironmentObject var usersettings: UserSettings
    @State var dontsave: Bool = false
    @State var isActive9: Bool = false
    @State var ShowAlert2: Bool = false
    @State var ShowAlert3: Bool = false
    @State var currentLocationAlert: ActiveAlert3 = .first
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
               Image("enter home")
                   .resizable()
                   .scaledToFit()
                .overlay(AddressTextFieldOverlay(), alignment: .center)
            Image("OR")
            .resizable()
            .scaledToFit()
            
            Button(action: {
                self.ShowAlert2 = true
                    var currentLoc: CLLocation!
                    if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() == .authorizedAlways) {
                        currentLoc = CLLocationManager().location
                        self.model.longitude = currentLoc.coordinate.longitude
                        self.model.latitude = currentLoc.coordinate.latitude
                            self.currentLocationAlert = .first
                        }else{
                            self.currentLocationAlert = .second
                        }
                }) {
                    Image("current location")
                    .renderingMode(.original)
                }.alert(isPresented: $ShowAlert2){
                    switch currentLocationAlert{
                    case .first:
                        return Alert(title: Text("Home address is set to current location!"))
                    case .second:
                        return Alert(title: Text("Allow location access in settings in order for app to access your current location!"))
                    }
                }
            
            NavigationLink(destination: HomeUIView(model: model), isActive: self.$isActive9){
                   Text(" ")
               }
               Button(action: {
                if self.usersettings.enviormentHome.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                        self.model.home = self.usersettings.enviormentHome
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString(self.model.home, completionHandler: {(placemarks, error) -> Void in
                                    if((error) != nil){
                                        print("Error", error ?? "")
                                        self.ShowAlert3 = true
                                    }
                                    if let placemark = placemarks?.first {
                                        self.model.longitude = placemark.location?.coordinate.longitude as! Double
                                        self.model.latitude = placemark.location?.coordinate.longitude as! Double
                                    }
                                })
                }
                if self.model.longitude != 0 && self.model.latitude != 0{
                       self.usersettings.moveToHomeSettings = true
                   }
               }) {
                   Image("done button")
                   .renderingMode(.original)
               }
               .alert(isPresented: $ShowAlert3){
                       return Alert(title: Text("Home address is invalid!"))
                }
                   
               }
               .padding(.top,20)
                }.padding(.bottom,100)
       }
    }
