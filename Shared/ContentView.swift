//
//  ContentView.swift
//  SwiftyFoxPassword
//
//  Created by Alexander Fox on 8/9/21.
//  Copyright © 2021 Alexander Fox. All rights reserved.
//

import SwiftUI
import CryptoKit

struct ContentView: View {
    var body: some View {
        TabView {
            passwordView().tabItem {Text("Password")}.background(Color.green).ignoresSafeArea(.all)
            cryptView().tabItem {Text("Cryptography")}.background(Color.orange).ignoresSafeArea(.all)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct cryptView: View {
    
    @State private var emojiList = emojis().prefix(65)
    @State private var base64List = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    @State private var emojiBool = true
    @State private var toCrypt = ""
    @State private var toDecrypt = ""
    @State private var key = ""
    
    var body: some View {
        ScrollView {
            HStack(alignment: .center, spacing: .zero, content: {
                VStack(alignment: .center, spacing: .zero, content: {
                Link("🦊", destination: URL(string:"https://www.alexdfox.com/")!).font(.system(size: 150.0)).padding(10.0)
                VStack(alignment: .center, spacing: .some(15.0), content: {
                    Text("Message:").padding(5.0).foregroundColor(.black).background(Color.green).clipShape(RoundedRectangle(cornerRadius:5))
                    TextField("Message to Encrypt", text: $toCrypt).accentColor(.orange).foregroundColor(.blue).padding(5.0).textFieldStyle(RoundedBorderTextFieldStyle()).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
                })
                VStack(alignment: .center, spacing: .some(15.0), content: {
                    Text("Encrypted:").padding(5.0).foregroundColor(.black).background(Color.yellow).clipShape(RoundedRectangle(cornerRadius:5))
                    TextField("Message to Decrypt", text: $toDecrypt).accentColor(.orange).foregroundColor(.blue).padding(5.0).textFieldStyle(RoundedBorderTextFieldStyle()).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
                })
                VStack(alignment: .center, spacing: .some(15.0), content: {
                    Text("Key:").padding(5.0).foregroundColor(.black).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
                    TextField("Key", text: $key).accentColor(.orange).foregroundColor(.blue).padding(5.0).textFieldStyle(RoundedBorderTextFieldStyle()).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
                })
                Toggle("Emojis:", isOn: $emojiBool).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
                Button(action: {cryptUpdate(emojiBool: emojiBool)}, label: {
                    Text("Encrypt").accentColor(.orange).foregroundColor(.white).padding(5.0)
                }).background(Color.pink).clipShape(RoundedRectangle(cornerRadius:5))
                Button(action: {dcryptUpdate(emojiBool: emojiBool)}, label: {
                    Text("Decrypt").accentColor(.orange).foregroundColor(.white).padding(5.0)
                }).background(Color.blue).clipShape(RoundedRectangle(cornerRadius:5))
            })
            })
        }
    }
    
    func cryptUpdatePowerOf(power: Int64, emojiBool: Bool) {
        let emojiMap = zip(base64List, emojiList).map { [String($0), String($1)] }
        if emojiBool {
            let crypted = emctothepowerof(power:power, input:toCrypt)
            let crypt = crypted[crypted.count] as! Array<Any>
            toDecrypt = (crypt[0] as! Data).base64EncodedString()
            key = (crypt[1] as! Data).base64EncodedString()
            var tempkey  = ""
            for k in key {
                for emoji in emojiMap.enumerated() {
                    if String(k) == emojiMap[emoji.offset][0] {
                        tempkey += emojiMap[emoji.offset][1]
                    }
                }
            }
            key = tempkey
            var tempDecrypt  = ""
            for k in toDecrypt {
                for emoji in emojiMap.enumerated() {
                    if String(k) == emojiMap[emoji.offset][0] {
                        tempDecrypt += emojiMap[emoji.offset][1]
                    }
                }
            }
            toDecrypt = tempDecrypt
        }
        else {
            let crypted = crypt(input:toCrypt)
            toDecrypt = (crypted[0] as! Data).base64EncodedString()
            key = (crypted[1] as! Data).base64EncodedString()
        }
    }
    
    func cryptUpdate(emojiBool: Bool) {
        let emojiMap = zip(base64List, emojiList).map { [String($0), String($1)] }
        if emojiBool {
            let crypted = crypt(input:toCrypt)
            toDecrypt = (crypted[0] as! Data).base64EncodedString()
            key = (crypted[1] as! Data).base64EncodedString()
            var tempkey  = ""
            for k in key {
                for emoji in emojiMap.enumerated() {
                    if String(k) == emojiMap[emoji.offset][0] {
                        tempkey += emojiMap[emoji.offset][1]
                    }
                }
            }
            key = tempkey
            var tempDecrypt  = ""
            for k in toDecrypt {
                for emoji in emojiMap.enumerated() {
                    if String(k) == emojiMap[emoji.offset][0] {
                        tempDecrypt += emojiMap[emoji.offset][1]
                    }
                }
            }
            toDecrypt = tempDecrypt
        }
        else {
            let crypted = crypt(input:toCrypt)
            toDecrypt = (crypted[0] as! Data).base64EncodedString()
            key = (crypted[1] as! Data).base64EncodedString()
        }
    }
    
    func dcryptUpdate(emojiBool: Bool) {
        let emojiMap = zip(emojiList, base64List).map { [String($0), String($1)] }
        if key != "" && toDecrypt != "" {
            if emojiBool {
                var tempkey  = ""
                for k in key {
                    for emoji in emojiMap.enumerated() {
                        if String(k) == emojiMap[emoji.offset][0] {
                            tempkey += emojiMap[emoji.offset][1]
                        }
                    }
                }
                var tempDecrypt  = ""
                for k in toDecrypt {
                    for emoji in emojiMap.enumerated() {
                        if String(k) == emojiMap[emoji.offset][0] {
                            tempDecrypt += emojiMap[emoji.offset][1]
                        }
                    }
                }
                let Dcrypted = dcrypt(input: Data(base64Encoded: tempDecrypt)!, key: SymmetricKey(data: Data(base64Encoded: tempkey)!))
                toCrypt = String(decoding: Dcrypted, as: UTF8.self)
            }
            else {
                let Dcrypted = dcrypt(input: Data(base64Encoded: toDecrypt)!, key: SymmetricKey(data: Data(base64Encoded: key)!))
                toCrypt = String(decoding: Dcrypted, as: UTF8.self)
            }
        }
    }
}

struct passwordView: View {
    
    @State private var Length = 20.0
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
        ScrollView {
        VStack(alignment: .center, spacing: .zero, content: {
                Link("🦊", destination: URL(string:"https://www.alexdfox.com/")!).font(.system(size: 150.0)).padding(10.0)
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Vowels", isOn: $Vowels).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.blue).clipShape(RoundedRectangle(cornerRadius:5))
                    Toggle("Consonants", isOn: $Consonants).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.gray).clipShape(RoundedRectangle(cornerRadius:5))
                }).clipShape(RoundedRectangle(cornerRadius:5))
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Lowercase", isOn: $Lowercase).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
                    Toggle("Uppercase", isOn: $Uppercase).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.pink).clipShape(RoundedRectangle(cornerRadius:5))
                }).clipShape(RoundedRectangle(cornerRadius:5))
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Numbers", isOn: $Numbers).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.purple).clipShape(RoundedRectangle(cornerRadius:5))
                    Toggle("Specials", isOn: $Specials).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
                }).clipShape(RoundedRectangle(cornerRadius:5))
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Toggle("Emojis", isOn: $Emojis).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.white).clipShape(RoundedRectangle(cornerRadius:5))
                    Toggle("Extras", isOn: $Other).accentColor(.orange).foregroundColor(.black).padding(5.0).background(Color.yellow).clipShape(RoundedRectangle(cornerRadius:5))
                }).clipShape(RoundedRectangle(cornerRadius:5))
                HStack(alignment: .top, spacing: .some(15.0), content: {
                    Text("Extras").padding(5.0).foregroundColor(.black).background(Color.yellow)
                    TextField("Insert Characters", text: $Extras).accentColor(.orange).foregroundColor(.black).padding(5.0).clipShape(RoundedRectangle(cornerRadius:5))
                }).clipShape(RoundedRectangle(cornerRadius:5)).background(Color.yellow)
                HStack {
                    Text("Length").padding(5.0).foregroundColor(.black)
                    Slider(value: $Length, in: 1...100).accentColor(.orange).foregroundColor(.black).padding(5.0)
                    Text("\(Length, specifier: "%0.f")").padding(5.0).foregroundColor(.black)
                }.background(Color.blue).clipShape(RoundedRectangle(cornerRadius:5))
                Button(action: {update()}, label: {
                    Text("New Password").accentColor(.orange).foregroundColor(.white).padding(5.0)
                }).background(Color.red).clipShape(RoundedRectangle(cornerRadius:5))
                TextField("Password: ", text: $Password).accentColor(.orange).foregroundColor(.blue).padding(5.0).textFieldStyle(RoundedBorderTextFieldStyle()).scaledToFit().background(Color.orange).clipShape(RoundedRectangle(cornerRadius:5))
        })
        }
        
        
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
