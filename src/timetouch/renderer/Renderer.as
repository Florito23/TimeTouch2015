package timetouch.renderer
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import timetouch.linestorage.PointVO;
	import timetouch.linestorage.SegmentCollectionVO;
	import timetouch.linestorage.SegmentVO;
	import timetouch.linestorage.Storage;
	import timetouch.surface.IDrawingSurface;

	public class Renderer
	{
		public function Renderer()
		{
		}
		
		public function render(storage:Storage, currentTimeMilliseconds:Number, drawingSurface:IDrawingSurface):void
		{
			
			var lines:Vector.<SegmentCollectionVO> = storage.getCurrentLines(currentTimeMilliseconds);
			drawingSurface.drawSegmentCollections(lines);
			
			//var segs:Vector.<SegmentVO> = storage.getSegmentsAtTime(currentTimeMilliseconds);
			//drawingSurface.drawSegments(segs);
			
			/*dsp.removeChildren();
			
			for each (var seg:SegmentVO in segs) {
				
				var spr:Sprite = new Sprite();
				spr.mouseEnabled = false;
				spr.graphics.lineStyle(2,0x880000);
				spr.graphics.moveTo(seg.A.x, seg.A.y);
				spr.graphics.lineTo(seg.B.x, seg.B.y);
				
				if (seg.A.type == PointVO.TYPE_CAP) {
					spr.graphics.beginFill(0x008800);
					spr.graphics.drawRect(seg.A.x-2, seg.A.y-2, 4, 4);
				}
				if (seg.B.type == PointVO.TYPE_CAP) {
					spr.graphics.beginFill(0x008800);
					spr.graphics.drawRect(seg.B.x-2, seg.B.y-2, 4, 4);
				}
				
				dsp.addChild(spr);
				
			}
			*/
			
			/*var creatingLines:Object = _creatingLines.linesByID;
			for (var key:String in creatingLines) {
				var line:LineVO = creatingLines[key] as LineVO;
				draw(line, currentTimeMilliseconds, _drawingSurface);
			}*/
			
			
			//TODO: star ttiume/ end time
		}
		
	}
}