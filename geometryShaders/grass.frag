#version 330 core

out vec4 fragColor;

in vec3 gPos;
in vec3 gNormal;

uniform float d = 0.1;

uniform sampler2D grass_top0;
uniform sampler2D grass_side1;

void main()
{
	vec4 resColor;	
	if (normalize(gNormal).z == 0)
	{
		vec2 texCoord = vec2 (4 * (gPos.x - gPos.y), 1.0 - gPos.z/d);
		resColor = texture2D (grass_side1, texCoord);
		if (resColor.a < 0.1) discard;
	}
	else
	{
		vec2 texCoord = 4 * gPos.xy;
		resColor = texture2D (grass_top0, texCoord);
	}
	fragColor = resColor;
}
