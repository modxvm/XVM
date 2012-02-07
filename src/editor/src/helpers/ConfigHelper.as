package helpers
{
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.SchemaLoadEvent;
	import mx.rpc.xml.Schema;
	import mx.rpc.xml.SchemaLoader;
	import mx.rpc.xml.SchemaManager;
	import mx.rpc.xml.SchemaTypeRegistry;
	import mx.rpc.xml.XMLDecoder;
	import mx.rpc.xml.XMLEncoder;
	import mx.utils.ObjectUtil;
	
	import utils.PatchedXMLDecoder;

	public final class ConfigHelper
	{
		/**
		 * Convert config to new format.
		 */
		private static function FixConfigXml(xml:XML):XML
		{
			var v:String = xml.attribute("configVersion");

			if (v == null || v == "")
			{
				// Convert OTMData.xml => XVM 1.0.0
				xml = instance.EncodeXML(new OTMConfigConverter((new PatchedXMLDecoder().decode(xml))).config); 
				//throw new Error(xml.toXMLString());
				v = "1.0.0";
			}

			if (v == "1.0.0")
			{
				// Convert XVM 1.0.0 =>
			}

			return xml;
		}

		// Properties
		[Embed(source="XVM.xsd", mimeType="application/octet-stream")]
		public static var XVM_XSD:Class;

		protected var schema:Schema;
		protected var schemaManager:SchemaManager;

		// Public
		public static function CurrentConfigVersion():String
		{
			return ConfigToXml(new Object()).attribute("configVersion");
		}

		public static function XmlToConfig(xml:XML):*
		{
			if (xml.attribute("configVersion") != CurrentConfigVersion())
				xml = FixConfigXml(xml);
			return instance.DecodeXML(xml);
		}

		public static function ConfigToXml(config:*):XML
		{
			return instance.EncodeXML(config);
		}

		public static function SetConfigValue(config:*, path:String, value:*):void
		{
			var p:Array = path.split("/"); // "path/to/value"
			var valueElement:String = p.pop(); // last element is value

			// Start from root element
			var root:* = config;

			for each (var e:String in p)
			{
				// Create shild if not exist
				if (!root.hasOwnProperty(e))
					root[e] = new Object();
				// Shift root to next child
				root = root[e];
			}

			// Set value
			if (value != null)
				root[valueElement] = value;
			else
				delete root[valueElement];
		}

		public static function GetConfigValue(config:*, path:String):*
		{
			var p:Array = path.split("/"); // "path/to/value"

			// Start from root element
			var root:* = config;

			for each (var e:String in p)
			{
				// Create shild if not exist
				if (!root.hasOwnProperty(e))
					return undefined;
				// Shift root to next child
				root = root[e];
			}

			// Set value
			return root;
		}

		// Singleton
		private static var _instance:ConfigHelper = new ConfigHelper();

		public function ConfigHelper()
		{
			if (_instance != null)
				throw new Error("Internal error: Class ConfigHelper is singleton.");

			Init();
		}

		public static function get instance():ConfigHelper
		{
			return _instance;
		}

		private function Init():void
		{
			schema = new Schema(XML(new XVM_XSD()));
			schemaManager = new SchemaManager();
			schemaManager.addSchema(schema);
		}

		/**
		 * Decodes XML into ActionScript objects using the schema definitions within SchemaManager
		 */
		private function DecodeXML(xml:XML):*
		{
			var qName:QName = new QName(schema.targetNamespace.uri, "xvmconfig");
			var xmlDecoder:PatchedXMLDecoder = new PatchedXMLDecoder();
			xmlDecoder.schemaManager = schemaManager;
			return xmlDecoder.decode(xml, qName);
		}

		public function EncodeXML(data:*):XML
		{
			var qName:QName = new QName(schema.targetNamespace.uri, "xvmconfig");

			var xmlEncoder:XMLEncoder = new XMLEncoder();
			xmlEncoder.schemaManager = schemaManager;

			//var schemaTypeRegistry:SchemaTypeRegistry = new SchemaTypeRegistry();
			//schemaTypeRegistry.registerClass(new QName(schema.targetNamespace.uri, "xvmconfig"), data);

			return new XML(xmlEncoder.encode(data, qName));

		}
	}
}