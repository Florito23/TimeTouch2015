package timetouch.linestorage
{
	public class LineVO
	{
		
		private var _startPoint:PointVO;
		private var _segments:Vector.<SegmentVO>;
		
		public function LineVO($firstX:Number, $firstY:Number, $firstTime:Number)
		{
			_segments = new Vector.<SegmentVO>();
			_startPoint = new PointVO($firstX, $firstY, $firstTime);
		}
		
		public function addPoint(x:Number, y:Number, time:Number):void
		{
			var newPoint:PointVO = new PointVO(x, y, time);
			if (_startPoint) {
				var firstSegment:SegmentVO = new SegmentVO(_startPoint, newPoint);
				_segments.push(firstSegment);
				_startPoint = null;
			}
			else {
				var lastPoint:PointVO = _segments[_segments.length-1].B;
				var otherSegment:SegmentVO = new SegmentVO(lastPoint, newPoint);
			}
		}
		
		/**
		 * Returns false if the segment was illegal<br>
		 * Segments are illegal if the time of the last point of the last segment
		 * is not equal the time of the first point of the segment to be added.<br>
		 * So the current statement must be true: seg[last].B.time == newSegment.A.time
		 */
		/*public function addSegment($segment:SegmentVO):Boolean
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
		}*/
		
	}
}