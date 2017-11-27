#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelMatrix;

out vec3 f_vertexWorldSpace;

void main()
{
	f_vertexWorldSpace = (modelMatrix * vec4 (vertex, 1.0)).xyz;	
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
