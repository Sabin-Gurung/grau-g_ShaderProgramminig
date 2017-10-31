#version 330 core

uniform sampler2D colorMap;

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float time;
uniform int FPS = 4;
uniform int tiles = 1;

void main()
{
	int totalFrame = 48;
	//int totalFrame = 8;
	int curFrame = int(time * FPS) % totalFrame;
	
	float tileWidth = 1.0/8;
	float tileHeight = 1.0/6;
		
	int x = curFrame % 8;
	int y = curFrame / 8;
	
	vec2 newCoord;
	newCoord.x = vtexCoord.x/8.0 + (x * tileWidth);
	newCoord.y = vtexCoord.y/6.0 - (y * tileHeight);
	//newCoord.y = vtexCoord.y/6.0;

	newCoord.s = newCoord.s * tiles;
	newCoord.t = newCoord.t * tiles;
	
	float tileMinS = x * tileWidth;
	float tileMaxS = (x + 1) * tileWidth;
	float tileMinT =(- y) * tileHeight;
	float tileMaxT = (- y + 1) * tileHeight;

	newCoord.s = mix (tileMinS, tileMaxS, abs (fract (newCoord.s / tileWidth)));
	newCoord.t = mix (tileMinT, tileMaxT, abs (fract (newCoord.t / tileHeight)));

	vec4 ourColor = texture(colorMap, newCoord);
	fragColor = ourColor * ourColor.a;
	
}
