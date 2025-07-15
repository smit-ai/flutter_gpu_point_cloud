// Copyright 2024 Flutter Point Cloud Viewer Contributors
#include <flutter/runtime_effect.glsl>

in vec2 FlutterFragCoord;
in vec4 fragColor;

out vec4 fragOutput;

void main() {
    // Simple point rendering with fade at edges
    vec2 coord = FlutterFragCoord - vec2(0.5);
    float dist = length(coord);
    
    if (dist > 0.5) {
        discard;
    }
    
    float alpha = 1.0 - smoothstep(0.4, 0.5, dist);
    fragOutput = vec4(fragColor.rgb, fragColor.a * alpha);
}