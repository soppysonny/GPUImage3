#include <metal_stdlib>
#include "OperationShaderTypes.h"
using namespace metal;

typedef struct
{
    float amount;
    float threshold;
    float softness;
} HighlightBoostUniform;

fragment half4 highlightBoostFragment(SingleInputVertexIO fragmentInput [[stage_in]],
                                      texture2d<half> inputTexture [[texture(0)]],
                                      constant HighlightBoostUniform& uniform [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = inputTexture.sample(quadSampler, fragmentInput.textureCoordinate);
    half luminance = dot(color.rgb, luminanceWeighting);

    half threshold = half(clamp(uniform.threshold, 0.0, 1.0));
    half softness = max(half(uniform.softness), 0.001h);
    half mask = smoothstep(threshold - softness, threshold + softness, luminance);

    half exposureScale = half(pow(2.0, uniform.amount));
    half3 adjusted = clamp(color.rgb * exposureScale, half3(0.0h), half3(1.0h));
    half3 result = mix(color.rgb, adjusted, mask);

    return half4(result, color.a);
}
