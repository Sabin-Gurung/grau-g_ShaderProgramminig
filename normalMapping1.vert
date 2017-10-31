#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;


uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

out vec2 vtexCoord;

out vec3 f_L;
out vec3 f_V;
out vec3 f_N;


void main()
{
	f_N = normalize (normalMatrix * normal);

	vec4 vertexEyePos = modelViewMatrix * vec4 (vertex, 1.0);

	f_V = normalize (- vertexEyePos.xyz);
	f_L = normalize (lightPosition.xyz - vertexEyePos.xyz);

	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
