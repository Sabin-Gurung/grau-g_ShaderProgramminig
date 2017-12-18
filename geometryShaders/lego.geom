#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec3 gNormal;
out float gTopFacing;
out vec2 st;
out vec3 gColor;

in vec3 vColor[];

uniform mat4 modelViewProjectionMatrix; 
uniform mat3 normalMatrix; 
uniform float step_ = 0.2;

void createVertex (vec3 p_normal, vec3 p_coord)
{
	gNormal = normalMatrix * p_normal;
	gl_Position = modelViewProjectionMatrix * vec4 (p_coord, 1.0);
	EmitVertex();
}

void createCube (vec3 p_center)
{
	float offs = step_ / 2.0;
	//bottom square
	vec3 b1 = p_center + vec3 (offs, -offs, offs);
	vec3 b2 = p_center + vec3 (offs, -offs, -offs);
	vec3 b3 = p_center + vec3 (-offs, -offs, -offs);
	vec3 b4 = p_center + vec3 (-offs, -offs, offs);
	//top square
	vec3 t1 = p_center + vec3 (offs, +offs, offs);
	vec3 t2 = p_center + vec3 (offs, +offs, -offs);
	vec3 t3 = p_center + vec3 (-offs, +offs, -offs);
	vec3 t4 = p_center + vec3 (-offs, +offs, offs);

	//start drawing 
	// bottom
	gTopFacing = 0;
	vec3 n = vec3  (0, -1, 0);
	createVertex (n, b1);
	createVertex (n, b2);
	createVertex (n, b4);
	createVertex (n, b3);
	EndPrimitive();
	
	// top
	gTopFacing = 1;
	n = vec3  (0, 1, 0);
	st = vec2 (1,0);
	createVertex (n, t1);
	st = vec2 (1,1);
	createVertex (n, t2);
	st = vec2 (0,0);
	createVertex (n, t4);
	st = vec2 (0,1);
	createVertex (n, t3);
	EndPrimitive();

	gTopFacing = 0;
	// front
	n = vec3  (0, 0, 1);
	createVertex (n, b1);
	createVertex (n, t1);
	createVertex (n, b4);
	createVertex (n, t4);
	EndPrimitive();

	// back
	n = vec3  (0, 0, -1);
	createVertex (n, b2);
	createVertex (n, t2);
	createVertex (n, b3);
	createVertex (n, t3);
	EndPrimitive();

	// left
	n = vec3  (1, 0, 0);
	createVertex (n, t1);
	createVertex (n, t2);
	createVertex (n, b1);
	createVertex (n, b2);
	EndPrimitive();

	// right
	n = vec3  (-1, 0, 0);
	createVertex (n, t4);
	createVertex (n, t3);
	createVertex (n, b4);
	createVertex (n, b3);
	EndPrimitive();
}

void main( void )
{
	gColor = vec3 (0, 0, 0);
	vec3 bc = vec3 (0.0, 0.0, 0.0);
	for (int i = 0; i < 3; ++i)
	{
		bc += gl_in[i].gl_Position.xyz;
		gColor = vColor[i];
	}
	gColor = normalize (gColor);

	bc /= 3;
	bc /= step_;
	bc.x = int (bc.x);
	bc.y = int (bc.y);
	bc.z = int (bc.z);

	bc *= step_;

	createCube (bc);
}
