package net.wg.gui.lobby.vehiclePreview.controls
{
    import flash.utils.Dictionary;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewEliteFactSheetVO;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;

    public class VehPreviewEliteFactSheet extends VehPreviewInfoPanelTab
    {

        private static const BOTTOM_MARGIN:int = 27;

        private static const BONUSES:Dictionary = new Dictionary();

        public var info:TextField;

        public var title:TextField;

        public var crewIcon:Sprite;

        public var battleIcon:Sprite;

        public var replaceIcon:Sprite;

        public var creditIcon:Sprite;

        private var _toolTipMgr:ITooltipMgr;

        public function VehPreviewEliteFactSheet()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
            BONUSES[this.replaceIcon] = VEHPREVIEW_CONSTANTS.REPLACE_BONUS;
            BONUSES[this.crewIcon] = VEHPREVIEW_CONSTANTS.CREW_BONUS;
            BONUSES[this.creditIcon] = VEHPREVIEW_CONSTANTS.CREDIT_BONUS;
            BONUSES[this.battleIcon] = VEHPREVIEW_CONSTANTS.BATTLE_BONUS;
        }

        override protected function configUI() : void
        {
            var _loc1_:Object = null;
            for(_loc1_ in BONUSES)
            {
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onBonusRollOverHandler,false,0,true);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onBonusRollOutHandler,false,0,true);
            }
            this.info.addEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler,false,0,true);
            this.info.addEventListener(MouseEvent.ROLL_OUT,this.onBonusRollOutHandler,false,0,true);
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:Object = null;
            for(_loc1_ in BONUSES)
            {
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onBonusRollOverHandler);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onBonusRollOutHandler);
            }
            this.info.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler);
            this.info.removeEventListener(MouseEvent.ROLL_OUT,this.onBonusRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.info = null;
            this.title = null;
            this.replaceIcon = null;
            this.crewIcon = null;
            this.creditIcon = null;
            this.battleIcon = null;
            App.utils.data.cleanupDynamicObject(BONUSES);
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function onDataUpdated(param1:Object) : void
        {
            var _loc2_:VehPreviewEliteFactSheetVO = VehPreviewEliteFactSheetVO(param1);
            this.title.text = _loc2_.title;
            this.info.htmlText = _loc2_.info;
            height = actualHeight;
        }

        protected function showTooltip(param1:int) : void
        {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_ELITE_BONUS,null,param1);
        }

        override public function get bottomMargin() : int
        {
            return BOTTOM_MARGIN;
        }

        private function onBonusRollOverHandler(param1:MouseEvent) : void
        {
            this.showTooltip(BONUSES[param1.target]);
        }

        private function onBonusRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onInfoRollOverHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
        }
    }
}
