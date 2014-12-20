package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import logger.print;
	
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.PointVO;
	import timetouch.linestorage.SegmentCollectionVO;
	import timetouch.linestorage.SegmentVO;
	import timetouch.surface.IDrawingSurface;
	import timetouch.surface.TouchSurface;
	
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
		
		public function drawSegmentCollections(lines:Vector.<SegmentCollectionVO>):void
		{
			_draw.removeChildren();
			for each (var line:SegmentCollectionVO in lines) {
				
				for each (var seg:SegmentVO in line.segments) {
					
					var spr:Sprite = new Sprite();
					spr.mouseEnabled = false;
					spr.graphics.lineStyle(2,0x880000);
					spr.graphics.moveTo(seg.A.x, seg.A.y);
					spr.graphics.lineTo(seg.B.x, seg.B.y);
					
					_draw.addChild(spr);
					
				}
				
			}
		}
		
		
		/*public function drawSegments(segments:Vector.<SegmentVO>):void {
			_draw.removeChildren();
			
			for each (var seg:SegmentVO in segments) {
				
				var spr:Sprite = new Sprite();
				spr.mouseEnabled = false;
				spr.graphics.lineStyle(2,0x880000);
				spr.graphics.moveTo(seg.A.x, seg.A.y);
				spr.graphics.lineTo(seg.B.x, seg.B.y);
				
				_draw.addChild(spr);
				
			}
		}
		public function drawLines(lines:Vector.<LineVO>):void {
			//TODO: 
		}*/
		
		
		
		
				
		
	}
}