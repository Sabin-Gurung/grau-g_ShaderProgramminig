#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec4 f_vertexEyeSpace;

void main()
{
    vec3 tangentx = dFdx (f_vertexEyeSpace.xyz);
    vec3 tangenty = dFdy (f_vertexEyeSpace.xyz);

    vec3 newNormal = normalize (cross (tangentx, tangenty));

    fragColor = frontColor * newNormal.z;
}
