#version 330 core

out vec4 fragColor;

in vec3 f_vertexWorldSpace;

uniform vec3 origin = vec3 (0.0, 0.0, 0.0);
uniform vec3 axis;
uniform float slice = 0.1;

vec3 red = vec3 (1.0, 0.0, 0.0);
vec3 green = vec3 (0.0, 1.0, 0.0);

void main()
{
	float d = distance (origin, f_vertexWorldSpace);
	
	float a = fract (d / (2 * slice));

	if (a < 0.5)
	{
		fragColor = vec4(green, 1.0);
	}
	else
	{
		fragColor = vec4(red, 1.0);
	}
}
