Shader "CurvedScreen/Standard"
{

Properties 
{
    _Color("Color", Color) = (1, 1, 1, 1)
    _MainTex("Albedo (RGB)", 2D) = "white" {}
    _Glossiness("Smoothness", Range(0, 1)) = 0.5
    _Metallic("Metallic", Range(0, 1)) = 0.0
    _Radius("Radius", Float) = 10.0
    _Thickness("Thickness", Float) = 0.1
}

SubShader 
{

Tags { "RenderType" = "Opaque" }
LOD 200

CGPROGRAM

#pragma surface surf Standard addshadow fullforwardshadows vertex:vert
#pragma target 3.0
#include "./CurvedScreen.cginc"

sampler2D _MainTex;

struct Input 
{
    float2 uv_MainTex;
};

half _Glossiness;
half _Metallic;
fixed4 _Color;
float _Radius;
float _Thickness;

void vert(inout appdata_full v)
{
    float width = CurvedScreenGetWidth();
    CurvedScreenNormal(v.vertex.x, v.normal, _Radius, width);
    v.normal.x *= width; // for UnityObjectToWorldNormal()
    CurvedScreenVertex(v.vertex.xyz, _Radius, width, _Thickness);
}

void surf(Input IN, inout SurfaceOutputStandard o) 
{
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = c.rgb;
    o.Metallic = _Metallic;
    o.Smoothness = _Glossiness;
    o.Alpha = c.a;
}

ENDCG

}

FallBack "Diffuse"

}