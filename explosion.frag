#version 330 core

uniform sampler2D colorMap;

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float time;
uniform int FPS = 30;

void main()
{
	int totalFrame = 48;
	int curFrame = int(time * FPS) % 48 + 8; 
	
	float tileWidth = 1.0/8;
	float tileHeight = 1.0/6;
		
	int x = curFrame % 8;
	int y = curFrame / 8;
	
	vec2 newCoord;
    newCoord.x = vtexCoord.x/8.0 + (x * tileWidth);
    newCoord.y = vtexCoord.y/6.0 - (y * tileHeight);
    
	
    vec4 ourColor = texture(colorMap, newCoord);
	fragColor = ourColor * ourColor.a;
	
}
