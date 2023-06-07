//
//  PersonalnfoModel.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 07.06.2023.
//

import RealmSwift
import Foundation

class PersonalInfo: Object {
    @objc dynamic var encryptedName: String = ""
    @objc dynamic var encryptedSurname: String = ""
}

