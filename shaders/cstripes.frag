#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;


vec3 colorRed    = vec3 (1.0, 0.0, 0.0);
vec3 colorYellow = vec3 (1.0, 1.0, 0.0);

uniform int nstripes = 8;
uniform vec2 origin = vec2 (0.0, 0.0);

void main()
{	
	float d = distance (vtexCoord, origin);

	float a = floor (d * nstripes);

	vec3 newColor;

	if (mod (a,2) == 0)
	{
		newColor = colorRed;
	}
	else
	{
		newColor = colorYellow;
	}
	
	fragColor = vec4 (newColor, 1.0);	
}
