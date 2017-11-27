#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;
out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

uniform float n = 4;

void main()
{
	vec3 N = normalize(normalMatrix * normal);
	vec4 lightPositionObjectSpace = modelViewMatrixInverse * lightPosition; 
	float d = distance(lightPositionObjectSpace.xyz, vertex);
	float w = clamp(1.0/(pow(d,n)), 0, 1);
	vec4 nouVertex = (1.0 - w) * vec4(vertex, 1.0) + w * lightPositionObjectSpace;
	nouVertex.w = 1.0;
	
	vtexCoord = texCoord;
	frontColor = vec4(N.z);
	gl_Position = modelViewProjectionMatrix * nouVertex;
}
