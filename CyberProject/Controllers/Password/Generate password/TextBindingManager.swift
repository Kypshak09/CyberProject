//
//  TextBindingManager.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 05.06.2023.
//

import Foundation

final class TextBindingManager: ObservableObject {
    
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    
    let characterLimit: Int

    init(limit: Int = 30) {
        characterLimit = limit
    }
}
