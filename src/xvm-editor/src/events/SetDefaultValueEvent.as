package events
{
	import mx.events.FlexEvent;

	public class SetDefaultValueEvent extends FlexEvent
	{
		public static const TYPE:String = "setDefaultValue";

		public var sender:Object;

		public function SetDefaultValueEvent(sender:Object):void
		{
			super(TYPE, true);
			this.sender = sender;
		}
	}
}
