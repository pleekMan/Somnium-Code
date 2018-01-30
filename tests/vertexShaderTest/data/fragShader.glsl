#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
uniform vec2 resolution;

uniform vec3 nodePos;


void main() {
  vec2 fragNorm = gl_FragCoord.xy / resolution.xy;

  vec4 color = vertColor;
  color = color * vec4(fragNorm.r, fragNorm.g, color.b, 1.);

  gl_FragColor = color;
}
