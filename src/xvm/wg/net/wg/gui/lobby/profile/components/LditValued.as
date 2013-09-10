package net.wg.gui.lobby.profile.components 
{
    import net.wg.data.gui_items.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    
    public class LditValued extends net.wg.gui.lobby.profile.components.LineDescrIconText
    {
        public function LditValued()
        {
            super();
            return;
        }

        protected override function showToolTip(arg1:net.wg.data.managers.IToolTipParams):void
        {
            var loc1:*=null;
            if (tooltip) 
            {
                if (this._value) 
                    loc1 = {"value":"<b>" + this._value + "</b>"};
                App.toolTipMgr.showComplexWithParams(tooltip, new net.wg.data.managers.impl.ToolTipParams({}, loc1));
            }
            return;
        }

        public function set value(arg1:*):void
        {
            this._value = getVehicleNameStr(arg1);
            return;
        }

        internal static function getVehicleNameStr(arg1:*):String
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 > 0) 
            {
                loc2 = new net.wg.data.gui_items.Vehicle(arg1);
                loc1 = loc2.userName;
            }
            return loc1;
        }

        internal var _value:String;
    }
}
