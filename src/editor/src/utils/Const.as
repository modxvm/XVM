package utils
{
	import com.adobe.serialization.json.JSON;

	public final class Const
	{
		public static const MODE_SINGLE: int = 1;
		public static const MODE_MULTI: int = 2;

		public static const AlignValues: Array = [ "right", "center", "left" ];

		public static const GroupComponent:String = "GroupComponent";
		public static const ADGItemRenrerer:String = "ADGItemRenrerer";
		
		public static const DefaultConfig:Object = 
			{
				configVersion: "1.0.0",
				editorVersion: "0.0.1.a1",
				definition: {
					author: "sirmax2",
					description: "Default settings for XVM",
					url: "http://code.google.com/p/wot-xvm/",
					date: "2012-02-11",
					gameVersion: "0.7.1",
					modVersion: "1.2"
				}
			}

	}
}