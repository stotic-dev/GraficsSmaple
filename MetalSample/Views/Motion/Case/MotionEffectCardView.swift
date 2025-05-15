//
//  MotionEffectCardView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/27.
//

import CoreMotion
import SwiftUI

struct MotionEffectCardView: View {
    
    @State private var motionManager = CMMotionManager()
    @State private var x: Double = 0
    @State private var y: Double = 0
    
    var body: some View {
        VStack {
            Slider(value: $x, in: -1...1)
            Slider(value: $y, in: -1...1)
            Text("x: \(x)")
            Text("y: \(y)")
            let x = x
            let y = y
            Image(.teaIcon)
                .resizable()
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fill)
                .visualEffect { effect, proxy in
                    effect.colorEffect(
                        ShaderLibrary.rareCard(
                            .float2(proxy.size.width, proxy.size.height),
                            .float2(x, y)
                        )
                    )
                }
                .colorEffect(ShaderLibrary.brightnessMotionColor(
                    .boundingRect,
                    .float2(x, y)
                ))
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
}

#Preview {
    MotionEffectCardView()
}
