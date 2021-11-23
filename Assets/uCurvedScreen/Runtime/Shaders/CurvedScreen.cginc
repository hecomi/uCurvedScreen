#ifndef CURVED_SCREEN_CGINC
#define CURVED_SCREEN_CGINC

#include "UnityCG.cginc"

inline float CurvedScreenGetWidth()
{
    return length(float3(unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x));
}

inline void CurvedScreenVertex(inout float3 v, float radius, float width, float thickness)
{
    float angle = width * v.x / radius;
    v.z *= thickness;
    radius += v.z;
    v.z -= radius * (1.0 - cos(angle));
    v.x = radius * sin(angle) / width;
}

inline float3 CurvedScreenRotateY(float3 n, float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return float3(c * n.x - s * n.z, n.y, s * n.x + c * n.z);
}

inline void CurvedScreenNormal(float x, inout float3 n, float radius, float width)
{
    float angle = -width * x / radius;
    n = CurvedScreenRotateY(n, angle);
}

#endif