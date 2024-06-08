//
//  OurSolarSystemApp.swift
//  OurSolarSystem
//
//  Created by Rahul Sharma on 04/06/24.
//

import SwiftUI

@main
struct OurSolarSystemApp: App {
    var body: some Scene {
        WindowGroup(id: "Content") {
            ContentView()
        }
        
        WindowGroup(id: "DetailView", for: String.self) { value in
            DetailView(title: value.wrappedValue!)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
