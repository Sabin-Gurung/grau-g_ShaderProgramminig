#version 330 core

out vec4 fragColor;

in vec3 f_normal;
in vec3 f_vertexEyePosition;
in vec4 f_vertexObjectPosition;

in vec2 vtexCoord;

uniform sampler2D noise0;

vec4 colorRed = vec4 (1.0, 0.0, 0.0, 1.0);
vec4 colorWhite = vec4 (1.0, 1.0, 1.0, 1.0);

vec4 shading(vec3 N, vec3 Pos, vec4 diffuse) {
	vec3 lightPos = vec3(0.0,0.0,2.0);
	vec3 L = normalize( lightPos - Pos );
	vec3 V = normalize(-Pos);
	vec3 R = reflect(-L,N);
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Ispec = pow( RdotV, 20.0 );
	return diffuse * NdotL + Ispec;
}
  
void main()
{
	vec4 paramS = 0.3 * vec4 (0, 1, -1, 0);	
	vec4 paramT = 0.3 * vec4 (-2, -1, 1, 0);	

	vec2 newTexCoord;
	newTexCoord.s = dot (paramS, f_vertexObjectPosition);
	newTexCoord.t = dot (paramT, f_vertexObjectPosition);

	vec4 c = texture (noise0, newTexCoord);
	float v = c.r;
	
	vec4 diffuseColor;
	if (v < 0.5)
	{
		diffuseColor = mix (colorWhite, colorRed, v * 2);
	}
	else
	{
		diffuseColor = mix (colorRed, colorWhite, (v - 0.5) * 2);
	}
	
	fragColor = shading (f_normal, f_vertexEyePosition, diffuseColor);
}
