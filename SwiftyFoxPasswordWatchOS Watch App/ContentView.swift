//
//  ContentView.swift
//  SwiftyFoxPasswordWatchOS Watch App
//
//  Created by Alexander Fox on 9/28/22.
//  Copyright © 2022 Alexander Fox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var Length = 12.0
    @State private var Vowels = true
    @State private var Emojis = false
    @State private var Consonants = true
    @State private var Numbers = true
    @State private var Lowercase = true
    @State private var Uppercase = true
    @State private var Specials = true
    @State private var Other = true
    @State private var Password = ""
    @State private var Extras = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Length").padding(5.0).foregroundColor(.black)
                Slider(value: $Length, in: 1...100).accentColor(.orange).foregroundColor(.black).padding(5.0)
                Text("\(Length, specifier: "%0.f")").padding(5.0).foregroundColor(.black)
            }.background(Color.blue).clipShape(RoundedRectangle(cornerRadius:5))
            Button(action: {update()}, label: {
                Text("New Password").accentColor(.orange).foregroundColor(.white).padding(5.0)
            }).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
            TextField("Password: ", text: $Password).accentColor(.orange).foregroundColor(.blue).padding(5.0).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
    }
        .padding()
    }
    
    func update() {
        let pass = password(length: Int(Length), specialChars: Specials,vowelChars: Vowels, constChars: Consonants, numChars: Numbers, upperOnly: Uppercase, lowerOnly: Lowercase, extra: Other, Extras: Extras, emoji: Emojis)
        Password = pass
        
        #if os(iOS)
            UIPasteboard.general.string = Password
        #elseif os(macOS)
            NSPasteboard.general.setString(Password, forType: .string)
        #endif
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
