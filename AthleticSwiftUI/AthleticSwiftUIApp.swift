//
//  AthleticSwiftUIApp.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

@main
struct AthleticSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ArticlesView(showFilterButtons: true, preselectedFilter: .everything)
            }
            .navigationViewStyle(.columns)
        }
    }
}
