#version 330 core

uniform sampler2D colorMap;

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float a = 0.5;
uniform float time;

float max3 (vec3 p_v)
{
	return max (max (p_v.r, p_v.g), p_v.b);
}

void main()
{
	vec4 colorC = texture (colorMap, vtexCoord);
	float m = max3 (colorC.xyz);
	vec2 u = vec2 (m, m);

	float angle = 2 * 22.0 / 7.0 * time;

	mat2 rotationMatric = mat2 (vec2 (cos (angle), sin (angle)),
	                            vec2 (-sin(angle), cos (angle)));
	
	u = rotationMatric * u;

	u = a / 100.0 * u;

	vec2 newTexCoord = vtexCoord + u;

	fragColor = texture (colorMap, newTexCoord);

}
