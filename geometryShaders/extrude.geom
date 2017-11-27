#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vNormal[];

out vec4 gfrontColor;
out vec3 gNormal;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float d = 0.5;

void main( void )
{
	// calculate midNormal
	vec3 midNormal = vec3 (0.0, 0.0, 0.0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		midNormal += vNormal[i];
	}
	midNormal = normalize (midNormal);

	// generate vetices of prism
	vec4 newVertices[6];
	newVertices[0] = gl_in[0].gl_Position;
	newVertices[1] = gl_in[1].gl_Position;
	newVertices[2] = gl_in[2].gl_Position;
	newVertices[3] = newVertices[0] + vec4 (d * midNormal, 0.0);
	newVertices[4] = newVertices[1] + vec4 (d * midNormal, 0.0);
	newVertices[5] = newVertices[2] + vec4 (d * midNormal, 0.0);

	// assuiming all the verices has the same color
	// in the end color is gonna depend on normal
	gfrontColor = vec4 (1.0, 0.0, 0.0, 1.0);

	// generate faces as well as triangle geometry

	// bottom
	gl_Position = modelViewProjectionMatrix * newVertices[0];
	gNormal = normalize (normalMatrix * (-midNormal));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[1];
	gNormal = normalize (normalMatrix * (-midNormal));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[2];
	gNormal = normalize (normalMatrix * (-midNormal));
	EmitVertex();
	EndPrimitive();

	// top
	gl_Position = modelViewProjectionMatrix * newVertices[3];
	gNormal = normalize (normalMatrix * (midNormal));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[4];
	gNormal = normalize (normalMatrix * (midNormal));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[5];
	gNormal = normalize (normalMatrix * (midNormal));
	EmitVertex();
	EndPrimitive();

	// face1
	gl_Position = modelViewProjectionMatrix * newVertices[0];
	gNormal = normalMatrix * (cross (midNormal, newVertices[0].xyz - newVertices[1].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[3];
	gNormal = normalMatrix * (cross (midNormal, newVertices[0].xyz - newVertices[1].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[1];
	gNormal = normalMatrix * (cross (midNormal, newVertices[0].xyz - newVertices[1].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[4];
	gNormal = normalMatrix * (cross (midNormal, newVertices[0].xyz - newVertices[1].xyz));
	EmitVertex();
	EndPrimitive();

	// face2
	gl_Position = modelViewProjectionMatrix * newVertices[1];
	gNormal = normalMatrix * (cross (midNormal, newVertices[1].xyz - newVertices[2].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[4];
	gNormal = normalMatrix * (cross (midNormal, newVertices[1].xyz - newVertices[2].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[2];
	gNormal = normalMatrix * (cross (midNormal, newVertices[1].xyz - newVertices[2].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[5];
	gNormal = normalMatrix * (cross (midNormal, newVertices[1].xyz - newVertices[2].xyz));
	EmitVertex();
	EndPrimitive();

	// face3
	gl_Position = modelViewProjectionMatrix * newVertices[2];
	gNormal = normalMatrix * (cross (midNormal, newVertices[2].xyz - newVertices[0].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[5];
	gNormal = normalMatrix * (cross (midNormal, newVertices[2].xyz - newVertices[0].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[0];
	gNormal = normalMatrix * (cross (midNormal, newVertices[2].xyz - newVertices[0].xyz));
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * newVertices[3];
	gNormal = normalMatrix * (cross (midNormal, newVertices[2].xyz - newVertices[0].xyz));
	EmitVertex();
	EndPrimitive();
}
