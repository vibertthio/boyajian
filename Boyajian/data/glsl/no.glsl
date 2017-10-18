uniform sampler2D texture;
uniform float time;
uniform float vol;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void ) {
    vec2 uv = vertTexCoord.st;
    float v=vol;
    float t=time;

    vec4 color =texture2D(texture, uv);
    gl_FragColor = color;
}
