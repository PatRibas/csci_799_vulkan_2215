#version 450

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inNormal;
layout(location = 2) in vec2 inTexCoord;

layout(location = 0) out vec3 N;
layout(location = 1) out vec3 L;
layout(location = 2) out vec3 V;
layout(location = 3) out vec2 fragTexCoord;

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

void main() {
    mat4 modelView = uniforms.view * uniforms.model;
    mat4 normalMatrix = transpose(inverse(modelView));

    vec3 vcam = (modelView * vec4(inPosition, 1.0)).xyz;
    vec3 lcam = (uniforms.view * vec4(uniforms.lightPos, 1.0)).xyz;
    vec3 ncam = (normalMatrix * vec4(inNormal, 1.0)).xyz;
    ncam = faceforward(ncam, vcam, ncam);

    N = normalize(ncam);
    L = normalize(lcam - vcam);
    V = -normalize(vcam);

    fragTexCoord = inTexCoord;
    gl_Position = uniforms.proj * uniforms.view * uniforms.model * vec4(inPosition, 1.0);
}
