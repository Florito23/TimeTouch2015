package timetouch.linestorage
{
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
		
		public function LineStorage()
		{
			_linesById = new Object();
			_lines = new Vector.<LineVO>();
		}
		
		
		public function startLineByID($touchID:int, $firstX:Number, $firstY:Number, $firstTime:Number):void
		{
			var line:LineVO = new LineVO($firstX, $firstY, $firstTime);
			_linesById["t"+$touchID] = line;
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
		
		public function continueLineByID(touchID:int, x:Number, y:Number, time:Number):void
		{
			var line:LineVO = getLineByID(touchID, false);
			if (line) {
				line.addPoint(x,y,time);
			}
		}
		
		public function finishLineByID(touchID:int, x:Number, y:Number, time:Number):LineVO
		{
			var line:LineVO = getLineByID(touchID, true);
			if (line) {
				line.addPoint(x,y,time);
				return line;
			} else {
				return null;
			}
			
		}
		
		public function addLine(line:LineVO):void
		{
			_lines.push(line);
		}
	}
}