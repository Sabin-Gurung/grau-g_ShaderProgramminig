#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;
out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform float time;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

uniform bool eyespace = false;

const float PI = 3.141592;

void main()
{
  
  float amplitude;
  float r = distance(boundingBoxMin, boundingBoxMax) / 2.0;
  
  vec3 N = normalize(normalMatrix * normal);
  vec4 nouVertex;
  
  if (eyespace) 
  {
    float y = (modelViewMatrix * vec4(vertex, 1.0)).y;
    amplitude = y * (r / 10.0);
    float d = sin(time)*amplitude;
    nouVertex = vec4(vertex + normalize(N)*d, 1.0);
  }
  else
  {
    amplitude = vertex.y * (r / 10.0);
    float d = sin(time)*amplitude;
    nouVertex = vec4(vertex + normalize(normal)*d, 1.0);
  }

  vtexCoord = texCoord;
  frontColor = vec4(color, 1.0);
  gl_Position = modelViewProjectionMatrix * nouVertex;
}
