#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

out vec4 f_vertexEyeSpace;

uniform float time;
uniform float velocity = 0.1;

void main()
{
	float  angle = velocity * time;

  mat3 rotationMatrix = mat3 (vec3(cos(angle), 0.0, -sin(angle))
			                       ,vec3(0.0, 1.0, 0.0)
			                       ,vec3(sin(angle), 0.0, cos(angle)));

  vec3 nouVertex = rotationMatrix * vertex;

	f_vertexEyeSpace = modelViewMatrix * vec4 (nouVertex, 1.0);


	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(nouVertex, 1.0);
}
