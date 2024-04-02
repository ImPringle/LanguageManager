//
//  ContentView.swift
//  languages
//
//  Created by Mario Pringle on 04/03/24.
//

import SwiftUI

struct ContentView: View {
    
//    Creating a Stante variable to store languages structs
    @State private var languages: [Language] =
    [
        Language(name: "Test Gram 1", desc: "Generates: {a^nb^n | n >= 0}", rules: [
                Rule(rule: ["Σ", "λ"]),
                Rule(rule: ["Σ", "S"]),
                Rule(rule: ["S", "aSb"]),
                Rule(rule: ["S", "ab"])
            ]),
        
    ]
    
//    This is my body struct (home) where I call my tableView
    var body: some View {
        NavigationStack{
            VStack {
                TableView(languages: $languages)
                    .navigationTitle("Home")
            }
            .padding()
        }
    }
}


// Struct for Languages
struct Language: Identifiable {
    var name: String
    var desc: String
    var rules: [Rule] = []
    let id = UUID()
}

// Struct for Rules
struct Rule: Identifiable {
    var rule: [String] = []
    let id = UUID()
}

#Preview {
        ContentView()
}
