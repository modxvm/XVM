package net.wg.gui.lobby.battleResults
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleResultsMedalsListVO extends DAAPIDataClass
    {
        
        public function BattleResultsMedalsListVO(param1:Object) {
            super(param1);
        }
        
        public var type:String = "";
        
        public var block:String = "";
        
        public var inactive:Boolean;
        
        public var icon:String = "";
        
        public var rank:Number;
        
        public var localizedValue:String = "";
        
        public var unic:Boolean;
        
        public var rare:Boolean;
        
        public var title:String = "";
        
        public var description:String = "";
        
        public var rareIconId:String = "";
        
        public var isEpic:Boolean;
        
        public var specialIcon:String = "";
        
        public var customData:Object;
    }
}
