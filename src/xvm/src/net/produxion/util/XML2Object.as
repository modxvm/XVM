/*
* - Derived from code written by Alessandro Crugnola - http://www.sephiroth.it/file_detail.php?id=129#
* - Refactored and documented by Phil Powell - http://www.sillydomainname.com
* - 25 July 2006 - Added helper method to sanitize Windows line breaks.
*
* Convert an XML object to an object with nested properties.
*
* Example usage:
*
*   import net.produxion.util.XML2Object;
*   var contentObj:Object;
*   var xml:XML = new XML();
*   var xmlLoaded = function( success:Boolean )
*   {
*   	if( success )
*   	{
*   		contentObj = XML2Object.deserialize( this );
*   		this['timeline'].play();
*   	}
*   }
*
*   xml.ignoreWhite = true;
*   xml['timeline'] = this;
*   xml.onLoad = xmlLoaded;
*   xml.load( 'some.xml' );
*
*
* What do you get back?
*
*   <content created="22-May-2006">
*       <title>My Title</title>
*       <links>
*           <heading>Here be links!</heading>
*           <link>http://somewhere.com</link>
*           <link>http://somewhere-else.com</link>
*       </links>
*   </content>
*
*   Becomes:
*
*   contentObj.content.title.data => "My Title"
*   contentObj.content.links.title.data => "Here be links!"
*   contentObj.content.links.link => [Array]
*   contentObj.content.links.link[0].data => "http://somewhere.com"
*   contentObj.content.attributes.created => "22-May-2006"
*/

class net.produxion.util.XML2Object {

	private var _result:Object;
	private var _xml:XML;
	private var _path:Object;
	private static var xml2object:XML2Object;

	public function XML2Object()
	{
		this._result = new Object();		
	}
	
	public static function deserialize( xml:XML ):Object
	{
		xml2object = new XML2Object();
		xml2object.xml = xml;
		return xml2object.nodesToProperties();
	}
	
	public function get xml():XML
	{
		return _xml;
	}
	
	public function set xml( xml:XML ):Void
	{
		this._xml = xml;
	}
	
	private function nodesToProperties( parent:XMLNode, path:Object, name:String, position:Number ):Object
	{
		var nodes:Array;
		var node:XMLNode;
		
		path == undefined ? path = this._result : path = path[name];
		if( parent == undefined) parent = XMLNode( this._xml );
		
		if( parent.hasChildNodes() )
		{
			nodes = parent.childNodes;
			if (position != undefined) path = path[position];
			
			while( nodes.length > 0 )
			{
				node = XMLNode( nodes.shift() );

				if ( node.nodeName != undefined )
				{
					var obj = new Object();
					obj.attributes = node.attributes;
					obj.data = sanitizeLineBreaks( node.firstChild.nodeValue );
					
					if( path[node.nodeName] != undefined )
					{

						if( path[node.nodeName].__proto__ == Array.prototype )
						{
							path[node.nodeName].push( obj );
						}
						else
						{
							var copyObj = path[node.nodeName];
							delete path[node.nodeName];
							path[node.nodeName] = new Array();  
							path[node.nodeName].push( copyObj );
							path[node.nodeName].push( obj );
						}
						position = path[node.nodeName].length - 1;
					}
					else
					{
						path[node.nodeName] = obj;
						position = undefined;
					}
					name = node.nodeName;
				}
				
				if( node.hasChildNodes() )
				{
					this.nodesToProperties( node, path, name, position );
				}
			}
			
		}
		return this._result;
	}
	
	private function sanitizeLineBreaks( raw:String )
	{
		if( raw.indexOf( "\r\n" ) > -1 )
		{
			return raw.split( "\r\n" ).join( "\n" );
		}
		return raw;
	}
}