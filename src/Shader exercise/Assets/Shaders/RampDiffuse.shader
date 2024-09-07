Shader "CookbookShaders/RampDiffuse"
{
    Properties
    {
        _AmbientColor("Ambient color", Color) = (1,1,1,1)
        _HalfLambertRation("Half lamber ratio", Float) = 0.5
        _RampTex("Ramp texture", 2D) = ""
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf BasicDiffuse

        float4 _AmbientColor;
        float _HalfLambertRation;
        sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _AmbientColor.rgb;
            o.Alpha = _AmbientColor.a;
        }

        inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir,
            fixed atten)
        {
            float difLight = dot(s.Normal, lightDir);
            float hLambert = difLight * 0.5 + _HalfLambertRation;
            float3 ramp = tex2D(_RampTex, float2(hLambert, hLambert)).rgb;

            float4 col;
            col.rgb = s.Albedo * _LightColor0.rgb * (ramp * atten);
            col.a = s.Alpha;
            return col;
        }
        ENDCG
    }
    FallBack "Diffuse"
}