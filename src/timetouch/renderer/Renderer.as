package timetouch.renderer
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import timetouch.linestorage.LineStorage;
	import timetouch.linestorage.SegmentVO;
	import timetouch.surface.DrawingSurface;

	public class Renderer
	{
		public function Renderer()
		{
		}
		
		public function render(storage:LineStorage, currentTimeMilliseconds:Number, drawingSurface:DrawingSurface):void
		{
			
			var segs:Vector.<SegmentVO> = storage.getSegmentsAtTime(currentTimeMilliseconds);
			var dsp:DisplayObjectContainer = drawingSurface.getDrawingContainter();
			
			dsp.removeChildren();
			
			for each (var seg:SegmentVO in segs) {
				
				var spr:Sprite = new Sprite();
				spr.mouseEnabled = false;
				spr.graphics.lineStyle(3,0x880000);
				spr.graphics.moveTo(seg.A.x, seg.A.y);
				spr.graphics.lineTo(seg.B.x, seg.B.y);
				
				dsp.addChild(spr);
				
			}
			
			
			/*var creatingLines:Object = _creatingLines.linesByID;
			for (var key:String in creatingLines) {
				var line:LineVO = creatingLines[key] as LineVO;
				draw(line, currentTimeMilliseconds, _drawingSurface);
			}*/
			
			
			//TODO: star ttiume/ end time
		}
		
	}
}