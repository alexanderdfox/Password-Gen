//
//  SwiftyFoxPasswordApp.swift
//  Shared
//
//  Created by Alexander Fox on 8/9/21.
//  Copyright © 2021 Alexander Fox. All rights reserved.
//

import SwiftUI

@main
struct SwiftyFoxPasswordApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, idealWidth: 1000, minHeight: 600, idealHeight: 700)
                .background(Color(.windowBackgroundColor))
        }
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
        #endif
        #elseif os(iOS)
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        #endif
    }
}
