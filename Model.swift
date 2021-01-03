//
//  Model.swift
//  SqueakyClean
//
//  Created by Preksha Munot on 7/30/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import Foundation
import CoreLocation
class Model: ObservableObject{
    @Published var loggedIn: Bool = UserDefaults.standard.bool(forKey: "loggedIn") {
        didSet{
            UserDefaults.standard.set(self.loggedIn, forKey: "loggedIn")
        }
    }
    @Published var name: String = UserDefaults.standard.string(forKey: "name") ?? ""{
        didSet{
            UserDefaults.standard.set(self.name, forKey: "name")
        }
    }
    @Published var home: String = UserDefaults.standard.string(forKey: "home") ?? ""{
        didSet{
            UserDefaults.standard.set(self.home, forKey: "home")
        }
    }
    @Published var longitude: Double = UserDefaults.standard.double(forKey: "longitude"){
        didSet{
            UserDefaults.standard.set(self.longitude, forKey: "longitude")
        }
    }
    @Published var latitude: Double = UserDefaults.standard.double(forKey: "latitude"){
        didSet{
            UserDefaults.standard.set(self.latitude, forKey: "latitude")
        }
    }
    @Published var enterHome: Int = UserDefaults.standard.integer(forKey: "enterHome"){
        didSet{
            UserDefaults.standard.set(self.enterHome, forKey: "enterHome")
        }
    }
    @Published var agreeWash: Int = UserDefaults.standard.integer(forKey: "agreeWash"){
        didSet{
            UserDefaults.standard.set(self.agreeWash, forKey: "agreeWash")
        }
    }
    @Published var logWash: Int = UserDefaults.standard.integer(forKey: "logWash"){
        didSet{
            UserDefaults.standard.set(self.logWash, forKey: "logWash")
        }
    }
    
}
extension Model {
    static var resetDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "resetDate") as? Date
        }
        set {
            guard let newValue = newValue else { return }
            guard let resetDate = resetDate else {
                UserDefaults.standard.set(newValue, forKey: "resetDate")
                return
            }
            if !Calendar.current.isDateInToday(resetDate) {
                Model.reset()
            }
            UserDefaults.standard.set(newValue, forKey: "resetDate")
        }
    }

    static func reset() {
        UserDefaults.standard.removeObject(forKey: "enterHome")
        UserDefaults.standard.removeObject(forKey: "agreeWash")
        UserDefaults.standard.removeObject(forKey: "logWash")
    }
}
