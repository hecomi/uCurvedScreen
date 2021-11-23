Shader "CurvedScreen/Unlit"
{

Properties
{
    _MainTex("Texture", 2D) = "white" {}
    _Color("Color", Color) = (0.5, 0.5, 0.5, 0.5)
    _Radius("Radius", Float) = 10.0
    _Thickness("Thickness", Float) = 0.1
}

SubShader
{

Tags { "RenderType" = "Opaque" }
LOD 100

CGINCLUDE

#include "./CurvedScreen.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};

struct v2f
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
    UNITY_FOG_COORDS(1)
};

sampler2D _MainTex;
float4 _MainTex_ST;
float4 _Color;
float _Radius;
float _Thickness;

v2f vert(appdata v)
{
    v2f o;
    CurvedScreenVertex(v.vertex.xyz, _Radius, CurvedScreenGetWidth(), _Thickness);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    UNITY_TRANSFER_FOG(o,o.vertex);
    return o;
}

fixed4 frag(v2f i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    UNITY_APPLY_FOG(i.fogCoord, col);
    return col;
}

ENDCG

Pass
{
    CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag
    #pragma multi_compile_fog
    ENDCG
}

}

FallBack "Unlit/Texture"

}