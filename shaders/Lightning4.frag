#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

in vec3 f_L;
in vec3 f_V;
in vec3 f_normal;

vec4 calculateLight(vec3 N, vec3 V, vec3 L)
{
	N = normalize(N);
	V = normalize(V);
	L = normalize(L);
	//vec3 H = normalize(V + L);
	vec3 R = normalize(reflect(-L, N));	
	//vec3 R = normalize(2.0*dot(N,L)*N-L);	

	vec4 amb = matAmbient * lightAmbient;
	float NdotL = max(0.0, dot(N,L));
	//float NdotH = max(0.0, dot(N,H));
	float RdotV = max(0.0, dot(R,V));

	vec4 diffuse = matDiffuse*lightDiffuse*NdotL;
	
	float spec = 0;
	if(NdotL>0) spec = pow(RdotV, matShininess);
	vec4 specular = matSpecular * lightSpecular
                        * spec;
	
	return (amb + diffuse + specular);
}


void main()
{
	fragColor = calculateLight(f_normal, f_V, f_L);
}
