Shader "CookbookShaders/BRDFRamp"
{
    Properties
    {
        _MainTex("Main texture", 2D) = ""{}
        _RampTex("Ramp texture", 2D) = ""{}
        _AmbientColor("Ambient color", Color) = (1,1,1,1)
        _HalfLambertRation("Half lamber ratio", Float) = 0.5
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

        sampler2D _MainTex;
        sampler2D _RampTex;
        float4 _AmbientColor;
        float _HalfLambertRation;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _AmbientColor;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir,
            half3 viewDir, fixed atten)
        {
            float difLight = dot(s.Normal, lightDir);
            float rimLight = dot(s.Normal, viewDir);
            float hLambert = difLight * 0.5 + _HalfLambertRation;
            float3 ramp = tex2D(_RampTex, float2(hLambert, rimLight)).rgb;

            float4 col;
            col.rgb = s.Albedo * _LightColor0.rgb * (ramp * atten);
            col.a = s.Alpha;
            return col;
        }
        ENDCG
    }
    FallBack "Diffuse"
}