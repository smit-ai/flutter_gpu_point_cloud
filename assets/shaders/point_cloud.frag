#version 460 core

in vec4 fragColor;

out vec4 outColor;

void main() {
    vec2 coord = gl_PointCoord - vec2(0.5);
    float dist = length(coord);
    
    if (dist > 0.5) {
        discard;
    }
    
    float alpha = 1.0 - smoothstep(0.4, 0.5, dist);
    outColor = vec4(fragColor.rgb, fragColor.a * alpha);
}