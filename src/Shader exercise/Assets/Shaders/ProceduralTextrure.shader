Shader "CookbookShaders/ProceduralTextrure"
{
	Properties
	{
		_MainTex("Main texture",2D)=""{}
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

		sampler2D _MainTex;

		struct Input
		{
			fixed2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}