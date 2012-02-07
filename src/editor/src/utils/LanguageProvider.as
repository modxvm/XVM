package utils
{
	public class LanguageProvider
	{
		private var fobj_languageData:Array = [];
		
		public function Clear():void
		{
			fobj_languageData = new Array(); 
		}
		
		public function AddLanguageData(fileName:String):void
		{
			var id:String = "";
			var parent:XML = null;
			
			for each (var item:XML in ResourcesManager.FileAsXML(fileName)..*.(hasOwnProperty("@value")))
			{
				id = item.name();
				parent = item.parent();
				while (parent != null)
				{
					id = parent.name() + "." + id;
					parent = parent.parent();
				}
				fobj_languageData[id] = item.@value; 
			}
		}
		
		public function GetStringFor(item:String):String
		{
			var result:String = fobj_languageData[item];
			
			if (result != null)
				return result;
			else
				return "<-!->";
		}
	}
}
