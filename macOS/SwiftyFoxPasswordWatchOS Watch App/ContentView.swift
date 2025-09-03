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
    @State private var showSettings = false
    @State private var showPassword = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8) {
                    // Header
                    HStack {
                        Image(systemName: "key.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        Text("Password Gen")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    
                    // Length Slider
                    VStack(spacing: 4) {
                        HStack {
                            Text("Length")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(Int(Length))")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        
                        Slider(value: $Length, in: 4...20, step: 1)
                            .accentColor(.blue)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Generate Button
                    Button(action: { update() }) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Generate")
                        }
                        .font(.caption)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Settings Button
                    Button(action: { showSettings = true }) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Generated Password Display
                    if !Password.isEmpty {
                        VStack(spacing: 4) {
                            Text("Generated Password")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            
                            Text(Password)
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.primary)
                                .padding(6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                            
                            Button(action: { showPassword = true }) {
                                HStack {
                                    Image(systemName: "eye.fill")
                                    Text("View Full")
                                }
                                .font(.caption2)
                                .foregroundColor(.blue)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    }
                    
                    Spacer(minLength: 8)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(
                Vowels: $Vowels,
                Consonants: $Consonants,
                Numbers: $Numbers,
                Lowercase: $Lowercase,
                Uppercase: $Uppercase,
                Specials: $Specials,
                Emojis: $Emojis,
                Other: $Other,
                Extras: $Extras
            )
        }
        .sheet(isPresented: $showPassword) {
            PasswordDetailView(password: Password)
        }
    }
    
    func update() {
        let pass = password(length: Int(Length), specialChars: Specials,vowelChars: Vowels, constChars: Consonants, numChars: Numbers, upperOnly: Uppercase, lowerOnly: Lowercase, extra: Other, Extras: Extras, emoji: Emojis)
        Password = pass
    }
}

struct SettingsView: View {
    @Binding var Vowels: Bool
    @Binding var Consonants: Bool
    @Binding var Numbers: Bool
    @Binding var Lowercase: Bool
    @Binding var Uppercase: Bool
    @Binding var Specials: Bool
    @Binding var Emojis: Bool
    @Binding var Other: Bool
    @Binding var Extras: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 6) {
                    // Character Type Toggles
                    VStack(spacing: 4) {
                        ToggleRow(title: "Vowels", isOn: $Vowels, icon: "a.circle.fill", color: .blue)
                        ToggleRow(title: "Consonants", isOn: $Consonants, icon: "b.circle.fill", color: .green)
                        ToggleRow(title: "Numbers", isOn: $Numbers, icon: "number.circle.fill", color: .orange)
                        ToggleRow(title: "Special", isOn: $Specials, icon: "exclamationmark.circle.fill", color: .red)
                        ToggleRow(title: "Uppercase", isOn: $Uppercase, icon: "textformat.abc", color: .purple)
                        ToggleRow(title: "Lowercase", isOn: $Lowercase, icon: "textformat.abc.dottedunderline", color: .pink)
                        ToggleRow(title: "Emojis", isOn: $Emojis, icon: "face.smiling", color: .yellow)
                        ToggleRow(title: "Custom", isOn: $Other, icon: "plus.circle.fill", color: .gray)
                    }
                    
                    // Custom Characters Input
                    if Other {
                        VStack(spacing: 4) {
                            Text("Custom Characters")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Enter characters", text: $Extras)
                                .textFieldStyle(.roundedBorder)
                                .font(.caption)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Spacer(minLength: 8)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 16)
            
            Text(title)
                .font(.caption)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: color))
                .scaleEffect(0.8)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
    }
}

struct PasswordDetailView: View {
    let password: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Password Display
                VStack(spacing: 8) {
                    Text("Generated Password")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(password)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.primary)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .navigationTitle("Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
