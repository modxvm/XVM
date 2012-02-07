package utils
{
	import components.AlignComboBox;
	import components.ColorSelector;
	import components.FontComboBox;
	
	import flash.events.Event;
	
	import spark.components.CheckBox;
	import spark.components.NumericStepper;
	import spark.components.TextInput;

	public final class ItemKind 
	{ 
		public static const TextInput:String = "TextInput"; 
		public static const NumericStepper:String = "NumericStepper";
		public static const ColorSelector:String = "ColorSelector";
		public static const CheckBox:String = "CheckBox";
		public static const AlignComboBox:String = "AlignComboBox";
		public static const FontComboBox:String = "FontComboBox";
		
		public static function CreateObject(kind:String, change:Function):Object
		{
			switch (kind)
			{
				case TextInput:
					var textInput:TextInput = new spark.components.TextInput();
					textInput.addEventListener(Event.CHANGE, change);
					return textInput;

				case NumericStepper:
					var numericStepper:NumericStepper = new spark.components.NumericStepper();
					numericStepper.addEventListener(Event.CHANGE, change);
					return numericStepper;
					
				case ColorSelector:
					var colorSelector:ColorSelector = new components.ColorSelector();
					colorSelector.addEventListener(Event.CHANGE, change);
					return colorSelector;

				case CheckBox:
					var checkBox:CheckBox = new spark.components.CheckBox(); 
					checkBox.addEventListener(Event.CHANGE, change);
					return checkBox;
					
				case AlignComboBox:
					var alignComboBox:AlignComboBox = new components.AlignComboBox(); 
					alignComboBox.addEventListener(Event.CHANGE, change);
					return alignComboBox;
					
				case FontComboBox:
					var fontComboBox:FontComboBox = new components.FontComboBox(); 
					fontComboBox.addEventListener(Event.CHANGE, change);
					return fontComboBox;
			}
			return null;
		}
	}
}