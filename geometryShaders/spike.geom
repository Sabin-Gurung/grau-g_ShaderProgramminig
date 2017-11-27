#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];
in vec3 vColor[];

out vec3 gNormal;
out vec3 gColor;

uniform mat4 modelViewProjectionMatrix; 
uniform mat3 normalMatrix;
uniform float disp = 0.05;

void createVertex (vec3 p_vertex, vec3 p_normal, vec3 p_color)
{
	gColor      = p_color;
	gNormal     = normalize (normalMatrix * p_normal);
	gl_Position = modelViewProjectionMatrix * vec4 (p_vertex, 1.0);
	EmitVertex();
}

vec3 calculateNormal (vec3 a, vec3  b, vec3 c)
{
	return normalize (cross (b - a, c - a));
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

	// calculate baricenter
	vec3 ba = vec3 (0.0, 0.0, 0.0);
	for (int i = 0; i < 3; ++i)
	{
		ba += gl_in[i].gl_Position.xyz;
	}
	ba = ba / 3.0;

	// generate geometry
	vec3 a1 = gl_in[0].gl_Position.xyz;
	vec3 a2 = gl_in[1].gl_Position.xyz;
	vec3 a3 = gl_in[2].gl_Position.xyz;
	
	vec3 c1 = vColor[0] * normalize (normalMatrix * vNormal[0]).z;
	vec3 c2 = vColor[1] * normalize (normalMatrix * vNormal[1]).z;
	vec3 c3 = vColor[2] * normalize (normalMatrix * vNormal[2]).z;
	vec3 cb = vec3 (1.0, 1.0, 1.0);

	ba = ba + disp * midNormal;

	// face1
	vec3 n = calculateNormal (a2, ba, a1);
	createVertex (ba, n, cb);
	createVertex (a1, n, c1);
	createVertex (a2, n, c2);
	EndPrimitive();
	// face2
	n = calculateNormal (a3, ba, a2);
	createVertex (ba, n, cb);
	createVertex (a2, n, c2);
	createVertex (a3, n, c3);
	EndPrimitive();
	// face3
	n = calculateNormal (a1, ba, a3);
	createVertex (ba, n, cb);
	createVertex (a3, n, c3);
	createVertex (a1, n, c1);
	EndPrimitive();
}
