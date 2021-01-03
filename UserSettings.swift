//
//  UserSettings.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import Foundation
import Combine
class UserSettings: ObservableObject{
    @Published var notifylog: Int = 0
    @Published var logwash: Int = 0
    @Published var enviormentName: String = ""
    @Published var enviormentHome: String = ""
    @Published var moveToHome: Bool = false
    @Published var moveToHomeSettings: Bool = false
    @Published var userIsHome: Bool = false
}
