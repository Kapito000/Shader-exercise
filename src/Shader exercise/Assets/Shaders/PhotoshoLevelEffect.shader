Shader "CookbookShaders/PhotoshoLevelEffect"
{
	Properties
	{
		_MainTex("Base (RGB)",2D)="white"{}
		_inBlack("Input black", Range(0, 255)) = 0
		_inGamma("Input gamma", Range(0, 2)) = 1.61
		_inWhite("Input white", Range(0, 255)) = 255

		_outWhite("Output white", Range(0,255))=255
		_outBlack("Output black", Range(0,255))=0
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
		fixed _inBlack;
		fixed _inGamma;
		fixed _inWhite;
		fixed _outWhite;
		fixed _outBlack;

		struct Input
		{
			fixed2 uv_MainTex;
		};

		float GetPixelLevel(float pixel);
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed3 c = tex2D(_MainTex, IN.uv_MainTex);
			c.r = GetPixelLevel(c.r);
			o.Albedo = c;
		}

		float GetPixelLevel(float pixel)
		{
			pixel *= 255.0;
			pixel = max(0, pixel - _inBlack);
			pixel = saturate(pow(pixel / (_inWhite - _inBlack), _inGamma));
			pixel = (pixel * (_outWhite - _outBlack) + _outBlack) / 255.0;
			return pixel;
		}
		ENDCG
	}
	FallBack "Diffuse"
}