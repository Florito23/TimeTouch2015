package timetouch.surface
{
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.SegmentCollectionVO;
	import timetouch.linestorage.SegmentVO;
	
	public interface IDrawingSurface
	{
		
		//TODO: to be removed
		//function drawSegments(segments:Vector.<SegmentVO>):void
		//function drawLines(lines:Vector.<LineVO>):void
		
		function drawSegmentCollections(lines:Vector.<SegmentCollectionVO>):void
	}
}