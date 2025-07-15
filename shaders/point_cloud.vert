// Copyright 2024 Flutter Point Cloud Viewer Contributors
#version 460 core

#include <flutter/runtime_effect.glsl>

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;

layout(set = 0, binding = 0) uniform Uniforms {
    mat4 viewProjection;
    mat4 projection;
} uniforms;

out vec4 fragColor;

void main() {
    gl_Position = uniforms.viewProjection * vec4(position, 1.0);
    gl_PointSize = 3.0;
    fragColor = color;
}