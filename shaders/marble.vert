#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

out vec3 f_normal;
out vec3 f_vertexEyePosition;
out vec4 f_vertexObjectPosition;

void main()
{
	f_normal = normalize (normalMatrix * normal);
	f_vertexObjectPosition = vec4 (vertex, 1.0);
	f_vertexEyePosition = (modelViewMatrix * vec4 (vertex, 1.0)).xyz;

	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
