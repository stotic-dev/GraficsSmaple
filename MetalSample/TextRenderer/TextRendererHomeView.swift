//
//  TextRendererHomeView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/27.
//

import SwiftUI

struct TextRendererHomeView: View {
    @State var xOffset: Double = 0
    @State var time: TimeInterval = 0
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Hello World!!!!!")
                    .font(.system(size: 72))
                    .textRenderer(GradientTextRendere(xOffset: xOffset))
                Text("Hello \(highlightText("Highlight Text!!!"))")
                    .font(.system(size: 32))
                    .textRenderer(HighlightTextRenderer())
                Text("Hello \(colorfulText("Colorful Text!!!"))")
                    .font(.system(size: 32))
                    .textRenderer(ColorfulTextRenderer())
                Text("Hello Wave Text!!!")
                    .font(.system(size: 24))
                    .textRenderer(WaveTextRenderer(time: time))
            }
            .foregroundStyle(.white)
            .padding()
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)) {
                xOffset = 1
            }
            withAnimation(.linear(duration: 2).repeatForever()) {
                time = 1
            }
        }
    }
    
    func highlightText(_ text: String) -> Text {
        Text(text)
            .customAttribute(HighlightTextRenderer.Attribute())
    }
    
    func colorfulText(_ text: String) -> Text {
        Text(text)
            .foregroundStyle(.red)
            .customAttribute(ColorfulTextRenderer.Attribute())
    }
}

#Preview {
    TextRendererHomeView()
}
