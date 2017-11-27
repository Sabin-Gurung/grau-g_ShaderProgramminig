#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];

out vec3 gNormal;
out vec3 gPos;

uniform mat4 modelViewProjectionMatrix; 
uniform float d = 0.1;

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

	vec3 b1 = a1 + d * midNormal;
	vec3 b2 = a2 + d * midNormal;
	vec3 b3 = a3 + d * midNormal;

	// geerate prism
	// bottom
	createVertex (a1, midNormal);
	createVertex (a2, midNormal);
	createVertex (a3, midNormal);
	EndPrimitive();
	// face1
	vec3 n = calculateNormal (a1, a2, b1);
	createVertex (a1, n);
	createVertex (a2, n);
	createVertex (b1, n);
	createVertex (b2, n);
	EndPrimitive();
	// face2
	n = calculateNormal (a2, a3, b2);
	createVertex (a2, n);
	createVertex (a3, n);
	createVertex (b2, n);
	createVertex (b3, n);
	EndPrimitive();
	// face3
	n = calculateNormal (a3, a1, b3);
	createVertex (a3, n);
	createVertex (a1, n);
	createVertex (b3, n);
	createVertex (b1, n);
	EndPrimitive();
}
