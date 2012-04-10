package events
{
	import mx.events.FlexEvent;
	
	public class XVMValueEvent extends FlexEvent
	{
		public static const TYPE:String = "xvmvalue";

		public var key:String;
		public var value:*;
		public var data:Object;
		
		public function XVMValueEvent(key:String, value:* = null, data:Object = null):void
		{
			super(TYPE, true);
			this.key = key;
			this.value = value;
			this.data = data;
		}
	}
}
