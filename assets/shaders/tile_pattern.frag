// Flutter Fragment Shader v1
// Input: pattern texture (SVG yang sudah di-render ke image)
// Output: tiled pattern dengan opacity

#include <flutter/runtime_effect.glsl>

uniform sampler2D pattern;
uniform vec2 uSize;        // Ukuran screen/widget
uniform vec2 tileSize;     // Ukuran 1 tile (misal 160x120)
uniform float opacity;     // 0.0 - 1.0

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy;
    
    // Hitung posisi dalam tile (repeat/mirror)
    vec2 tileUV = mod(uv, tileSize) / tileSize;
    
    // Sample texture
    vec4 color = texture(pattern, tileUV);
    
    // Apply opacity
    fragColor = vec4(color.rgb, color.a * opacity);
}
