package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import logger.print;
	
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.SegmentVO;
	import timetouch.surface.IDrawingSurface;
	
	public class DrawingSurface extends Sprite implements IDrawingSurface
	{
		
		private var _draw:Sprite;
		
		public function DrawingSurface()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void {
			
			print(this, "onStage()");
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			_draw = new Sprite();
			_draw.mouseEnabled = false;
			addChild(_draw);
			
		}
		
		
		
		
		
		
		
		/*public function drawLines(lines:Vector.<LineVO>):void
		{
			var ti:Number = getTimer();
			_draw.removeChildren();
			var segs:Vector.<SegmentVO>;
			var line:LineVO;
			var seg:SegmentVO;
			
			for each (line in lines) {
				segs = line._segments;
				for each (seg in segs) {
					if (seg.drawableFlag) {
						var spr:Sprite = new Sprite();
						spr.mouseEnabled = false;
						spr.graphics.lineStyle(2,0x880000);
						spr.graphics.moveTo(seg.A.x, seg.A.y);
						spr.graphics.lineTo(seg.B.x, seg.B.y);
						_draw.addChild(spr);
					}
				}
			}
			print(this, "drawLines()", "time", (getTimer()-ti));
		}*/
		
		
		public function drawSegments(segments:Vector.<SegmentVO>):void {
			
			var ti:Number = getTimer();
			
			_draw.removeChildren();
			
			var count:int = segments.length;
			for (var i:int=0;i<count;i++) {
				var seg:SegmentVO = segments[i];
			//for each (var seg:SegmentVO in segments) {
				
				var spr:Sprite = new Sprite();
				spr.mouseEnabled = false;
				spr.graphics.lineStyle(2,0x880000);
				spr.graphics.moveTo(seg.A.x, seg.A.y);
				spr.graphics.lineTo(seg.B.x, seg.B.y);
				_draw.addChild(spr);
				
			}
			
			print(this, "drawSegments()", "time", (getTimer()-ti));
		}
	
		
		
		
		
				
		
	}
}