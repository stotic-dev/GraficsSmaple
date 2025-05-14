//
//  FillColor.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/04/11.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

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
    return half4(red, 0.5h, 0.5h, 1.0h) * color;
}

[[ stitchable ]] half4 brightnessMotionColor
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

// HSV -> RGB変換関数
half3 hsv2rgb(float3 c) {
    float3 p = abs(fract(c.xxx + float3(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0);
    return half3(c.z * mix(1.0, clamp(p - 1.0, 0.0, 1.0), c.y));
}

// メイン Color Shader
[[ stitchable ]]
half4 hologramMotionColor(
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
    half3 rgb = hsv2rgb(float3(hue, saturation, value));
    half3 finalColor = mix(baseColor, rgb, 0.2);
    return half4(finalColor, color.a);
}

// メイン Color Shader
[[ stitchable ]]
half4 hueRotationShader(
    float2 position,
    half4 color,
    float offset
) {
    float hue = fmod(offset * 5 + position.x * 0.001 + position.y * 0.008, 1.0); // 0〜1
    float saturation = 1.0;
    float value = 1.0;

    return half4(hsv2rgb(float3(hue, saturation, value)), color.a);
}
