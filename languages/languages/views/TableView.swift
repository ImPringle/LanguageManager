//
//  TableView.swift
//  languages
//
//  Created by Mario Pringle on 06/03/24.
//

import SwiftUI

struct TableView: View {
    @Binding var languages: [Language]
//    @Binding var rules: [Rule]
    
    var body: some View {
        if languages.isEmpty {
            Spacer()
            Text("No languages to show")
                .foregroundColor(.gray)
            Spacer()
        } else {
            List(languages) { language in
                HStack{
                    HStack{
                        Text(language.name)
                        Text("-")
                        Text(language.desc)
                        Text(String(language.rules.count) + " Rules")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    HStack{
                        HStack{
                            NavigationLink(destination: EditView(language: language, languages: $languages)) {
                            }
                        }
                        
                        Button(action:{
                            if let index = self.languages.firstIndex(where: {$0.id == language.id}) {
                                languages.remove(at: index)
                            }
                        }){
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        Button(action:{
//            rules.append(Rule(rule: []))
            languages.append(Language(name: "New language", desc: "No description"))
            
        }){
            Text("Add Language")
        }
    }
}

#Preview {
    TableView(
        languages: .constant(
            [
                Language(name: "Gram 1", desc: "Description 1", rules: [Rule(rule: ["Σ", "λ"])]),
                Language(name: "Gram 2", desc: "Description 2"),
                Language(name: "Gram 3", desc: "Description 3")
            ]
        )
    )
}
