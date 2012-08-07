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

        protected var _allowedValues:Array = [];
        public function set allowedValues(v:Array):void
        {
            _allowedValues = v;
        }

		override protected function doValidation(value:Object):Array
		{
			results = [];
			results = super.doValidation(value);
			if (results.length > 0)
				return results;

            if (_allowedValues)
            {
                for each (var v:Object in _allowedValues)
                {
                    if (value == null && v == null)
                        return results;
                    if (String(value) == v)
                        return results;
                }
            }

            var text:String = String(value).toUpperCase();
			if (!/^#[0-9A-F]{6}$/.test(text))
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