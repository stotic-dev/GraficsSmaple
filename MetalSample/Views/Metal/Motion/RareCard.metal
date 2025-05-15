//
//  RareCard.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/15.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 rareCard
(
 float2 position,
 half4 color,
 float2 size,
 float2 acceleration
 ) {
    // ピクセルの位置を、中心を0, 0として-1から1に正規化する
    float2 r = (position / size) * 2.0 - 1.0;
    r.y = -r.y;
    
    half3 base = half3(r.y * acceleration.y * -1 + r.x * acceleration.x * -1);
    half3 finalColor = base + color.rgb;
    return half4(finalColor, 1.0h) * color;
}
