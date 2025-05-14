//
//  HueRotationSample.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/01.
//

import SwiftUI

struct HueRotationSample: View {
    @State var offset: Double = 0
    var body: some View {
        VStack {
            Text("offset: \(offset)")
            Slider(value: $offset, in: 0...1.0)
            Rectangle()
                .frame(width: 300, height: 300)
                .colorEffect(
                    ShaderLibrary.hueRotationShader(.float(offset))
                )
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    HueRotationSample()
}
