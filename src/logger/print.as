package logger
{
	import flash.utils.getQualifiedClassName;

	public function print(...args):void
	{
		if (args && args.length>1) {
			
			var className:String = getQualifiedClassName(args[0]);
			if (Tracer.qualifiedClassNamesThatDontTrace.indexOf(className)==-1) {
				trace.apply(null, args);
			}
		}
		
		else {
			trace(args);
		}
		
	}
	
}