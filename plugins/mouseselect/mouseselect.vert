#version 330 core

layout (location = 0) in vec3 coord;

uniform mat4 modelViewProjectionMatrix;

void main()
{
	gl_Position = modelViewProjectionMatrix * vec4 (coord, 1.0);
}


