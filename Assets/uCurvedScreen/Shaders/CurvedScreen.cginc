#ifndef CURVED_SCREEN_CGINC
#define CURVED_SCREEN_CGINC

#include "UnityCG.cginc"

inline void CurvedScreenVertex(inout float3 v, half radius, half width, half thickness)
{
    half angle = width * v.x / radius;
    v.z *= thickness;
    radius += v.z;
    v.z -= radius * (1 - cos(angle));
    v.x = radius * sin(angle) / width;
}

inline void CurvedScreenNormal(float4 x, inout float3 n, half radius, half width)
{
    half angle = width * x / radius;
    float c = cos(angle);
    float s = sin(angle);
    n = float3(c * n.x - s * n.z, n.y, s * n.x + c * n.z);
}

#endif