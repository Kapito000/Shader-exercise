using System;
using UnityEngine;

public class ProceduralTexture : MonoBehaviour
{
	[SerializeField] int _widthHeight = 512;
	[SerializeField] Texture2D _texture;

	[SerializeField] Material _material;
	[SerializeField] Vector2 _centerPos;
	[SerializeField] string materialTextureName = "_MainTex";

	void Awake()
	{
		_material = GetComponent<MeshRenderer>().material;
	}

	void Start()
	{
		if (_material == null)
		{
			Debug.LogError("Has no material.");
			return;
		}

		_centerPos = new Vector2(.5f, .5f);
		_texture = GenerateGradient();
		_material.SetTexture(materialTextureName, _texture);
	}

	Texture2D GenerateGradient()
	{
		var texture = new Texture2D(_widthHeight, _widthHeight);
		var center = _centerPos * _widthHeight;
		for (int x = 0; x < _widthHeight; x++)
		for (int y = 0; y < _widthHeight; y++)
		{
			var currentPos = new Vector2(x, y);
			float pixelDistance =
				Vector2.Distance(currentPos, center) / (_widthHeight * .5f);
			pixelDistance = Mathf.Abs(1 - Mathf.Clamp01(pixelDistance));

			var pixelColor =
				new Color(pixelDistance, pixelDistance, pixelDistance, 1);
			texture.SetPixel(x, y, pixelColor);
		}
		texture.Apply();
		return texture;
	}
}