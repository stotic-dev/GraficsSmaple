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
            List(MetalSampleType.allCases) { type in
                Section(type.title) {
                    ForEach(type.contents) { content in
                        sampleListRow(content)
                    }
                }
            }
            .navigationTitle("Root")
        }
    }
    
    func sampleListRow(_ content: EffectContentModel) -> some View {
        NavigationLink {
            AnyView(content.destination)
        } label: {
            Text(content.title)
        }
    }
}

#Preview {
    ContentView()
}
