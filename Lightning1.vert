#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

out vec2 vtexCoord;
out vec3 f_normal;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

vec4 calculateLight(vec3 N, vec3 V, vec3 L)
{
	N = normalize(N);
	V = normalize(V);
	L = normalize(L);
	vec3 H = normalize(V + L);
	
	vec4 amb = matAmbient * lightAmbient;
	float NdotL = max(0.0, dot(N,L));
	float NdotH = max(0.0, dot(N,H));

	vec4 diffuse = matDiffuse*lightDiffuse*NdotL;
	
	float spec = 0;
	if(NdotL>0) spec = pow(NdotH, matShininess);
	vec4 specular = matSpecular * lightSpecular
                        * spec;
	
	return (amb + diffuse + specular);
}


void main()
{
    	f_normal = normalize(normalMatrix * normal);
	
	vec3 P = (modelViewMatrix*vec4(vertex,1.0)).xyz;
	vec3 V = -P;
	vec3 L = lightPosition.xyz - P;
	frontColor = calculateLight(f_normal, V, L);
	
	vtexCoord = texCoord;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
