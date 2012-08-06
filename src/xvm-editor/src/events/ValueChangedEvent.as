package events
{
	import mx.events.FlexEvent;

	public class ValueChangedEvent extends FlexEvent
	{
		public const TYPE:String = "valueChanged";

		public var sender:Object;

		public function ValueChangedEvent(sender:Object):void
		{
			super(TYPE, true);
			this.sender = sender;
		}
	}
}
