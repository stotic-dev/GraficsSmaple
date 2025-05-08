//
//  WaveTextRenderer.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/19.
//

import SwiftUI

struct WaveTextRenderer: TextRenderer, Animatable {
    var time: Double
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (index, grif) in run.enumerated() {
                    let offset = getWaveOffset(index: index, totalGrif: layout.flattenedRunSlices.count, waveWidth: 9, time: time)
                    var copy = ctx
                    copy.translateBy(x: 0, y: offset)
                    copy.draw(grif)
                }
            }
        }
    }
    
    func getWaveOffset(
        index: Int,
        totalGrif: Int,
        waveWidth: Double,
        time: Double
    ) -> Double {
        
        let position = (Double(index) / Double(totalGrif)) * waveWidth
        let radian = (position + (time * waveWidth)) / waveWidth * 2 * .pi
        return sin(radian) * waveWidth
    }
}

#Preview {
    @Previewable @State var time: TimeInterval = 0
    VStack {
        Text("Hello World!!!")
            .font(.title)
            .textRenderer(WaveTextRenderer(time: time))
    }
    .onAppear {
        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
            time = 1
        }
    }
}
