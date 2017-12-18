#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];

out vec3 gNormal;
out vec3 gPos;
out vec2 gTexCoord;
out float isSide;

uniform mat4 modelViewProjectionMatrix; 
uniform float d = 0.1;
uniform float time;

vec3 windDir = vec3 (0.05, 0.0, 0.0);

void createVertex (vec3 p_vertex, vec3 p_normal)
{
	gNormal     = p_normal;
	gPos        = p_vertex;
	gl_Position = modelViewProjectionMatrix * vec4 (p_vertex, 1.0);
	EmitVertex();
}

vec3 calculateNormal (vec3 a, vec3  b, vec3 c)
{
	return cross (b - a, c - a);
}


void main( void )
{
	// calculate midNormal
	vec3 midNormal = vec3 (0.0, 0.0, 0.0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		midNormal += vNormal[i];
	}
	midNormal = normalize (midNormal / 3.0);

	// generate vetices of prism
	vec3 a1 = gl_in[0].gl_Position.xyz;
	vec3 a2 = gl_in[1].gl_Position.xyz;
	vec3 a3 = gl_in[2].gl_Position.xyz;

	vec3 b1 = a1 + d * midNormal + sin (time) * windDir;
	vec3 b2 = a2 + d * midNormal + sin (time) * windDir;
	vec3 b3 = a3 + d * midNormal + sin (time) * windDir;

	// geerate prism
	// bottom
	isSide = 0.0;
	gTexCoord = vec2 (0.0, 0.0);
	createVertex (a1, midNormal);
	gTexCoord = vec2 (0.0, 0.5);
	createVertex (a2, midNormal);
	gTexCoord = vec2 (0.5, 0.0);
	createVertex (a3, midNormal);
	EndPrimitive();
	// face1
	isSide = 1.0;
	vec3 n = calculateNormal (a1, a2, b1);
	gTexCoord = vec2 (0.0, 0.0);
	createVertex (a1, n);
	gTexCoord = vec2 (1.0, 0.0);
	createVertex (a2, n);
	gTexCoord = vec2 (0.0, 1.0);
	createVertex (b1, n);
	gTexCoord = vec2 (1.0, 1.0);
	createVertex (b2, n);
	EndPrimitive();
	// face2
	n = calculateNormal (a2, a3, b2);
	gTexCoord = vec2 (0.0, 0.0);
	createVertex (a2, n);
	gTexCoord = vec2 (1.0, 0.0);
	createVertex (a3, n);
	gTexCoord = vec2 (0.0, 1.0);
	createVertex (b2, n);
	gTexCoord = vec2 (1.0, 1.0);
	createVertex (b3, n);
	EndPrimitive();
	// face3
	n = calculateNormal (a3, a1, b3);
	gTexCoord = vec2 (0.0, 0.0);
	createVertex (a3, n);
	gTexCoord = vec2 (1.0, 0.0);
	createVertex (a1, n);
	gTexCoord = vec2 (0.0, 1.0);
	createVertex (b3, n);
	gTexCoord = vec2 (1.0, 1.0);
	createVertex (b1, n);
	EndPrimitive();
}
