//
//  MotionEffectPortfolioListView.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/29.
//

import SwiftUI

struct MotionEffectPortfolioListView: View {
    var body: some View {
        VStack {
            NavigationLink {
                MotionEffectCardView()
            } label: {
                Text("レアカードエフェクト")
            }
            NavigationLink {
                MotionHologramEffectView()
            } label: {
                Text("ホログラムエフェクト")
            }

        }
    }
}

#Preview {
    MotionEffectPortfolioListView()
}
