package timetouch.linestorage
{
	public class SegmentCollectionVO
	{
		
		public function get segments():Vector.<SegmentVO> {
			return _segments;
		}
		protected var _segments:Vector.<SegmentVO>;
		
		public function SegmentCollectionVO()
		{
			_segments = new Vector.<SegmentVO>();
		}
		
		internal function addSegment(segment:SegmentVO):void
		{
			_segments.push(segment);
		}
		
		public function get length():int
		{
			return _segments.length;
		}
	}
}