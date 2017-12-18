#version 330 core

out vec4 fragColor;

in vec3 gPos;
in vec3 gNormal;
in vec2 gTexCoord;

in float isSide;

uniform float d = 0.1;

uniform sampler2D grass_top0;
uniform sampler2D grass_side1;

void main()
{
	vec4 resColor;	
	if (isSide == 1.0)
	{
		resColor = texture2D (grass_side1, gTexCoord);
		if (resColor.a < 0.1) discard;
	}
	else
	{
		resColor = texture2D (grass_top0, gTexCoord);
	}
	fragColor = resColor;
}
