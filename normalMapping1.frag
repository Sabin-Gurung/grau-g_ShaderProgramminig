#version 330 core

uniform sampler2D colorMap0;
uniform sampler2D normalMap1;

uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;

uniform float matShininess;

in vec2 vtexCoord;

in vec3 f_L;
in vec3 f_V;
in vec3 f_N;

out vec4 fragColor;

vec4 calculateLight (vec3 N, vec3 V, vec3 L, vec4 matColor)
{
	N = normalize (N);	
	V = normalize (V);	
	L = normalize (L);	

	float NdotL = max (0.0, dot (N, L));
	
	vec4 diffuse = matColor * lightDiffuse * NdotL;

	vec3 R = normalize (reflect (-V, N));

	float RdotV = max (0.0, dot (R, V));
	
	float spec = 0.0;

	if (NdotL > 0.0) spec = pow (RdotV, matShininess);
	
	vec4 specular = lightSpecular * matColor * spec;

	return specular + diffuse;
}

void main()
{
	vec4 tempColor = texture (colorMap0, vtexCoord);

	vec3 mappedNormal = (texture (normalMap1, vtexCoord)).xyz;
	mappedNormal = (mappedNormal * 2.0) - vec3(1.0);
	mappedNormal = normalize (mappedNormal);


	fragColor = calculateLight (mappedNormal, f_V, f_L, tempColor);
}
