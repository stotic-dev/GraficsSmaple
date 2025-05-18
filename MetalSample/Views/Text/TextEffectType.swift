//
//  TextEffectType.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/14.
//

import SwiftUI

enum TextEffectType {
    
    static let allCases: [EffectContentModel] = [
        gradient
    ]
    
    static let gradient = EffectContentModel(
        title: String(localized: "gradient_title", defaultValue: "グラデーション"),
        destination: { GradientTextEffectView() }
    )
}
