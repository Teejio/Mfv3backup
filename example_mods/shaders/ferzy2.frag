#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;

uniform float force;
uniform float brighten;
uniform float lighting;

#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

float normpdf(in float x, in float sigma)
{
    return 1.0 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

vec3 applyBloom(vec2 coords)
{
    const int mSize = 5;
    const int kSize = 2; 
    float kernel[mSize];
    vec3 final_colour = vec3(0.0);

    float sigma = 7.0;
    float Z = 0.0;
    for (int j = 0; j <= kSize; ++j)
    {
        kernel[kSize + j] = kernel[kSize - j] = normpdf(float(j), sigma);
    }

    for (int j = 0; j < mSize; ++j)
    {
        Z += kernel[j];
    }

    for (int i = -kSize; i <= kSize; ++i)
    {
        for (int j = -kSize; j <= kSize; ++j)
        {
            final_colour += kernel[kSize + j] * kernel[kSize + i] * texture(iChannel0, (coords + vec2(float(i), float(j))) / iResolution.xy).rgb;
        }
    }

    return 1.2 * (final_colour / (Z * Z));
}

void mainImage()
{
    vec2 center = vec2(0.5, 0.5);
    float radius = distance(center, uv);
    vec2 blurAmount = radius * (force / 20.0 + 0.005) * (center - uv);

    float f = force / 100.0;
    vec3 col;
    col.r = texture2D(bitmap, vec2(uv.x + f, uv.y)).r;
    col.g = texture2D(bitmap, uv).g;
    col.b = texture2D(bitmap, vec2(uv.x - f, uv.y)).b;

    vec3 bluishTint = vec3(0.1, 0.2, 0.2);
    col.rgb -= bluishTint * brighten;

    vec4 finalColor = vec4(col, texture2D(bitmap, uv).w);

    vec2 blurredUV = uv + blurAmount;
    vec4 blurredColor = flixel_texture2D(bitmap, blurredUV);

    finalColor = mix(finalColor, blurredColor, 0.25);

    vec3 bloom = applyBloom(fragCoord.xy);
    bloom *= lighting; 

    finalColor.rgb += bloom;

    gl_FragColor = finalColor;
}
