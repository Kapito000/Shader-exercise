Shader "CookbookShaders/BlendLandscape"
{
	Properties
	{
		_MainTint("Diffuse tint", Color)=(1,1,1,1)
		_ColorA("Terrain collor A", Color)=(1,1,1,1)
		_ColorB("Terrain collor B", Color)=(1,1,1,1)
		_RTex("Red channal teture", 2D)=""{}
		_GTex("Green channal teture", 2D)=""{}
		_BTex("Blue channal teture", 2D)=""{}
		_ATex("Alpha channal teture", 2D)=""{}
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
		#pragma surface surf Standard Lambert
		#pragma target 3.5

		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;
		sampler2D _RTex;
		sampler2D _GTex;
		sampler2D _BTex;
		sampler2D _ATex;
		sampler2D _BlendTex;

		struct Input
		{
			float2 uv_RTex;
			float2 uv_GTex;
			float2 uv_BTex;
			float2 uv_ATex;
			float2 uv_BlendTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float4 rTex = tex2D(_RTex, IN.uv_RTex);
			float4 gTex = tex2D(_GTex, IN.uv_GTex);
			float4 bTex = tex2D(_BTex, IN.uv_BTex);
			float4 aTex = tex2D(_ATex, IN.uv_ATex);
			float4 blend = tex2D(_BlendTex, IN.uv_BlendTex);

			float4 color = lerp(rTex, gTex, blend);
			color = lerp(color, bTex, blend);
			color = lerp(color, aTex, blend);
			color.a = 1;

			float4 terrain = lerp(_ColorA, _ColorB, blend.r);
			color *= terrain;
			color = saturate(color);

			o.Albedo = color.rgb * _MainTint.rgb;
			o.Alpha = color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}