package timetouch.linestorage
{
	import flash.utils.getTimer;
	
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
		
		
		
		
		
		/*public function updateDrawableStatusAndGetLines(ti:Number):Vector.<LineVO>
		{
			var t:Number = getTimer();
			var out:Vector.<LineVO> = new Vector.<LineVO>();
			var segs:Vector.<SegmentVO>;
			var count:int;
			var i:int;
			var seg:SegmentVO;
			var A:PointVO;
			var B:PointVO;
			for each (var line:LineVO in _lines) {
				if (ti>=line.timeMinimum && ti<line.timeMaximum) {
					out.push(line);
					segs = line._segments;
					count = segs.length;
					for (i=0;i<count;i++) {
						seg = segs[i];
						A = seg.A;
						B = seg.B;
						seg.drawableFlag =
							ti >= A.startTime && ti < A.endTime &&
							ti >= B.startTime && ti < B.endTime
					}
				}
			}
			print(this, "updateDrawable()", (getTimer()-t));
			return out;
		}*/
		
		/*public function getLinesAtTime(ti:Number):Vector.<LineVO> {
			var out:Vector.<LineVO> = new Vector.<LineVO>();
			
			for each (var line:LineVO in _lines) {
				if (ti>=line.timeMinimum && ti<line.timeMaximum) {
					out.push(line);
				}
			}
			
			return out;
		}*/
		
		public function getSegmentsAtTime(ti:Number):Vector.<SegmentVO> {
			
			//TODO: optimisation possible
			
			//var t:GetTimer();
			var out:Vector.<SegmentVO> = new Vector.<SegmentVO>();
			
			//TODO: here we can use the lineID of the segment to check for start/end line?
			
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