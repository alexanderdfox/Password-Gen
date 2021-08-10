//
//  ContentView.swift
//  SwiftyFoxPasswordiOS
//
//  Created by Alexander Fox on 8/9/21.
//  Copyright © 2021 Alexander Fox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var Length = 20.0
    @State private var Vowels = true
    @State private var Emojis = false
    @State private var Constanants = true
    @State private var Numbers = true
    @State private var Lowercase = true
    @State private var Uppercase = true
    @State private var Specials = true
    @State private var Other = true
    @State private var Password = ""
    @State private var Extras = ""
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all).foregroundColor(.black)
            ScrollView {
                VStack(alignment: .center, spacing: .some(15.0), content: {
                    Text("🦊").font(.system(size: 150.0)).padding(10.0)
                    HStack(alignment: .top, spacing: .some(15.0), content: {
                        Toggle("Vowels", isOn: $Vowels).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                        Toggle("Constanants", isOn: $Constanants).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                    }).clipShape(RoundedRectangle(cornerRadius:5))
                    HStack(alignment: .top, spacing: .some(15.0), content: {
                        Toggle("Lowercase", isOn: $Lowercase).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                        Toggle("Uppercase", isOn: $Uppercase).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                    }).clipShape(RoundedRectangle(cornerRadius:5))
                    HStack(alignment: .top, spacing: .some(15.0), content: {
                        Toggle("Numbers", isOn: $Numbers).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                        Toggle("Specials", isOn: $Specials).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                    }).clipShape(RoundedRectangle(cornerRadius:5))
                    HStack(alignment: .top, spacing: .some(15.0), content: {
                        Toggle("Emojis", isOn: $Emojis).accentColor(.orange).foregroundColor(.black).padding(5.0).background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                    }).clipShape(RoundedRectangle(cornerRadius:5))
                    HStack {
                        Text("Length").padding(10.0)
                        Slider(value: $Length, in: 1...100).accentColor(.orange).foregroundColor(.black).padding(5.0)
                    }.background(randColor()).clipShape(RoundedRectangle(cornerRadius:5))
                    Button(action: {update()}, label: {
                        Text("New Password").accentColor(.orange).foregroundColor(.white).padding(5.0)
                    }).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
                    TextField("Password: ", text: $Password).accentColor(.orange).foregroundColor(.blue).padding(10.0).textFieldStyle(RoundedBorderTextFieldStyle()).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
                })
            }
        }
    }
    
    func randColor() -> Color {
        return Color.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
    func update() {
        let pass = password(length: Int(Length), specialChars: Specials,vowelChars: Vowels, constChars: Constanants, numChars: Numbers, upperOnly: Uppercase, lowerOnly: Lowercase, extra: Other, Extras: Extras, emoji: Emojis)
        Password = pass
        UIPasteboard.general.string = Password
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
