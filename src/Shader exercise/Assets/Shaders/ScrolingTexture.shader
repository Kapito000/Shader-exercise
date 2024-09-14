Shader "CookbookShaders/ScrolingTexture"
{
	Properties
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTint ("Main tint", Color) = (1,1,1,1)
		_ScrollXSpeed ("X scroll speed", Range(0,10)) = 2
		_ScrollYSpeed ("Y scroll speed", Range(0,10)) = 2
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

		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;
		fixed4 _MainTint;
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed2 uv = IN.uv_MainTex;
			fixed2 scroll = fixed2(_ScrollXSpeed * _Time.x, _ScrollYSpeed * _Time.x);
			uv += scroll;

			half4 c = tex2D(_MainTex, uv);
			o.Albedo = c.rgb * _MainTint;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}