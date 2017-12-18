#version 330 core

out vec4 fragColor;

in vec3 gNormal;
in vec4 gfrontColor;
in vec3 gColor;

in float gTopFacing;
in vec2 st;


uniform sampler2D legoMap;


void main()
{
	if (gTopFacing == 0.0)
	{
		fragColor = vec4 (gColor, 1.0);
	}
	else
	{
		fragColor = texture (legoMap, st) * vec4 (gColor, 1.0);
	}
	//fragColor = gfrontColor;
}
