using UnityEngine;

[ExecuteInEditMode]
public class ScalarDotCalculator : MonoBehaviour
{
	public float ScalarDot;
	[Space]
	public Transform PointOne;
	public Transform PointTwo;

	void Update()
	{
		if (CanUpdate() == false) return;

		var toPointOne = PointOne.position - transform.position;
		var toPointTwo = PointTwo.position - transform.position;
		ScalarDot = Vector3.Dot(toPointOne.normalized, toPointTwo.normalized);
	}

	void OnDrawGizmos()
	{
		if (CanUpdate() == false) return;

		Gizmos.color = Color.red;
		Gizmos.DrawLine(transform.position, PointOne.position);
		Gizmos.color = Color.blue;
		Gizmos.DrawLine(transform.position, PointTwo.position);
	}

	bool CanUpdate()
	{
		if (PointOne == null || PointTwo == null)
			return false;
		return true;
	}
}