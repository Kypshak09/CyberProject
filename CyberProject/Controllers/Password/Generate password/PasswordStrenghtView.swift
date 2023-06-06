//
//  PasswordStrenghtView.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 05.06.2023.
//

import SwiftUI

struct PasswordStrenghtView: View {
    
    let entropy:Double
    let characterCount: Double
    @State private var animate = false
    
    var body: some View {
        
        
        VStack {
            HStack {
                
                Image(systemName: "shield.fill")
                            .foregroundColor(entropyColor(entropy: entropy))
                            .font(.largeTitle)
            
                    .overlay(
                             Text("\(Int(entropy))")
                                 .foregroundColor(.white)
                                .font(.footnote)
                                .bold()
                             
                    )
               
                
            }
        }
    }
}

extension View {
    
    func entropyText(entropy: Double) -> LocalizedStringKey {
        
        switch entropy {
        case 128.0...200:
            return "very robust"
        case 60.0...128:
            return "Robust"
        case 36.0...60:
            return "Average"
        case 28.0...36:
            return "Weak"
        default:
            return "Very weak"
        }
    }
    
    func entropyColor(entropy: Double) -> Color {
        
        switch entropy {
        case 128.0...200:
            return .blue
        case 60.0...128:
            return .green
        case 36.0...60:
            return .yellow
        case 28.0...36:
            return .orange
        default:
            return .red
        }
    }
}

struct PasswordStrenghtView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordStrenghtView(entropy: 200, characterCount: 20)
    }
}
