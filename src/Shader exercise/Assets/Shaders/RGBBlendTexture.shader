Shader "CookbookShaders/RGBBlendTexture"
{
	Properties
	{
		_RTex("Red channal teture", 2D)=""{}
		_GTex("Green channal teture", 2D)=""{}
		_BTex("Blue channal teture", 2D)=""{}
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
		#pragma surface surf Standard Lambert  fullforwardshadows
		#pragma target 3.5

		sampler2D _RTex;
		sampler2D _GTex;
		sampler2D _BTex;
		sampler2D _BlendTex;

		struct Input
		{
			fixed2 uv_RTex;
			fixed2 uv_GTex;
			fixed2 uv_BTex;
			fixed2 uv_BlendTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 blend = tex2D(_BlendTex, IN.uv_BlendTex);
			fixed4 rTex = tex2D(_RTex, IN.uv_RTex);
			fixed4 gTex = tex2D(_GTex, IN.uv_GTex);
			fixed4 bTex = tex2D(_BTex, IN.uv_BTex);

			fixed4 result = blend.r * rTex + blend.g * gTex + blend.b * bTex;

			o.Albedo = result.rgb;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}