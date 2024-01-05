#pragma header

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
uniform float force = 2.0;
uniform float glitchOffset; // Range: -1 to 1
#define bitmap bitmap
#define texture flixel_texture2D
#define gl_FragColor gl_FragColor
#define main main

vec4 posterize(vec4 color, float numColors)
{
    return floor(color * numColors - 0.5) / numColors;
}

vec2 quantize(vec2 v, float steps)
{
    return floor(v * steps) / steps;
}

void main()
{   
    vec2 uv = fragCoord.xy / iResolution.xy;
    float amount = pow(force, 2.0);
    vec2 pixel = 1.0 / iResolution.xy;    
    vec4 color = texture(bitmap, uv);

    float t = mod(mod(iTime, amount * 100.0 * (amount - 0.5)) * 109.0, 1.0);
    vec4 postColor = posterize(color, 16.0);
    vec4 a = posterize(texture(bitmap, quantize(uv, 64.0 * t) + pixel * (postColor.rb - vec2(.5)) * 100.0), 5.0).rgba;
    vec4 b = posterize(texture(bitmap, quantize(uv, 32.0 - t) + pixel * (postColor.rg - vec2(.5)) * 1000.0), 4.0).gbra;
    vec4 c = posterize(texture(bitmap, quantize(uv, 16.0 + t) + pixel * (postColor.rg - vec2(.5)) * 20.0), 16.0).bgra;

    // Apply glitch offset
    vec2 glitchUV = uv + glitchOffset * 0.1;

    gl_FragColor = mix(
        texture(bitmap, glitchUV + amount * (quantize((a.rgb * t - b.rgb + c.rgb - (t + t / 2.0) / 10.0).rg, 16.0) - vec2(.5)) * pixel * 100.0),
        (a + b + c) / 3.0,
        (0.5 - (dot(color, postColor) - 1.5)) * amount);
}
