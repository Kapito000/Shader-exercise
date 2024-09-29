using UnityEngine;

public sealed class InverseRampDiffuseCalculation : MonoBehaviour
{
	public float[] XValues;

	[ContextMenu(nameof(Calculate))]
	public void Calculate()
	{
		for (int i = 0; i < XValues.Length; i++)
		{
			var x = XValues[i];
			var result = Function(x);
			Debug.Log($"x == {x}; result == {result}");
		}
	}

	float Function(float x)
	{
		return .5f + (.5f - x);
	}
}