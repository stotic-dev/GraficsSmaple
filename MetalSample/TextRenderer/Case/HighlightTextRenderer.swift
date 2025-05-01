//
//  HighlightTextRenderer.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/17.
//

import SwiftUI

struct HighlightTextRenderer: TextRenderer {
    
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[Attribute.self] == nil {
                    var copy = context
                    copy.opacity = 0.7
                    copy.addFilter(.blur(radius: 2))
                    copy.draw(run)
                }
                else {
                    context.opacity = 1.0
                    context.transform = .init(scaleX: 1.1, y: 1.1)
                    context.draw(run)
                }
            }
        }
    }
    
    struct Attribute: TextAttribute {}
}
