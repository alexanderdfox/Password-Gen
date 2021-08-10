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
            .frame(width: 600, height: 600, alignment: .center)
        }
        #elseif os(iOS)
        WindowGroup {
            ContentView()
        }
        #endif
    }
}
