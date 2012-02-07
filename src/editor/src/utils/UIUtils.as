package utils
{
	import components.AlignComboBox;
	import components.ColorSelector;
	import components.FontComboBox;
	
	import flash.utils.getQualifiedClassName;
	
	import mx.controls.ColorPicker;
	import mx.controls.DateField;
	import mx.core.UIComponent;
	
	import spark.components.CheckBox;
	import spark.components.NumericStepper;
	import spark.components.TextInput;

	public class UIUtils
	{
		public static function getComponentValue(target:UIComponent):*
		{
			if (target is TextInput)
				return (target as TextInput).text;

			if (target is DateField)
				return (target as DateField).selectedDate;

			if (target is CheckBox)
				return (target as CheckBox).selected;

			if (target is NumericStepper)
				return (target as NumericStepper).value;

			if (target is ColorSelector)
				return (target as ColorSelector).colorStr;

			if (target is AlignComboBox)
				return (target as AlignComboBox).selectedItem;
			
			if (target is FontComboBox)
				return (target as FontComboBox).selectedItem;

			throw new Error("utils.UIUtils.getComponentValue(): Internal Error: Control is not supported: " +
				flash.utils.getQualifiedClassName(target));
		}

		public static function setComponentValue(target:UIComponent, value:Object):void
		{
			if (target is TextInput)
			{
				(target as TextInput).text = value as String;
				return;
			}

			if (target is DateField)
			{
				(target as DateField).selectedDate = value as Date;
				return;
			}

			if (target is CheckBox)
			{
				(target as CheckBox).selected = value as Boolean;
				return;
			}

			if (target is NumericStepper)
			{
				(target as NumericStepper).value = value as int;
				return;
			}

			if (target is ColorSelector)
			{
				(target as ColorSelector).colorStr = value as String;
				return;
			}

			if (target is AlignComboBox)
			{
				(target as AlignComboBox).selectedItem = value as String;
				return;
			}
			
			if (target is FontComboBox)
			{
				(target as FontComboBox).selectedItem = value as String;
				return;
			}

			throw new Error("utils.UIUtils.setComponentValue(): Internal Error: Control is not supported: " +
				flash.utils.getQualifiedClassName(target));
		}
	}
}
