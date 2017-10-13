#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
/*
uniform float time;
uniform int FPS = 30;
*/
void main()
{
	/*
	int totalFrame = 48;
	int curFrame = int(time * FPS) % 48 + 8; 
	
	float tileWidth = 1.0/8;
	float tileHeight = 1.0/6;
		
	int x = curFrame % 8;
	int y = curFrame / 8;
	
    vtexCoord.x = texCoord.x/8.0 + (x * tileWidth);
    vtexCoord.y = texCoord.y/6.0 - (y * tileHeight);
    */
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
