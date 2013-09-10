package net.wg.gui.lobby.profile.pages.technique 
{
    import net.wg.data.daapi.base.*;
    import net.wg.data.gui_items.*;
    
    public class TechniqueListVehicleVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TechniqueListVehicleVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get winsEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.winsEfficiency) + "%";
        }

        public function set winsEfficiencyStr(arg1:String):void
        {
            this._winsEfficiencyStr = arg1;
            return;
        }

        public function get nationIconPath():String
        {
            return App.utils.nations.getNationIcon(this.nationID);
        }

        public var id:int;

        public var inventoryID:int;

        public var nationID:int;

        public var isInHangar:Boolean;

        public var shortUserName:String="";

        public var userName:String="";

        public var battlesCount:int;

        public var winsEfficiency:Number;

        internal var _winsEfficiencyStr:String="";

        public var avgExperience:Number;

        public var nationIndex:int;

        public var typeIconPath:String="";

        public var tankIconPath:String="";

        public var typeIndex:int;

        public var markOfMastery:int;

        public var level:int;
    }
}
