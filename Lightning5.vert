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
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 viewMatrixInverse;
uniform mat3 normalMatrix;

uniform bool world = true;

uniform vec4 lightPosition;

void main()
{
	vec4 cameraPositionEyeSpace = vec4(0,0,0,1);
	vec4 cameraPositionWorldSpace = viewMatrixInverse * vec4(0,0,0,1);
	
	vec4 vertexEyeSpace = (modelViewMatrix*vec4(vertex,1.0));
	vec4 vertexWorldSpace = (modelMatrix * vec4(vertex, 1.0));
	
	vec4 lightPositionWorldSpace = (viewMatrixInverse * lightPosition);
	
	if(world)
	{
		f_V = (cameraPositionWorldSpace - vertexWorldSpace).xyz;
		f_L = (lightPositionWorldSpace - vertexWorldSpace).xyz;
		f_normal = (transpose(mat3(viewMatrix))) * normalMatrix * normal;
	}
	else
	{
		f_V = (cameraPositionEyeSpace - vertexEyeSpace).xyz;
		f_L = (lightPosition - vertexEyeSpace).xyz;
		f_normal = (normalMatrix * normal);
	}
	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
