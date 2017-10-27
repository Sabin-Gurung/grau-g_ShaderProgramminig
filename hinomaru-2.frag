#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform bool classic;

vec2 C = vec2 (0.5, 0.5);
vec3 colorRed   = vec3 (1.0, 0.0, 0.0);
vec3 colorWhite = vec3 (1.0, 1.0, 1.0);
float radi = 0.2;

float pi = 3.14159;
int n = 16;

void main()
{
	float d = distance (vtexCoord, C);

	vec3 newColor;

	if (d <= radi)
	{
		newColor = colorRed;
	}
	else if (classic)
	{
		newColor = colorWhite;
	}
	else
	{
		vec2 u = vtexCoord - C;
		float angle = atan (u.t, u.s);
		
		float space = pi / n;
		if (mod (angle / space + 0.5, 2) < 1) newColor = colorRed;
		else newColor = colorWhite;

	}

	fragColor = vec4 (newColor, 1.0);
}
