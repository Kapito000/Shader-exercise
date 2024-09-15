Shader "CookbookShaders/AnimationSpriteList"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Speed("Speed", Float) = 12		_CellAmount("Cell amount", Integer) = 1
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

		fixed _CellAmount;
		fixed _Speed;
		sampler2D _MainTex;

		struct Input
		{
			fixed2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed2 uv = IN.uv_MainTex;
			fixed cellUVPersentage = 1 / _CellAmount;

			fixed frame = fmod(_Time.y * _Speed, _CellAmount);
			frame = floor(frame);

			fixed xValue = (uv.x + frame) * cellUVPersentage;
			uv = fixed2(xValue, uv.y);

			o.Albedo = tex2D(_MainTex, uv);
			o.Alpha = tex2D(_MainTex, uv);
		}
		ENDCG
	}
	FallBack "Diffuse"
}