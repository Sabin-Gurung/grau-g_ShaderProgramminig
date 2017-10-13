#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

out vec3 f_normal;
out vec3 f_V;
out vec3 f_L;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

void main()
{
	f_normal = normalize(normalMatrix * normal);
	
	vec3 P = (modelViewMatrix*vec4(vertex,1.0)).xyz;
	f_V = -P;
	f_L = lightPosition.xyz - P;
	
	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
