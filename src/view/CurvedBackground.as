package view
{
	import timetouch.surface.TouchSurface;
	
	public class CurvedBackground extends TouchSurface
	{
		public function CurvedBackground(x:Number, y:Number, width:Number, height:Number)
		{
			super();
			
			graphics.lineStyle(1,0);
			graphics.beginFill(0xeeeeee);
			graphics.drawRoundRect(x,y,width,height,5,5);
			graphics.endFill();
			
		}
	}
}