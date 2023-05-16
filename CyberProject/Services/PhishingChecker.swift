//
//  PhishingChecker.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 16.05.2023.
//

import Foundation

class PhishingChecker {
    let apiKey = ""
    func phishingChecker(_ url: String, handler: @escaping(Bool) -> Void) {
        let apiUrl = "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=\(apiKey)"
        let threatTypes: [String] = ["MALWARE", "SOCIAL_ENGINEERING"]
        let platformTypes: [String] = ["ANY_PLATFORM"]
        let threatEntryTypes: [String] = ["URL"]
        let threatEntries: [[String: String]] = [["url": url]]
        
        let body: [String: Any] = [
            "threatInfo": [
                "threatTypes": threatTypes,
                "platformTypes": platformTypes,
                "threatEntryTypes": threatEntryTypes,
                "threatEntries": threatEntries
            ]
        ]
        
        guard let url = URL(string: apiUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                handler(false)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                handler(false)
                return
            }
            
            
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            handler(json?["matches"] != nil)
        }
        
        task.resume()
    }
    }
    

