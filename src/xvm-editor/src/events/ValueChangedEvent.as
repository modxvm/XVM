package events
{
	import mx.events.FlexEvent;

	public class ValueChangedEvent extends FlexEvent
	{
		public static const TYPE:String = "valueChanged";

		public var sender:Object;
		public var value:*;
		public var data:Object;

		public function ValueChangedEvent(sender:Object, value:* = null, data:Object = null):void
		{
			super(TYPE, true);
			this.sender = sender;
			this.value = value;
			this.data = data;
		}
	}
}
