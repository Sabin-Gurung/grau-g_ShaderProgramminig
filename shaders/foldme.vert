#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

void main()
{
  float angle = -time * texCoord.s;
		
  mat3 rotationMatrix = mat3(  vec3(cos(angle), 0.0, -sin(angle))
			      ,vec3(0.0, 1.0, 0.0)
			      ,vec3(sin(angle), 0.0, cos(angle)));
  vec3 nouVertex = rotationMatrix * vertex;

  frontColor = vec4(0.0, 0.0, 1.0,1.0);
  vtexCoord = texCoord;
  gl_Position = modelViewProjectionMatrix * vec4(nouVertex, 1.0);
}
