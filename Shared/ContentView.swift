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
            PasswordGeneratorView()
                .tabItem {
                    Image(systemName: "key.fill")
                    Text("Password Generator")
                }
            
            CryptographyView()
                .tabItem {
                    Image(systemName: "lock.shield.fill")
                    Text("Encryption")
                }
        }
        .accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CryptographyView: View {
    @State private var emojiList = emojis().prefix(65)
    @State private var base64List = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    @State private var emojiBool = true
    @State private var toCrypt = ""
    @State private var toDecrypt = ""
    @State private var key = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Secure Encryption")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Encrypt and decrypt messages with military-grade security")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                }
                
                // Main Content Area
                HStack(alignment: .top, spacing: 32) {
                    // Left Column - Input
                    VStack(spacing: 24) {
                        // Input Section
                        VStack(spacing: 16) {
                            Text("Message to Encrypt")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Enter your message here...", text: $toCrypt)
                                .textFieldStyle(.roundedBorder)
                                .frame(minHeight: 100)
                        }
                        
                        // Options Section
                        VStack(spacing: 16) {
                            HStack {
                                Toggle("Use Emoji Encoding", isOn: $emojiBool)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                Spacer()
                            }
                            .padding(16)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                        
                        // Action Buttons
                        HStack(spacing: 16) {
                            Button(action: { cryptUpdate(emojiBool: emojiBool) }) {
                                HStack {
                                    Image(systemName: "lock.fill")
                                    Text("Encrypt")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                            
                            Button(action: { dcryptUpdate(emojiBool: emojiBool) }) {
                                HStack {
                                    Image(systemName: "lock.open.fill")
                                    Text("Decrypt")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Right Column - Output
                    VStack(spacing: 24) {
                        // Output Section
                        VStack(spacing: 16) {
                            Text("Encrypted Message")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Encrypted output will appear here", text: $toDecrypt)
                                .textFieldStyle(.roundedBorder)
                                .disabled(true)
                                .frame(minHeight: 100)
                        }
                        
                        // Key Section
                        VStack(spacing: 16) {
                            Text("Encryption Key")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Key will be generated automatically", text: $key)
                                .textFieldStyle(.roundedBorder)
                                .disabled(true)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Error Display
                if showError {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text(errorMessage)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(16)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            showError = false
                        }
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(32)
        }
    }
    
    func cryptUpdatePowerOf(power: Int64, emojiBool: Bool) {
        // Input validation
        guard power >= 0 && power <= 100 else {
            errorMessage = "Invalid power value. Must be between 0 and 100."
            showError = true
            return
        }
        
        let emojiMap = zip(base64List, emojiList).map { [String($0), String($1)] }
        if emojiBool {
            let crypted = emctothepowerof(power:power, input:toCrypt)
            guard !crypted.isEmpty else {
                errorMessage = "Encryption failed"
                showError = true
                return
            }
            
            guard crypted.count > 0, let crypt = crypted[crypted.count - 1] as? Array<Any>, crypt.count >= 2,
                  let encryptedData = crypt[0] as? Data,
                  let keyData = crypt[1] as? Data else {
                errorMessage = "Invalid encryption result"
                showError = true
                return
            }
            
            toDecrypt = encryptedData.base64EncodedString()
            key = keyData.base64EncodedString()
            
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
            guard crypted.count >= 2,
                  let encryptedData = crypted[0] as? Data,
                  let keyData = crypted[1] as? Data else {
                errorMessage = "Encryption failed"
                showError = true
                return
            }
            
            toDecrypt = encryptedData.base64EncodedString()
            key = keyData.base64EncodedString()
        }
    }
    
    func cryptUpdate(emojiBool: Bool) {
        let emojiMap = zip(base64List, emojiList).map { [String($0), String($1)] }
        if emojiBool {
            let crypted = crypt(input:toCrypt)
            guard crypted.count >= 2,
                  let encryptedData = crypted[0] as? Data,
                  let keyData = crypted[1] as? Data else {
                errorMessage = "Encryption failed"
                showError = true
                return
            }
            
            toDecrypt = encryptedData.base64EncodedString()
            key = keyData.base64EncodedString()
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
            guard crypted.count >= 2,
                  let encryptedData = crypted[0] as? Data,
                  let keyData = crypted[1] as? Data else {
                errorMessage = "Encryption failed"
                showError = true
                return
            }
            
            toDecrypt = encryptedData.base64EncodedString()
            key = keyData.base64EncodedString()
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
                
                guard let decodedData = Data(base64Encoded: tempDecrypt),
                      let decodedKey = Data(base64Encoded: tempkey) else {
                    errorMessage = "Invalid key or encrypted data format"
                    showError = true
                    return
                }
                
                let symmetricKey = SymmetricKey(data: decodedKey)
                let Dcrypted = dcrypt(input: decodedData, key: symmetricKey)
                
                guard !Dcrypted.isEmpty else {
                    errorMessage = "Decryption failed"
                    showError = true
                    return
                }
                
                toCrypt = String(decoding: Dcrypted, as: UTF8.self)
            }
            else {
                guard let decodedData = Data(base64Encoded: toDecrypt),
                      let decodedKey = Data(base64Encoded: key) else {
                    errorMessage = "Invalid key or encrypted data format"
                    showError = true
                    return
                }
                
                let symmetricKey = SymmetricKey(data: decodedKey)
                let Dcrypted = dcrypt(input: decodedData, key: symmetricKey)
                
                guard !Dcrypted.isEmpty else {
                    errorMessage = "Decryption failed"
                    showError = true
                    return
                }
                
                toCrypt = String(decoding: Dcrypted, as: UTF8.self)
            }
        }
    }
}

struct PasswordGeneratorView: View {
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
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "key.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password Generator")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Create strong, secure passwords instantly")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                }
                
                // Main Content Area
                HStack(alignment: .top, spacing: 32) {
                    // Left Column - Controls
                    VStack(spacing: 24) {
                        // Password Length Section
                        VStack(spacing: 16) {
                            HStack {
                                Text("Password Length")
                                    .font(.headline)
                                Spacer()
                                Text("\(Int(Length))")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            
                            Slider(value: $Length, in: 1...100, step: 1)
                                .accentColor(.blue)
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                        
                        // Character Types Section
                        VStack(spacing: 16) {
                            Text("Character Types")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                ToggleOption(title: "Vowels", isOn: $Vowels, icon: "a.circle.fill", color: .blue)
                                ToggleOption(title: "Consonants", isOn: $Consonants, icon: "b.circle.fill", color: .green)
                                ToggleOption(title: "Numbers", isOn: $Numbers, icon: "number.circle.fill", color: .orange)
                                ToggleOption(title: "Special Characters", isOn: $Specials, icon: "exclamationmark.circle.fill", color: .red)
                                ToggleOption(title: "Uppercase", isOn: $Uppercase, icon: "textformat.abc", color: .purple)
                                ToggleOption(title: "Lowercase", isOn: $Lowercase, icon: "textformat.abc.dottedunderline", color: .pink)
                                ToggleOption(title: "Emojis", isOn: $Emojis, icon: "face.smiling", color: .yellow)
                                ToggleOption(title: "Custom Characters", isOn: $Other, icon: "plus.circle.fill", color: .gray)
                            }
                        }
                        
                        // Custom Characters Section
                        if Other {
                            VStack(spacing: 16) {
                                Text("Custom Characters")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("Enter custom characters (optional)", text: $Extras)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        
                        // Generate Button
                        Button(action: { update() }) {
                            HStack {
                                Image(systemName: "wand.and.stars")
                                Text("Generate Password")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Right Column - Generated Password
                    VStack(spacing: 24) {
                        // Generated Password Section
                        VStack(spacing: 16) {
                            Text("Generated Password")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 12) {
                                Text(Password.isEmpty ? "Your password will appear here" : Password)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(Password.isEmpty ? .secondary : .primary)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(12)
                                    .frame(minHeight: 80)
                                
                                if !Password.isEmpty {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            #if os(iOS)
                                                UIPasteboard.general.string = Password
                                            #elseif os(macOS)
                                                NSPasteboard.general.setString(Password, forType: .string)
                                            #endif
                                        }) {
                                            HStack {
                                                Image(systemName: "doc.on.doc")
                                                Text("Copy to Clipboard")
                                            }
                                            .padding(12)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Error Display
                if showError {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text(errorMessage)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(16)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            showError = false
                        }
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(32)
        }
    }
    
    func update() {
        // Input validation
        guard Length >= 1 && Length <= 100 else {
            errorMessage = "Password length must be between 1 and 100"
            showError = true
            return
        }
        
        // Validate that at least one character type is selected
        guard Vowels || Consonants || Numbers || Lowercase || Uppercase || Specials || Emojis || Other else {
            errorMessage = "Please select at least one character type"
            showError = true
            return
        }
        
        let pass = password(length: Int(Length), specialChars: Specials,vowelChars: Vowels, constChars: Consonants, numChars: Numbers, upperOnly: Uppercase, lowerOnly: Lowercase, extra: Other, Extras: Extras, emoji: Emojis)
        
        guard !pass.isEmpty else {
            errorMessage = "Failed to generate password"
            showError = true
            return
        }
        
        Password = pass
    }
}

struct ToggleOption: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: color))
        }
        .padding(16)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
