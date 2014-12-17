package timetouch.linestorage
{
	public class LineVO
	{
		
		private var _startPoint:PointVO;
		private var _segments:Vector.<SegmentVO>;
		
		public function LineVO($firstX:Number, $firstY:Number, $firstStartTime:Number, $firstEndTime)
		{
			_segments = new Vector.<SegmentVO>();
			_startPoint = new PointVO($firstX, $firstY, $firstStartTime, $firstEndTime, PointVO.TYPE_CAP);
		}
		
		public function get length():int
		{
			return _segments.length;
		}
		
		public function addPoint(x:Number, y:Number, time:Number, endTime:Number):SegmentVO
		{
			
			if (_startPoint) {
				var secondPoint:PointVO = new PointVO(x, y, time, endTime, PointVO.TYPE_CAP);
				var firstSegment:SegmentVO = new SegmentVO(_startPoint, secondPoint);
				_segments.push(firstSegment);
				_startPoint = null;
				return firstSegment;
			}
			else {
				var newPoint:PointVO = new PointVO(x, y, time, endTime, PointVO.TYPE_CAP);
				var lastPoint:PointVO = _segments[_segments.length-1].B;
				lastPoint.type = PointVO.TYPE_INBETWEEN;
				var otherSegment:SegmentVO = new SegmentVO(lastPoint, newPoint);
				_segments.push(otherSegment);
				return otherSegment;
			}
		}
		
		public function finishLastPoint():PointVO
		{
			var p:PointVO = _segments[_segments.length-1].B;
			p.type = PointVO.TYPE_CAP;
			return p;
		}
		
		public function toString():String
		{
			var out:String = "[LineVO ";
			
			if (_startPoint) {
				out += pointToString(_startPoint);	
			}
			else {
				for (var i:int=0;i<_segments.length;i++) {
					out += pointToString(_segments[i].A);
					out += "---";
				}
				out += pointToString(_segments[_segments.length-1].B);
			}
			
			out += "]";
			return out;
		}
		
		private function pointToString(_startPoint:PointVO):String
		{
			return "("
				+ (_startPoint.type==PointVO.TYPE_CAP ? "CAP " : "- ")
				+ _startPoint.x.toFixed(1)
				+ "/"
				+ _startPoint.y.toFixed(1)
				+ ")";
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