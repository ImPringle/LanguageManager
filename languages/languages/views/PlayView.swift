//
//  PlayView.swift
//  languages
//
//  Created by Mario Pringle on 31/03/24.
//

import SwiftUI

struct PlayView: View {
    let rules: [Rule]
    @State private var generatedString: String = "Σ"
    @State private var feed: [String] = []
    @State private var isContractive: String = "N/A"
    @State private var savedStrings: [String] = []
    @State private var isValidString: Bool = false
    @State private var showAlert: Bool = false
    
    
    
    var body: some View {

        
        HStack{
            VStack{
                Text("Rules")
                List(rules) { rule in
                    if (rule.rule[0] != "" && rule.rule[1] != ""){
                        Button(action:{
                            if let range = generatedString.range(of: rule.rule[0]) {
                                generatedString = generatedString.replacingCharacters(in: range, with: rule.rule[1])
                                feed.append("\(rule.rule[0]) → \(rule.rule[1])")
                            }
                        }){
                            HStack{
                                Text("\(rule.rule[0])")
                                Image(systemName: "arrow.right")
                                Text("\(rule.rule[1])")
                            }
                        }
                    }
                }
                .frame(width: 150)
            }
            
            
            Spacer()
            VStack{
                HStack{
                    Text("Generated String:")
                    Spacer()
                }
                Spacer()
                Text("\(generatedString)")
                    .font(.title)
                Spacer()
                HStack{
                    Text("Type:")
                    Spacer()
                    Text("N/A")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Contractive:")
                    Spacer()
                    Text("\(isContractive)")
                        .foregroundColor(.gray)
                }
                HStack{
                    Button("Reset") {
                        generatedString = "Σ"
                        feed = []
                    }
                    Spacer()
                    Button("Save String") {
                        self.isValidString = self.generatedString.allSatisfy {$0.isLowercase}
                        if (isValidString || generatedString == "λ")
                        {
                            savedStrings.append(generatedString)
                        }else{
                            self.showAlert = true
                        }
                        
                        //                        isValidString ? savedStrings.append(generatedString) : self.showAlert = true
                        
                        
                        
                    }
                }
            }
            .padding(.bottom)
            
            Spacer()
            VStack{
                Text("Feed")
                List {
                    ForEach(feed, id: \.self) { item in
                        Text("\(item)")
                            .foregroundColor(.gray)
                        
                    }
                }
                .frame(width: 150)
                
                Text("Saved Strings")
                List {
                    ForEach(savedStrings, id: \.self) { item in
                        Text("\(item)")
                            .foregroundColor(.gray)
                        
                    }
                }
                
                .frame(width: 150)
            }
            
        }
        .navigationTitle("Playing")
        .padding(.top)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("String not saved"),
                  message: Text("There is one or more non-terminal element"),
                  dismissButton: .default(Text("OK")))
        })
    }
        
}

#Preview {
    PlayView(rules: [Rule(rule: ["Σ", "λ"]),Rule(rule: ["S", "T"])])
}
