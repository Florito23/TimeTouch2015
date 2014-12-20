package timetouch.linestorage
{
	import logger.print;

	public class Storage
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
		
		public function Storage()
		{
			_linesById = new Object();
			_lines = new Vector.<LineVO>();
			_allSegments = new Vector.<SegmentVO>();
		}
		
		
		public function startLineByID($touchID:int, $firstX:Number, $firstY:Number, $firstTime:Number, $firstEndTime:Number):void
		{
			
			var line:LineVO = new LineVO($firstX, $firstY, $firstTime, $firstEndTime);
			print(this, "startLineByID",$touchID,line.length);
			_linesById["t"+$touchID] = line;
		}
		
		public function continueLineByID(touchID:int, x:Number, y:Number, time:Number, endTime:Number):void
		{
			var line:LineVO = getLineByID(touchID, false);
			if (line) {
				_lines.push(line);
				_allSegments.push( line.addPoint(x,y,time, endTime) );
				print(this, "continueLineByID",touchID,line.length);
			}
		}
		
		public function continueAndFinishLineByID(touchID:int, x:Number, y:Number, time:Number, endTime:Number):void
		{
			var line:LineVO = getLineByID(touchID, true);
			if (line) {
				_allSegments.push( line.addPoint(x,y,time,endTime) );
				print(this, "continueAndFinishLineByID",touchID,line.length);
			}
		}
		
		/*public function finishAndStoreLineByID(touchID:int):void
		{
			var line:LineVO = getLineByID(touchID, true);
			if (line) {
				print("finishAndStorLine",touchID,line.length);
				line.finishLastPoint();
			}
		}*/
		
		public function finishAndRestartCurrentLines(startTime:Number, endTime:Number):void
		{
			for (var key:String in _linesById) {
				var line:LineVO = _linesById[key] as LineVO;
				var p:PointVO = line.finishLastPoint();
				
				line = new LineVO(p.x, p.y, startTime, endTime);
				_linesById[key] = line;
			}
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
		
		
		
		
		
		
		
		/*public function getSegmentsAtTime(ti:Number):Vector.<SegmentVO> {
			
			var out:Vector.<SegmentVO> = new Vector.<SegmentVO>();
			
			for each (var seg:SegmentVO in _allSegments) {
				
				if (ti>=seg.lowestTime && ti<seg.highestTime) {
					out.push(seg);
				}
				
			}
			
			return out;
			
		}*/
		
		
		//TODO: optimisation possible
		
		public function getCurrentLines(ti:Number):Vector.<SegmentCollectionVO> {
			
			var out:Vector.<SegmentCollectionVO> = new Vector.<SegmentCollectionVO>();
			
			// iterate through stored lines
			for each (var line:LineVO in _lines) {
				
				// is this line visible at all during this time?
				if (ti>=line.lowestTime && ti<line.highestTime) {
					
					var lineOut:SegmentCollectionVO = new SegmentCollectionVO();
					
					// iterate through segments
					for each (var segment:SegmentVO in line.segments) {
						
						// add segment if both points are visible
						if (ti>=segment.lowestTime && ti<segment.highestTime) {
							lineOut.addSegment(segment);
						}
					}
					
					
					if (lineOut.length>0) {
						out.push(lineOut);
					}
					
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