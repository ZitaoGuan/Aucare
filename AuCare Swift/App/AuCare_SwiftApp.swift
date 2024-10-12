//
//  AuCare_SwiftApp.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 8/31/23.
//

import SwiftUI

@main
struct AuCare_SwiftApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
