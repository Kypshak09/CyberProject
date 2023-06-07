//
//  RealmManager.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 07.06.2023.
//

import RealmSwift
import Foundation

class RealmManager {
    
    static let shared = RealmManager()
    private init () {}
    
    
    
    let localRealm = try! Realm()
    
    func saveData(data: PersonalInfo) {
        try! localRealm.write {
            localRealm.add(data)
        }
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    func deleteData(data: PersonalInfo) {
        try! localRealm.write {
            localRealm.delete(data)
        }
    }
}
    


