#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform float light   = 0.5;
uniform float epsilon = 0.1;

in vec3 f_normal;
in vec3 f_V;

vec3 colorYellow = vec3 (0.7, 0.6, 0.0);

void main()
{
	vec3 N = normalize (f_normal);
	vec3 V = normalize (f_V);

	float NdotV = abs (dot (N, V));

	vec4 newColor;
	if (NdotV < epsilon) newColor = vec4(colorYellow, 1.0);
	else newColor = frontColor * f_normal.z;
	
	fragColor = newColor;
}
