#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float n = 2;

void main()
{

  float tileSize = 1.0 / (8.0 * n);
  int i = abs (int (vtexCoord.x / tileSize));
  int j = abs (int (vtexCoord.y / tileSize));

  vec3 newColor;
  
  if (mod ((i+j), 2) == 0) newColor = vec3 (1.0, 1.0, 1.0);
  else newColor = vec3 (0.0, 0.0, 0.0);

    
  fragColor = vec4 (newColor, 1.0);
}
