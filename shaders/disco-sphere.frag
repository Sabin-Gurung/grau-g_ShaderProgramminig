#version 330 core

uniform sampler2D sampler;

in vec2 vtexCoord;

in vec4 f_vertexEyeSpace;

out vec4 fragColor;

void main()
{

    vec3 tangentx = dFdx (f_vertexEyeSpace.xyz);
    vec3 tangenty = dFdy (f_vertexEyeSpace.xyz);

    vec3 newNormal = normalize (cross (tangentx, tangenty));

		vec2 newTexCoord = newNormal.xy;
    fragColor = newNormal.z * texture(sampler, newTexCoord);

}
