#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;


vec3 colorRed    = vec3 (1.0, 0.0, 0.0);
vec3 colorYellow = vec3 (1.0, 1.0, 0.0);

void main()
{
	float stride = 9;

	vec3 newColor;
	
	// para que fa mirrorred repeat
	float a = floor (abs (vtexCoord.s) * stride); 
	a = a - floor (a / stride);

	if (mod (a, 2) == 0)
	{
		newColor = colorYellow;
	}
	else
	{
		newColor = colorRed;
	}
	
  fragColor = vec4 (newColor, 1.0);
}
