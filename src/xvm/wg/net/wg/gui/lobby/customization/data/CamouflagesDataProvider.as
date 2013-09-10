package net.wg.gui.lobby.customization.data 
{
    public class CamouflagesDataProvider extends net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider
    {
        public function CamouflagesDataProvider(arg1:Array=null)
        {
            super(arg1);
            return;
        }

        public static function getEmptyItem():Object
        {
            return {"id":null, "texturePath":null, "description":"", "price":{"cost":0, "isGold":false}, "isNew":false, "current":false};
        }

        public var setGroupCurrentItemId:Function;

        public var getDefaultHintText:Function;

        public var getDefaultDescription:Function;
    }
}
