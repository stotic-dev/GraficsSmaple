//
//  TextRendererHomeView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/27.
//

import SwiftUI

struct TextRendererHomeView: View {
    @State var xOffset: Double = 0
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Hello World!!!!!")
                    .font(.system(size: 72))
                    .textRenderer(GradientTextRendere(xOffset: xOffset))
            }
            .foregroundStyle(.white)
            .padding()
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)) {
                xOffset = 1
            }
        }
    }
}

#Preview {
    TextRendererHomeView()
}
