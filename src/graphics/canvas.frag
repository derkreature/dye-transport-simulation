#version 330 core
in vec2 TexCoords;
out vec4 color;

// Color
uniform sampler3D cyan;
uniform sampler3D magenta;
uniform sampler3D yellow;
uniform float saturation;

// Layer blurring
uniform int width;
uniform int height;
uniform int blurQuality;

// Layer blending
uniform float visibility;
uniform int depth;

void main()
{
    int numLayers = 4;
    vec3 cmyColor = vec3(0.0, 0.0, 0.0);
    for (int layer = depth - 1; layer >= 0; layer--) {
        float layerDepth = layer * 1.0 / (numLayers - 1);
        vec3 layerCoords = vec3(TexCoords, layerDepth);
        vec3 layerColor = vec3(0.0, 0.0, 0.0);
        int neighboringSamples = 0;
        for (int i = -blurQuality; i <= blurQuality; i++) {
            for (int j = -blurQuality; j <= blurQuality; j++) {
                vec3 neighborCoords = layerCoords;
                neighborCoords.s += 1.0 * i * layer / width;
                neighborCoords.t += 1.0 * j * layer / height;
                layerColor += vec3(texture(cyan, neighborCoords).r,
                                   texture(magenta, neighborCoords).r,
                                   texture(yellow, neighborCoords).r);
                neighboringSamples++;
            }
        }
        layerColor /= float(neighboringSamples);
        cmyColor += layerColor;
        cmyColor *= visibility;
    }
    color = vec4(1 - cmyColor * saturation, 1);
}
