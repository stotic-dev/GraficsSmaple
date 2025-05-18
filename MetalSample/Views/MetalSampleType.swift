//
//  MetalSampleType.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/14.
//

import SwiftUI

enum MetalSampleType: CaseIterable, Identifiable {
    
    case motion
    case text
    case other
        
    var id: String { self.title }
    
    var title: String {
        switch self {
        case .motion:
            return String(localized: "motion_sample_title", defaultValue: "Motion")
        case .text:
            return String(localized: "text_sample_title", defaultValue: "Text")
        case .other:
            return String(localized: "other_sample_title", defaultValue: "Other")
        }
    }
    
    var contents: [EffectContentModel] {
        switch self {
        case .motion:
            MotionEffectType.allCases
        case .text:
            TextEffectType.allCases
        case .other:
            OtherEffectType.allCases
        }
    }
}

struct EffectContentModel: Identifiable {
    var id: String { title }
    let title: String
    let destination: any View
    
    init(title: String, @ViewBuilder destination: () -> some View) {
        self.title = title
        self.destination = destination()
    }
}
