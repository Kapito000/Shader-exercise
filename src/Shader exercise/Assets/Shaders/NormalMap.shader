Shader "CookbookShaders/NormalMap"
{
	Properties
	{
		_Color("Color", Color)=(1,1,1,1)
		_MainTex("Texture", 2D)=""{}
		_NormalMap("Normal map", 2D)="bump"{}
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

		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _NormalMap;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_NormalMap;
		};


		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			fixed3 normalMap = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			o.Normal = normalMap;
		}
		ENDCG
	}
	FallBack "Diffuse"
}