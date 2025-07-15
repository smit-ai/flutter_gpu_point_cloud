#version 460 core

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;

layout(binding = 0) uniform Uniforms {
    mat4 viewProjection;
    mat4 projection;
} uniforms;

out vec4 fragColor;

void main() {
    gl_Position = uniforms.viewProjection * vec4(position, 1.0);
    gl_PointSize = 3.0;
    fragColor = color;
}