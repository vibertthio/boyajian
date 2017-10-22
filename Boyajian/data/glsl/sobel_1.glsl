uniform sampler2D texture;
uniform vec2 resolution;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float vol ;
uniform float time;




float getGrayScale(sampler2D sampler, vec2 coods){
    vec4 color = texture2D(texture,coods);
    float gray = (color.r + color.g + color.b)/3.0*(vol+0.5);
    return gray;
}

void main( )
{
    vec2 delta = vec2(vol*0.001,0.003);
    float m = max(resolution.x,resolution.y);
    vec2 texCoords = vertTexCoord.st ;

    float t=time;
    float v=vol;


    float c1y = getGrayScale(texture, texCoords.xy-delta/2.0);
    float c2y = getGrayScale(texture, texCoords.xy+delta/2.0);

    float c1x = getGrayScale(texture, texCoords.xy-delta.yx/2.0);
    float c2x = getGrayScale(texture, texCoords.xy+delta.yx/2.0);

    float dcdx = (c2x - c1x)/(delta.y*30.0);
    float dcdy = (c2y - c1y)/(delta.y*30.0);


		vec2 uv = vertTexCoord.st ;

    vec2 dcdi = vec2(dcdx,dcdy);

	gl_FragColor = vec4(vec3(length(dcdi)/5.0),1.0);
}
