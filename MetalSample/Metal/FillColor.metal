//
//  FillColor.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/11.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 fillColor
(
 float2 position, // 現在のピクセルの位置(デフォルトで与えられる)
 half4 color,
 half4 fillColor
 ) {
    return fillColor;
}

[[ stitchable ]] half4 fillRed
(
 float2 position, // 現在のピクセルの位置(デフォルトで与えられる)
 half4 color
 ) {
    return half4(1.0, 0.0, 0.0, 1.0);
}

[[ stitchable ]] half4 fillGradientColor
(
 float2 position, // 現在のピクセルの位置(デフォルトで与えられる)
 half4 color,
 float2 size,
 float animatableData
 ) {
    float2 fragCoord = float2(position.x, position.y);
    float2 r = float2(fragCoord.x / size.x,
                      fragCoord.y / size.y);
    float red = animatableData * r.x + 0.05;
//    return half4(red, 0.5h, 0.5h, 1.0h) * color.a;
    return half4(red, 0.5h, 0.5h, 1.0h) * color;
}
