//
//  LoginUIView.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import SwiftUI
import CoreLocation

struct NameTextFieldOverlay: View{
    @EnvironmentObject var usersettings: UserSettings
    var body: some View{
        TextField("", text:$usersettings.enviormentName)
            .font(.callout)
            .textFieldStyle(RoundedBorderTextFieldStyle())

    }
}
struct AddressTextFieldOverlay: View{
    @State private var showingPlaces: Bool = false
    @EnvironmentObject var usersettings: UserSettings
    var body: some View{
        TextField("", text:$usersettings.enviormentHome)
            .simultaneousGesture(TapGesture().onEnded {
              self.showingPlaces = true
            })
            .font(.callout)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
        .sheet(isPresented: $showingPlaces){
            PlacePicker( address: "")
        }

    }
}
enum ActiveAlert {
    case first, second
}
enum ActiveAlert2 {
    case first, second
}
struct LoginUIView: View {
    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var usersettings: UserSettings
    @ObservedObject var model: Model
    @State var wrongaddress: Bool = false
    @State var showAlert: Bool = false
    @State var currentLocationAlert: ActiveAlert = .first
    @State var showAlert2: Bool = false
    @State var loginfail: ActiveAlert2 = .first
    var body: some View {
        
        ZStack{
            Image("background2")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack(spacing:10){
                Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 150)
 
                Image("enter name")
                .resizable()
                .scaledToFit()
                    .overlay(NameTextFieldOverlay(), alignment: .center)
                Image("enter home")
                .resizable()
                .scaledToFit()
                    .overlay(AddressTextFieldOverlay(), alignment: .center)
                Image("OR")
                .resizable()
                .scaledToFit()
                
                Button(action: {
                    self.showAlert = true
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
                }.alert(isPresented: $showAlert){
                    switch currentLocationAlert{
                    case .first:
                        return Alert(title: Text("Home address is set to current location!"))
                    case .second:
                        return Alert(title: Text("Allow location access in settings in order for app to access your current location!"))
                    }
                }
            
                Button(action: {
                    self.showAlert2 = true
                    if self.usersettings.enviormentName.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                            self.model.name = self.usersettings.enviormentName
                    }
                    if self.usersettings.enviormentHome.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                            self.model.home = self.usersettings.enviormentHome
                            let geocoder = CLGeocoder()
                            geocoder.geocodeAddressString(self.model.home, completionHandler: {(placemarks, error) -> Void in
                                        if((error) != nil){
                                            print("Error", error ?? "")
                                            self.loginfail = .first
                                        }
                                        if let placemark = placemarks?.first {
                                            self.model.longitude = placemark.location?.coordinate.longitude as! Double
                                            self.model.latitude = placemark.location?.coordinate.longitude as! Double
                                        }
                                    })
                    }
                    if self.model.name.trimmingCharacters(in: .whitespacesAndNewlines) != "" && self.model.longitude != 0 && self.model.latitude != 0 {
                        withAnimation(.easeInOut(duration: 1.0)){
                            self.model.loggedIn = true
                        }
                    }else{
                        self.loginfail = .second
                    }
                }) {
                Image("begin button")
                .renderingMode(.original)
                }
                .alert(isPresented: $showAlert2){
                    switch loginfail{
                    case .first:
                        return Alert(title: Text("Home address is invalid!"))
                    case .second:
                        return Alert(title: Text("Please fill in all fields!"))
                    }
                    
                }
            }.padding(.bottom,50)
        }
    }
}

