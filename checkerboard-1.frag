#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

void main()
{

  float tileSize = 1.0 / 8.0;
  int i = int (vtexCoord.x / tileSize);
  int j = int (vtexCoord.y / tileSize);

  vec3 newColor;
  
  if ((i+j) % 2 == 0) newColor = vec3 (1.0, 1.0, 1.0);
  else newColor = vec3 (0.0, 0.0, 0.0);

    
  fragColor = vec4 (newColor, 1.0);
}
