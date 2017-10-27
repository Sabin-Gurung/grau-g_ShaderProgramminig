#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

float scale = 8.0;
void main()
{

  // float tileSize = 1.0 / 8.0;
	float a = floor (vtexCoord.s * scale);
	float b = floor (vtexCoord.t * scale);

	vec3 colorBlack = vec3 (0.0, 0.0, 0.0);
	vec3 colorGrey = vec3 (0.8, 0.8, 0.8);
	vec3 newColor;

	if (mod (a + b, 2.0) > 0.5)
	{
		newColor = colorBlack;
	}
	else
	{
		newColor = colorGrey;		
	}
    

  fragColor = vec4 (newColor, 1.0);
}
