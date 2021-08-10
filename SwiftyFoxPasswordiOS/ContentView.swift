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
        ZStack() {
            Color.blue.edgesIgnoringSafeArea(.all).foregroundColor(.white)
            VStack(alignment: .center, spacing: .some(15.0), content: {
                Text("🦊").font(.system(size: 150.0))
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Vowels", isOn: $Vowels).accentColor(.orange).foregroundColor(.white)
                    Toggle("Constanants", isOn: $Constanants).accentColor(.orange).foregroundColor(.white)
                })
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Lowercase", isOn: $Lowercase).accentColor(.orange).foregroundColor(.white)
                    Toggle("Uppercase", isOn: $Uppercase).accentColor(.orange).foregroundColor(.white)
                })
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Numbers", isOn: $Numbers).accentColor(.orange).foregroundColor(.white)
                    Toggle("Specials", isOn: $Specials).accentColor(.orange).foregroundColor(.white)
                })
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Emojis", isOn: $Emojis).accentColor(.orange).foregroundColor(.white)
                })
                Slider(value: $Length, in: 1...100).accentColor(.orange).foregroundColor(.white)
                Button(action: {update()}, label: {
                    Text("New Password").accentColor(.orange).foregroundColor(.white)
                })
                TextField("Password: ", text: $Password).accentColor(.orange).foregroundColor(.white).border(Color.orange)
            })
        }
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
