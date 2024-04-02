//
//  EditView.swift
//  languages
//
//  Created by Mario Pringle on 06/03/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    
    

    @State private var name: String
    @State private var desc: String
    @State private var rules: [Rule]
    

    let language: Language
    @Binding var languages: [Language]
    var index_: Int = 0

    init(language: Language, languages: Binding<[Language]>) {
        self._name = State(initialValue: language.name)
        self._desc = State(initialValue: language.desc)
        self._rules = State(initialValue: language.rules)
        self.language = language
        self._languages = languages
    }

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                
            TextField("Description", text: $desc)
            Spacer()
            Text("Rules")
                .font(.headline)
            if rules.isEmpty {
                Text("No rules to show")
                    .foregroundColor(.gray)
            } else {
                List ($rules) { rule in
                    HStack{
                        TextField("Left", text: rule.rule[0])
                        Image(systemName: "arrow.right")
                        TextField("Right", text: rule.rule[1])
                        Button(action:{
                            if let index = self.rules.firstIndex(where: {$0.id == rule.id}) {
                                rules.remove(at: index)}
                        }){
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            
            Spacer()
            HStack {
                Button(action:{
                    if rules.isEmpty{
                        rules.append(Rule(rule: ["Σ",""]))
                    }else{
                        rules.append(Rule(rule: ["",""]))
                    }
                }){
                    Image(systemName: "plus")
                        
                }
            
                Button(action:{
                    rules.append(Rule(rule: ["Σ", "λ"]))
                }){
                    Text("Σ→λ")
                }
                
                NavigationLink(destination: PlayView(rules: rules)) {
                    Image(systemName: "play")
                        .foregroundColor(.green)
                }
                
                Spacer()
                Button ("Save") {
                    if let index = self.languages.firstIndex(where: {$0.id == self.language.id
                    }) {
                        self.languages[index].name = self.name
                        self.languages[index].desc = self.desc
                        self.languages[index].rules = self.rules
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
                
            }
            
            
        }
        .padding()
        .navigationTitle("Editing")
        
        
    }
    
    
}

#Preview {
    EditView(language: Language(name: "Gram 1", desc: "Description 1"), languages: .constant([Language(name: "Gram 1", desc:                                  "Description 1"),
                                                                                              Language(name: "Gram 2", desc: "Description 2"),
                                                                                              Language(name: "Gram 3", desc: "Description 3")]))
}
