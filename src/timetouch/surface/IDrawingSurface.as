package timetouch.surface
{
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.SegmentVO;
	
	public interface IDrawingSurface
	{
		
		//TODO: to be removed
		function drawSegments(segments:Vector.<SegmentVO>):void
		function drawLines(lines:Vector.<LineVO>):void
		
			//public function		
		/*protected function dispatchDrawingSurfaceEvent(drawingSurfaceEventType:String, touchID:int, localX:Number, localY:Number):void
		{
			var e:DrawingSurfaceEvent = new DrawingSurfaceEvent(drawingSurfaceEventType);
			e.touchID = touchID;
			e.x = localX;
			e.y = localY;
			dispatchEvent(e);
		}*/
	}
}