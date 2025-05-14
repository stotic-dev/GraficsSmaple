//
//  OtherEffectType.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/14.
//

import SwiftUI

enum OtherEffectType {
    
    static let allCases: [EffectContentModel] = [
        hueRotation
    ]
    
    static let hueRotation = EffectContentModel(
        title: String(localized: "hue_rotation_title", defaultValue: "色相回転"),
        destination: { HueRotationSample() }
    )
}
