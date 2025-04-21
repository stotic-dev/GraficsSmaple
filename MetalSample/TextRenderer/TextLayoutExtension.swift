//
//  TextLayoutExtension.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/18.
//

import SwiftUI

extension Text.Layout {
    
    var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
        flatMap(\.self)
    }
    
    var flattenedRunSlices: some RandomAccessCollection<Text.Layout.RunSlice> {
        flattenedRuns.flatMap(\.self)
    }
}
