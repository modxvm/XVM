package validators
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	[ResourceBundle("validators")]
	public class TextColorValidator extends Validator
	{
		private var results:Array;

		public function TextColorValidator()
		{
			super();
		}

		override protected function doValidation(value:Object):Array
		{
			results = [];
			results = super.doValidation(value);
			if (results.length > 0)
				return results;

			var text:String = String(value).toUpperCase();

			if (text != "" && !/^#[0-9A-F]{6}$/.test(text))
			{
				results.push(new ValidationResult(true, null, "Format",
					resourceManager.getString("validators", "colorHint")));
				return results;
			}

			// OK
			return results;
		}
	}
}