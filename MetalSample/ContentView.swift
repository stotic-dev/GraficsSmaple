//
//  ContentView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("TextRenderer") {
                    TextRendererHomeView()
                }
                NavigationLink("Motion") {
                    MotionEffectPortfolioListView()
                }
            }
            .navigationTitle("Root")
        }
    }
}

#Preview {
    ContentView()
}
