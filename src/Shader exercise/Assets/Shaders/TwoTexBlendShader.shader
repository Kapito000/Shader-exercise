Shader "CookbookShaders/TwoColorBlendShader"
{
	Properties
	{
		_OneColor("First clolor", Color)=(1,1,1,1)
		_TwoColor("Second clolor", Color)=(1,1,1,1)
		_BlendTex("Blend texture", 2D)=""{}
	}
	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		fixed4 _OneColor;
		fixed4 _TwoColor;
		sampler2D _BlendTex;

		struct Input
		{
			float2 uv_BlendTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 blend = tex2D(_BlendTex, IN.uv_BlendTex);
			fixed4 result = lerp(_OneColor, _TwoColor, blend);

			o.Albedo = result.rgb;
			o.Alpha = result.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}