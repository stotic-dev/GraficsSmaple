//
//  RareCard.metal
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/15.
//

#include <metal_stdlib>
using namespace metal;

half4 getRareBaseColor
(
 float2 position,
 float2 size,
 half4 original,
 float time
 ) {
    // -- ①正規化 --
    // 処理するピクセルの位置を0〜1へ変換
    float2 uv = position / size;
    // 左上 → 右下方向の座標を0〜1として取得
    // Metalでは左上端が(0,0)、右下端が(1,1)になるため、x+yを行うと0〜2の値を取ることになる
    // そのため、0.5を掛けて0〜1に変換している
    float diagCoord = (uv.x + uv.y) * 0.5;
    
    // -- ②時間の周期を調整 --
    // どのぐらいの速度、タイミングで、光の線が左上から右下へ移動するかどうかの値を算出する
    
    // 光の線が左上から右下へ移動する速度の定義(値を大きくすると速くなる)
    constexpr float speed = 0.6;
    // 経過時間 * speedの値を0〜1へループする値へ変換する
    // speedが高ければ高いほど、ループする速度が増す
    float t = fmod(time * speed, 1.0);
    // t(ループ速度)にSpring風に弾むようにglintPosが0→1へ変化するようにする
    // tをそのままglintPosに代入したら、一定の速度で移動するアニメーションになる
    float glintPos = 1.0 - exp(-4.0 * t) * cos(5.0 * t);
    
    // -- ③光の筋の強度を計算（中心で明るく、周辺で暗く） --
    
    // 光の線の横幅(0〜1の間で指定)
    constexpr float width = 0.3;
    // glintPos(光の線を表示する左上 → 右下方向の座標の値)からwidth(0.3)分離れた箇所を、光の強度を多めに設定する(0〜1)
    // smoothstep(edge0, edge1, x) は x が edge0〜edge1 の範囲に入ると 0→1 へ滑らかに増加する関数
    float intensity = smoothstep(glintPos - width, glintPos, diagCoord) *
    (1.0 - smoothstep(glintPos, glintPos + width, diagCoord));
    
    // -- ④元の色に光の線を加える --
    
    // intensityは処理中のピクセル位置が光の線を表示する部分に含まれている場合は、0 < x <= 1の値をとる
    // 逆に、光の線を表示する位置に含まれていないピクセルは、元の色を返す
    // 0.6は光の強度で、1.0に近づけると光の線はより白く表示される
    half3 glinted = original.rgb + half3(1.0) * half(intensity) * 0.6;
    return half4(glinted, original.a);
}

half4 getMotionLightEffectColor
(
 float2 position,
 float2 size,
 half4 baseColor,
 float2 acceleration
 ) {
    // -- ①正規化 --
    
    // Metalではデフォルトでは、positionには左上端が(0,0)、右下端は(width,height)となっている
    // ピクセルの位置を、中心を0, 0として-1から1に正規化する
    float2 uv = (position / size) * 2.0 - 1.0;
    uv.y = -uv.y;
    
    // -- ②傾きによる光の強度を計算 --
    
    // x軸の傾きによる光の調整
    // 画面が左側へ向かうように傾けると、画面の右側が明るくなるようにする
    half3 horizontalLight = uv.x * acceleration.x * -1;
    // y軸の傾きによる光の調整
    // 画面が上側へ向かうように傾けると、画面の下側が明るくなるようにする
    half3 verticalLight = uv.y * acceleration.y * -1;
    
    // -- ③最終的な色を返す --
    // 最終的な色のrgbを計算
    // x軸とy軸の光の効果を元に色に足した色を返す
    // 元の色よりも明るさ(つまりrgb値が低い)場合は、元の色を返す
    half3 finalRgb = max(horizontalLight + verticalLight + baseColor.rgb, baseColor.rgb);
    return half4(finalRgb, baseColor.a);
}

[[ stitchable ]] half4 rareCard
(
 float2 position,
 half4 color,
 float2 size,
 float2 acceleration,
 float time
  ) {
    // 左上から左下へ、一定の間隔で光の線が移動するEffectを加える
    half4 baseColor = getRareBaseColor(position, size, color, time);
    // デバイスの傾きによって、傾きの上側が光が反射しているようなEffectを加える
    return getMotionLightEffectColor(position, size, baseColor, acceleration);
}

[[ stitchable ]] half4 motionRareCard
(
 float2 position,
 half4 color,
 float2 size,
 float2 acceleration
 ) {
    return getMotionLightEffectColor(position, size, color, acceleration);
}
