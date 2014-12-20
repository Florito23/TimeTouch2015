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
				
				
				if (seg.isPoint) {
					spr.graphics.beginFill(0x000088);
					spr.graphics.drawCircle(seg.A.x-1, seg.A.y-1, 1);
				}
				
				else {
					spr.graphics.lineStyle(2,0x000088);
					spr.graphics.moveTo(seg.A.x, seg.A.y);
					spr.graphics.lineTo(seg.B.x, seg.B.y);
				
					var mx:Number = (seg.A.x+seg.B.x)/2;
					var my:Number = (seg.A.y+seg.B.y)/2;
					
					spr.graphics.lineStyle(1,0x880000);
					spr.graphics.moveTo(mx, my);
					var tx:Number = seg.tangentialRight.x * 5;
					var ty:Number = seg.tangentialRight.y * 5;
					spr.graphics.lineTo(mx+tx, my+ty);
					
					spr.graphics.lineStyle(1,0x008800);
					spr.graphics.moveTo(mx, my);
					tx = seg.tangentialLeft.x * 5;
					ty = seg.tangentialLeft.y * 5;
					spr.graphics.lineTo(mx+tx, my+ty);
					
					
				}
				
				_draw.addChild(spr);
				
			}
			
			print(this, "drawSegments()", "time", (getTimer()-ti));
		}
	
		
		
		
		
				
		
	}
}