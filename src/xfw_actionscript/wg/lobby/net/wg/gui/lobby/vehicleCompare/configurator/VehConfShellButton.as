package net.wg.gui.lobby.vehicleCompare.configurator
{
    import net.wg.gui.components.advanced.CooldownSlot;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class VehConfShellButton extends CooldownSlot
    {

        private var _ammunitionType:String;

        private var _tooltipType:String = "compareShell";

        private var _tooltip:String = "";

        private var _historicalBattleID:int = -1;

        public function VehConfShellButton()
        {
            super();
        }

        override protected function onDispose() : void
        {
            super.onDispose();
        }

        override protected function onMouseOver() : void
        {
            super.onMouseOver();
            var _loc1_:String = id;
            if(StringUtils.isNotEmpty(_loc1_))
            {
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.COMPARE_SHELL,null,_loc1_,this.historicalBattleID);
            }
        }

        override protected function onMouseOut() : void
        {
            super.onMouseOut();
            App.toolTipMgr.hide();
        }

        public function get ammunitionType() : String
        {
            return this._ammunitionType;
        }

        public function set ammunitionType(param1:String) : void
        {
            this._ammunitionType = param1;
        }

        public function get tooltipType() : String
        {
            return this._tooltipType;
        }

        public function set tooltipType(param1:String) : void
        {
            this._tooltipType = param1;
        }

        public function get historicalBattleID() : int
        {
            return this._historicalBattleID;
        }

        public function set historicalBattleID(param1:int) : void
        {
            this._historicalBattleID = param1;
        }

        public function get tooltip() : String
        {
            return this._tooltip;
        }

        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
        }
    }
}
