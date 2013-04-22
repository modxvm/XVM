intrinsic class com.produxion.util.XML2Object
{
	private var _result : Object;
	private var _xml : XML;
	private var _path : Object;
	static private var xml2object : XML2Object;

	public function get xml() : XML;
	public function set xml(xml:XML) : Void;


	public function XML2Object();

	static public function deserialize(xml:XML) : Object;

	private function nodesToProperties(parent:XMLNode, path:Object, name:String, position:Number) : Object;

	private function sanitizeLineBreaks(raw:String);

}