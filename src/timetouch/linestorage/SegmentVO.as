package timetouch.linestorage
{
	import flash.geom.Point;

	public class SegmentVO
	{
		
		public var A:PointVO;
		public var B:PointVO;
		
		public var AToB:Point;
		public var magnitude:Number;
		public var normalizedAToB:Point = null;
		
		public function SegmentVO(A:PointVO,B:PointVO)
		{
			this.A = A;
			this.B = B;
			AToB = new Point(B.x-A.x, B.y-A.y);
			magnitude = AToB.length;
			if (magnitude>0) {
				normalizedAToB = new Point(AToB.x/magnitude, AToB.y/magnitude);
			}
		}
	}
}