package timetouch.surface
{
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.SegmentVO;
	
	public interface IDrawingSurface
	{
		
		function drawSegments(segments:Vector.<SegmentVO>):void
		//function drawLines(lines:Vector.<LineVO>):void
		
	}
}