//
//  SuperRareCard.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/15.
//

#include <metal_stdlib>
using namespace metal;

// HSV -> RGB変換関数
half3 hsv2rgbForSuperRareCard(float3 c) {
    float3 p = abs(fract(c.xxx + float3(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0);
    return half3(c.z * mix(1.0, clamp(p - 1.0, 0.0, 1.0), c.y));
}

// メイン Color Shader
[[ stitchable ]]
half4 superRareCard(
    float2 position,
    half4 color,
    float2 size,
    float time,
    float2 acceleration
) {
    // 画面中心を(0,0)とした正規化座標 -1〜1
    float2 norm = (position / size) * 2.0 - 1.0;
    norm.y = -norm.y; // y軸上下反転（必要なら）
    
    float2 accelerationAdjustValue = norm * acceleration;

    // グラデーションの基本色相を「時間 + 位置」に応じて変化
    float hue = fmod(time * 1.0 + (norm.x * 0.2 + 0.5) + (norm.y * 0.3 + 0.5), 1.0); // 0〜1
    float saturation = sin(time);
    float value = 1.0;

    half3 baseColor = half3((accelerationAdjustValue.x + accelerationAdjustValue.y) * 0.6 + 0.1) + color.rgb;
    half3 rgb = hsv2rgbForSuperRareCard(float3(hue, saturation, value));
    half3 finalColor = mix(baseColor, rgb, 0.2);
    return half4(finalColor, color.a);
}
