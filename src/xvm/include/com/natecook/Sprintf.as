intrinsic class com.natecook.Sprintf
{
	static public var kPAD_ZEROES : Object;
	static public var kLEFT_ALIGN : Object;
	static public var kSHOW_SIGN : Object;
	static public var kPAD_POS : Object;
	static public var kALT_FORM : Object;
	static public var kLONG_VALUE : Object;
	static public var kUSE_SEPARATOR : Object;
	static public var DEBUG : Boolean;
	static public var TRACE : Boolean;

	static public function trace() : Void;

	static public function format(format:String) : String;

	static public function finish(output, value, properties, length, precision, prefix);

	static public function formatD(value, properties, length, precision);

	static public function formatO(value, properties, length, precision);

	static public function formatX(value, properties, length, precision, upper);

	static public function formatE(value, properties, length, precision, upper);

	static public function formatF(value, properties, length, precision);

	static public function formatG(value, properties, length, precision, upper);

	static public function formatS(value, properties, length, precision);

}