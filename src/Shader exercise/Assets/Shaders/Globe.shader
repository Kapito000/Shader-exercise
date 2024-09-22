Shader "CookbookShaders/Globe"
{
	Properties
	{
		_MainTex("Map", 2D)="white"{}
		_NormMap("Normal map", 2D)=""{}
		_NormalIntensity("Normal map intensity", Range(0,5))=1
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

		fixed _NormalIntensity;
		sampler2D _MainTex;
		sampler2D _NormMap;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_NormMap;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 albedo = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = albedo;
			fixed3 normMap = UnpackNormal(tex2D(_NormMap, IN.uv_NormMap));
			normMap = float3(normMap.x * _NormalIntensity,
											normMap.y * _NormalIntensity,
											normMap.z);
			o.Normal = normMap.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}