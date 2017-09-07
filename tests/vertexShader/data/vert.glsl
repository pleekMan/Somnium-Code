uniform float mouseX;

void main(void){
  
  vec4 thisPos = gl_Vertex;

  float thisX = thisPos.x;
  float thisY = thisPos.y;

  thisPos.z += mouseX * sin(thisX*thisX + thisY*thisY);
  gl_Position     = gl_ModelViewProjectionMatrix * thisPos;
}
