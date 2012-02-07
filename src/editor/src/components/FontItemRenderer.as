package components
{
	import mx.controls.Label;
	import mx.events.FlexEvent;

	public class FontItemRenderer extends Label
	{
		public function FontItemRenderer()
		{
			super();
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			setStyle("fontFamily", value);
			text = value as String;
			dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
		}
	}
}
