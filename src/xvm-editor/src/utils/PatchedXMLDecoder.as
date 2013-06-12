package utils
{
	import mx.rpc.xml.XMLDecoder;
	
	public class PatchedXMLDecoder extends XMLDecoder
	{
		public function PatchedXMLDecoder()
		{
			super();
		}
		
		override protected function parseValue(name:*, value:XMLList):*
		{
			var result:* = value;
			
			/**
			 *    Andy McIntosh - April 10, 2009
			 * 
			 *  Work around for #SDK-17271 where XMLDecoder incorrectly
			 *  decodes elements that do not contain sub-elements.
			 * 
			 *     (https://bugs.adobe.com/jira/browse/SDK-17271)
			 * 
			 *     Added second condition below that checks to see if the value is
			 *  an empty node which may have attributes that need decoded, 
			 *  by testing if the inner value of the node is blank.
			 */ 
			
			// We unwrap simple content and get the value as a String
			if (value.hasSimpleContent() && value[0] && value[0].toString() != "")
			{
				if (isXSINil(value))
					result = null;
				else
					result = value.toString();
			}
				// Otherwise, as a convenience we unwrap an XMLList containing only one
				// XML node...
			else if (value.length() == 1)
			{
				result = value[0];
			}
			
			return result;
		}
		
	}
}
