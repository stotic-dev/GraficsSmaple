//
//  ColorfulTextRenderer.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/17.
//

import SwiftUI

struct ColorfulTextRenderer: TextRenderer {
    
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (index, runSlice) in run.enumerated() {
                    var copy = ctx
                    copy.opacity = CGFloat(index) * 0.1 + 0.1
                    copy.addFilter(.shadow(radius: 1, x: 2, y: 2))
                    copy.draw(runSlice)
                }
            }
        }
        
//        for line in layout {
//            for run in line {
//                for (index, grif) in run.enumerated() {
//                    var copy = ctx
//                    if run[Attribute.self] != nil {
//                        let degree = Angle.degrees(360 / Double(index + 1))
//                        copy.addFilter(.hueRotation(degree))
//                        copy.draw(grif)
//                    }
//                    else {
//                        ctx.draw(grif)
//                    }
//                }
//            }
//        }
    }
    
    struct Attribute: TextAttribute {}
}

#Preview {
    Text("Hello World!!!")
        .font(.largeTitle)
//        .foregroundStyle(.red)
        .customAttribute(ColorfulTextRenderer.Attribute())
        .textRenderer(ColorfulTextRenderer())
}
