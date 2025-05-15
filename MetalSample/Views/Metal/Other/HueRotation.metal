//
//  HueRotation.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/15.
//

#include <metal_stdlib>
using namespace metal;

// HSV -> RGB変換関数
half3 hsv2rgbForhueRotationShader(float3 c) {
    float3 p = abs(fract(c.xxx + float3(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0);
    return half3(c.z * mix(1.0, clamp(p - 1.0, 0.0, 1.0), c.y));
}

// メイン Color Shader
[[ stitchable ]]
half4 hueRotationColor(
    float2 position,
    half4 color,
    float offset
) {
    float hue = fmod(offset * 5 + position.x * 0.001 + position.y * 0.008, 1.0); // 0〜1
    float saturation = 1.0;
    float value = 1.0;

    return half4(hsv2rgbForhueRotationShader(float3(hue, saturation, value)), color.a);
}
