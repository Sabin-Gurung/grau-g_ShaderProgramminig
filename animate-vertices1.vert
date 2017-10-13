#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;
out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float amplitude = 0.1;
uniform float freq = 1;
uniform float time;

const float PI = 3.141592;

void main()
{
	vec3 N = normalize(normalMatrix * normal);
	float d = sin(2*PI*freq*time)*amplitude;
	vec4 nouVertex = vec4(vertex + normalize(normal)*d, 1.0);
	
	vtexCoord = texCoord;
	frontColor = vec4(N.z);
	gl_Position = modelViewProjectionMatrix * nouVertex;
}
