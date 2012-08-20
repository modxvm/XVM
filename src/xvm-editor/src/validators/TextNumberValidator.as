package validators
{
    import mx.validators.ValidationResult;
    import mx.validators.Validator;

    [ResourceBundle("validators")]
    public class TextNumberValidator extends Validator
    {
        private var results:Array;

        public function TextNumberValidator()
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

            if (isNaN(parseFloat(value.toString())))
            {
                results.push(new ValidationResult(true, null, "Format",
                    resourceManager.getString("validators", "numberHint")));
                return results;
            }

            // OK
            return results;
        }
    }
}