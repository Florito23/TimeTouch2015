package timetouch.linestorage
{
	import logger.print;

	public class LineStorage
	{
		
		public function get linesByID():Object
		{
			return _linesById;
		}
		private var _linesById:Object;
		
		public function get lines():Vector.<LineVO> {
			return _lines;
		}
		private var _lines:Vector.<LineVO>;
		
		private var _allSegments:Vector.<SegmentVO>;
		
		public function LineStorage()
		{
			_linesById = new Object();
			_lines = new Vector.<LineVO>();
			_allSegments = new Vector.<SegmentVO>();
		}
		
		
		public function startLineByID($touchID:int, $firstX:Number, $firstY:Number, $firstTime:Number, $firstEndTime:Number):void
		{
			var line:LineVO = new LineVO($firstX, $firstY, $firstTime, $firstEndTime);
			_linesById["t"+$touchID] = line;
		}
		
		public function continueLineByID(touchID:int, x:Number, y:Number, time:Number, endTime:Number):void
		{
			var line:LineVO = getLineByID(touchID, false);
			if (line) {
				_lines.push(line);
				_allSegments.push( line.addPoint(x,y,time, endTime) );
			}
		}
		
		public function finishAndStoreLineByID(touchID:int, x:Number, y:Number, time:Number, endTime:Number):void
		{
			var line:LineVO = getLineByID(touchID, true);
			if (line) {
				_allSegments.push( line.addPoint(x,y,time,endTime) );
				
				//return line;
			}/* else {
				return null;
			}*/
			
		}
		
		
		private function getLineByID(touchID:int, deleteFromObject:Boolean):LineVO
		{
			var key:String = "t"+touchID;
			if (_linesById.hasOwnProperty(key)) {
				var line:LineVO = _linesById[key] as LineVO; 
				if (deleteFromObject) {
					delete _linesById[key];
				}
				return line; 
			} else {
				return null;
			}
		}
		
		
		
		
		
		
		
		public function getSegmentsAtTime(ti:Number):Vector.<SegmentVO> {
			
			//TODO: optimisation possible
			var out:Vector.<SegmentVO> = new Vector.<SegmentVO>();
			
			for each (var seg:SegmentVO in _allSegments) {
				
				if (ti>=seg.lowestTime && ti<seg.highestTime) {
					out.push(seg);
				}
				
			}
			
			return out;
			
		}
		
		/*private function addLine(line:LineVO):void
		{
			_lines.push(line);
		}*/
	}
}