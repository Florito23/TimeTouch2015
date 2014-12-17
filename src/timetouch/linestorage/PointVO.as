package timetouch.linestorage
{
	import flash.geom.Point;
	
	public class PointVO extends Point
	{
		
		public static const TYPE_CAP:int = 0;
		public static const TYPE_INBETWEEN:int = 1;
		
		public var type:int;
		public var startTime:Number;
		public var endTime:Number;
		
		public function PointVO(x:Number, y:Number, startTime:Number, endTime:Number, type:int)
		{
			super(x, y);
			this.startTime = startTime;
			this.endTime = endTime;
			this.type = type;
		}
		
	}
}