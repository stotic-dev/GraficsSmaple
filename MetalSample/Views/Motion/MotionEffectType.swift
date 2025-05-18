//
//  MotionEffectType.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/14.
//

import SwiftUI

enum MotionEffectType {
    
    static let allCases: [EffectContentModel] = [
        rareCard,
        superRareCard
    ]
    
    static let rareCard = EffectContentModel(
        title: String(localized: "rare_card_title", defaultValue: "レアカード"),
        destination: { RareCardView() }
    )
    static let superRareCard = EffectContentModel(
        title: String(localized: "super_rare_card_title", defaultValue: "スーパーレアカード"),
        destination: { SuperRareCardView() }
    )
}
