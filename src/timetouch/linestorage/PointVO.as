package timetouch.linestorage
{
	import flash.geom.Point;
	
	public class PointVO extends Point
	{
		
		public var timeMilliseconds:Number;
		
		public function PointVO(timeMilliseconds:Number=0,x:Number=0, y:Number=0)
		{
			super(x, y);
			this.timeMilliseconds = timeMilliseconds;
		}
	}
}