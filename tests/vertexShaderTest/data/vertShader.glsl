uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;

varying vec4 vertColor;

uniform vec3 nodePos;


void main() {
  //float yOffset = distance(vec4(nodePos,1.),position);
  vec4 newPos = position + vec4(0.,position.y * 2.,0.,0.);
  gl_Position = transform * newPos;
  vertColor = color;
}
