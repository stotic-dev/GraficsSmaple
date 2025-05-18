//
//  GradientTextRendere.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/17.
//

import SwiftUI

struct GradientTextRendere: TextRenderer {
    
    var xOffset: Double
    
    var animatableData: Double {
        get { xOffset }
        set { xOffset = newValue }
    }
    
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                var copy = context
                copy.addFilter(
                    .colorShader(ShaderLibrary.fillGradientColor(
                        .float2(run.typographicBounds.rect.size),
                        .float(xOffset)
                    ))
                )
                copy.addFilter(.blur(radius: 10))
                
                copy.draw(run)
                copy.draw(run)
                copy.draw(run)
                copy.draw(run)
                copy.draw(run)
                context.draw(run)
            }
        }
    }
}
