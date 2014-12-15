package timetouch.linestorage
{
	public class LineVO
	{
		
		private var _segments:Vector.<SegmentVO>;
		
		public function LineVO()
		{
			_segments = new Vector.<SegmentVO>();
		}
		
		/**
		 * Returns false if the segment was illegal<br>
		 * Segments are illegal if the time of the last point of the last segment
		 * is not equal the time of the first point of the segment to be added.<br>
		 * So the current statement must be true: seg[last].B.time == newSegment.A.time
		 */
		public function addSegment($segment:SegmentVO):Boolean
		{
			var add:Boolean = true;
			if (_segments.length>0) {
				var lastSegment:SegmentVO = _segments[_segments.length-1];
				var time:Number = lastSegment.B.timeMilliseconds;
				if (time != $segment.A.timeMilliseconds) {
					add = false;
				}
			}
			
			if (add) {
				_segments.push($segment);
			}
			
			
			return add;
		}
	}
}