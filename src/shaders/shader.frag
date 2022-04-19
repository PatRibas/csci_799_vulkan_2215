#version 450

layout(location = 0) in vec3 N;
layout(location = 1) in vec3 L;
layout(location = 2) in vec3 V;
layout(location = 3) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;

    vec3 ambient;
    vec3 lightPos;
    vec3 lightColor;

    vec3 baseColor;
    vec3 specColor;

    float ka;
    float kd;
    float ks;
    float ke;
} uniforms;

layout(binding = 1) uniform sampler2D texSampler;


void main() {
    vec3 R = normalize(reflect (-L, N));
    vec3 ambient = uniforms.ka * uniforms.ambient * uniforms.baseColor;
    vec3 diffuse = uniforms.kd * uniforms.lightColor * uniforms.baseColor * max(dot(L, N), 0.0);
    vec3 spec = uniforms.ks * uniforms.specColor * uniforms.lightColor * pow(max(dot(R, V), 0.0), uniforms.ke);
    outColor = vec4(ambient + diffuse + spec, 1.0) / 2.0;// + texture(texSampler, fragTexCoord) / 2.0;
}
