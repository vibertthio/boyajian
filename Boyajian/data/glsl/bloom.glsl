
uniform sampler2D texture;
float kernel = .005;
float scale = 1.;
float thresh = 1.;
uniform float vol ;
uniform float time;

varying vec4 vertColor;
varying vec4 vertTexCoord;


void main()
{
    vec4 sum = vec4(0);
    vec2 uv=vertTexCoord.st;
    float t=time;
    float v=vol;
    // mess of for loops due to gpu compiler/hardware limitations
    int j=-2;
    for( int i=-2; i<=2; i++) sum+=texture2D(texture,uv+vec2(i,j)*kernel);
    j=-1;
    for( int i=-2; i<=2; i++) sum+=texture2D(texture,uv+vec2(i,j)*kernel);
    j=0;
    for( int i=-2; i<=2; i++) sum+=texture2D(texture,uv+vec2(i,j)*kernel);
    j=1;
    for( int i=-2; i<=2; i++) sum+=texture2D(texture,uv+vec2(i,j)*kernel);
    j=2;
    for( int i=-2; i<=2; i++) sum+=texture2D(texture,uv+vec2(i,j)*kernel);
    sum/=20.0;

    vec4 s=texture2D(texture, uv);
    gl_FragColor=s;

    // use the blurred colour if it's bright enough
    if (length(sum)>thresh)
    {
        gl_FragColor +=sum*scale;
    }
}