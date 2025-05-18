//
//  SuperRareCardView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/29.
//

import CoreMotion
import SwiftUI

struct SuperRareCardView: View {
    @State private var motionManager = CMMotionManager()
    @State var x: Double = 0
    @State var y: Double = 0
    let start = Date.now
    
    var body: some View {
        VStack {
            Slider(value: $x, in: -1...1)
            Slider(value: $y, in: -1...1)
            Text("x: \(x)")
            Text("y: \(y)")
            hologramImage()
        }
        .padding(.horizontal, 24)
        .onAppear {
            guard motionManager.isAccelerometerAvailable else { return }
            motionManager.accelerometerUpdateInterval = 0.05
            motionManager.startAccelerometerUpdates(to: .main) { motion, error in
                if let error {
                    print("error: \(error)")
                    motionManager.stopDeviceMotionUpdates()
                }
                
                guard let motion else { return }
                x = motion.acceleration.x
                y = motion.acceleration.y
            }
        }
        .onDisappear {
            guard motionManager.isAccelerometerAvailable,
                  motionManager.isAccelerometerActive else { return }
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    @ViewBuilder
    func hologramImage() -> some View {
        let x = x
        let y = y
        TimelineView(.animation) { context in
            let espelodeTime = start.timeIntervalSince(context.date)
            Image(.teaIcon)
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .visualEffect { effect, proxy in
                    effect
                        .colorEffect(
                            ShaderLibrary.superRareCard(
                                .float2(proxy.size),
                                .float(espelodeTime),
                                .float2(x, y)
                            )
                        )
                }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        SuperRareCardView()
    }
}
