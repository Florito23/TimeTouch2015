package timetouch.linestorage
{
	import flash.geom.Point;
	
	public class PointVO extends Point
	{
		
		public var timeMilliseconds:Number;
		
		public function PointVO(x:Number, y:Number, timeMilliseconds:Number)
		{
			super(x, y);
			this.timeMilliseconds = timeMilliseconds;
		}
	}
}