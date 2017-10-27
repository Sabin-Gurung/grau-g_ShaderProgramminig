#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float n = 8;

void main()
{
	vec3 colorRed = vec3 (1.0, 0.0, 0.0);
	vec3 colorGrey = vec3 (0.8, 0.8, 0.8);
	vec3 newColor;

	float a = fract (vtexCoord.s * n);
	float b = fract (vtexCoord.t * n);

	float margin = 0.1;
	if (a < margin || b < margin)
	{
		newColor = colorRed;
	}
	else
	{
		discard;
	}

	fragColor = vec4 (newColor, 1.0);
}

