
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution;
uniform float multiplier;

void main(void) {
  vec2 texUV = gl_FragCoord.xy / resolution.xy;
  texUV.y = 1 - texUV.y;
  vec3 color = texture2D(texture,texUV).rgb;
  //color = color * vec3(multiplier);



  gl_FragColor = vec4(1. - color.r, 1. - color.g, 1. - color.b,multiplier);
}
