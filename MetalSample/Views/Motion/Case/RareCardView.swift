//
//  RareCardView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/27.
//

import SwiftUI

struct RareCardView: View {
    
    @Environment(\.motionRepository) var motionRepository
    @State private var showController = false
    @State private var x: Double = 0
    @State private var y: Double = 0
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation) { context in
            VStack {
                if showController {
                    controllerArea(context.date.timeIntervalSince(startTime))
                }
                Button {
                    showController.toggle()
                } label: {
                    Image(.teaIcon)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(contentMode: .fill)
                        .visualEffect { [x, y, time = context.date.timeIntervalSince(startTime)] effect, proxy in
                            effect
                                .colorEffect(
                                    ShaderLibrary.rareCard(
                                        .float2(proxy.size),
                                        .float2(x, y),
                                        .float(time)
                                    )
                                )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            guard motionRepository.isAvailable() else { return }
            motionRepository.didUpdate { result in
                switch result {
                case .success(let model):
                    x = model.x
                    y = model.y
                case .failure(let error):
                    print("error: \(error)")
                    motionRepository.stop()
                }
            }
        }
        .onDisappear {
            guard motionRepository.isAvailable() else { return }
            motionRepository.stop()
        }
    }
    
    func controllerArea(_ elapsedTime: TimeInterval) -> some View {
        VStack {
            Slider(value: $x, in: -1...1)
            Slider(value: $y, in: -1...1)
            Text("x: \(x)")
            Text("y: \(y)")
            Text("time: \(elapsedTime)")
        }
        .transition(.opacity)
    }
}

#Preview {
    RareCardView()
}
