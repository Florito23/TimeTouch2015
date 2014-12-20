package timetouch.linestorage
{
	import flash.geom.Point;
	
	public class PointVO extends Point
	{
	
		public var startTime:Number;
		public var endTime:Number;
		
		public function PointVO(x:Number, y:Number, startTime:Number, endTime:Number)
		{
			super(x, y);
			this.startTime = startTime;
			this.endTime = endTime;
		}
		
	}
}