#version 330 core

uniform sampler2D colorMap0;
uniform sampler2D normalMap1;
uniform sampler2D heightMap2;

uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;

uniform float matShininess;

uniform float heightScale = 1.0;

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

vec2 parallaxMapping (vec2 p_texCoord, vec3 p_V)
{
	float height = texture (heightMap2, p_texCoord).r;
	vec2 p = p_V.xy / p_V.z * (height * heightScale);
	return p_texCoord - p;
}

void main()
{
	vec2 newTexCoord = parallaxMapping (vtexCoord, f_V);

	vec4 tempColor = texture (colorMap0, newTexCoord);

	vec3 mappedNormal = (texture (normalMap1, newTexCoord)).xyz;
	mappedNormal = (mappedNormal * 2.0) - vec3(1.0);
	mappedNormal = normalize (mappedNormal);


	fragColor = tempColor;
	//fragColor = calculateLight (mappedNormal, f_V, f_L, tempColor);
}
