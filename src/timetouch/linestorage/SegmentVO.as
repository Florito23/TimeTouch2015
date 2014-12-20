package timetouch.linestorage
{
	import flash.geom.Point;

	public class SegmentVO
	{
		
		public var parentLineID:uint;
		
		public var A:PointVO;
		public var B:PointVO;
		
		public var AToB:Point;
		public var magnitude:Number;
		
		public function get isPoint():Boolean {
			return normalizedAToB==null;
		}
		
		public var normalizedAToB:Point = null;
		public var tangentialRight:Point = null;
		public var tangentialLeft:Point = null;
		
		public var lowestTime:Number;
		public var highestTime:Number;
		
		//public var drawableFlag:Boolean = false;
		
		public function SegmentVO(parentLineID:uint, A:PointVO,B:PointVO)
		{
			this.parentLineID = parentLineID;
			this.A = A;
			this.B = B;
			AToB = new Point(B.x-A.x, B.y-A.y);
			magnitude = AToB.length;
			if (magnitude>0) {
				normalizedAToB = new Point(AToB.x/magnitude, AToB.y/magnitude);
				tangentialRight = new Point(-normalizedAToB.y, normalizedAToB.x);
				tangentialLeft = new Point(normalizedAToB.y, -normalizedAToB.x);
			}
			
			var a0:Number = A.startTime;
			var a1:Number = A.endTime;
			var b0:Number = B.startTime;
			var b1:Number = B.endTime;
			
			lowestTime = Math.min(a0,a1,b0,b1);
			highestTime = Math.max(a0, a1, b0, b1);
			
		}
	}
}