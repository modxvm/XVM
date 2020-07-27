package net.wg.gui.battle.views.staticMarkers.epic.sectorbase
{
    import net.wg.gui.battle.components.BattleIconHolder;
    import net.wg.gui.battle.components.EpicProgressCircle;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;

    public class SectorBaseIcon extends BattleIconHolder
    {

        public static const HOVER_STATE:int = 6;

        private static const BG_POSTFIX:String = "Base";

        private static const BG_COLORBLIND_POSTFIX:String = "ColorBlindBase";

        private static const HOVER_POSTFIX:String = "BaseHover";

        private static const HOVER_COLORBLIND_POSTFIX:String = "ColorBlindBaseHover";

        private static const ENEMY:String = "enemy";

        public var progressCircle:EpicProgressCircle = null;

        public var baseId:MovieClip = null;

        public var bg:MovieClip = null;

        public var targetHighlight:MovieClip = null;

        public var sectorBaseHover:MovieClip = null;

        private var _owningTeam:String = null;

        private var _vmManager:VehicleMarkersManager;

        public function SectorBaseIcon()
        {
            super();
            this._vmManager = VehicleMarkersManager.getInstance();
            this.bg.visible = true;
            this.progressCircle.visible = false;
            this.sectorBaseHover.visible = false;
        }

        override protected function onDispose() : void
        {
            this.progressCircle.dispose();
            this.progressCircle = null;
            this.baseId = null;
            this.bg = null;
            this.targetHighlight = null;
            this.sectorBaseHover = null;
            super.onDispose();
        }

        public function setBaseId(param1:int) : void
        {
            this.baseId.gotoAndStop(param1);
        }

        public function setCapturePoints(param1:Number) : void
        {
            this.progressCircle.updateProgress(param1);
        }

        public function activateEpicVisibility() : void
        {
            this.progressCircle.visible = true;
            this.bg.visible = true;
            this.baseId.visible = true;
        }

        public function getOwningTeam() : String
        {
            return this._owningTeam;
        }

        public function setOwningTeam(param1:String) : void
        {
            this._owningTeam = param1;
            this.progressCircle.setOwner(param1 != ENEMY);
            this.setBackgroundColor();
        }

        public function setBackgroundColor() : void
        {
            var _loc1_:String = BG_POSTFIX;
            if(this._owningTeam == ENEMY && this._vmManager.isColorBlind)
            {
                _loc1_ = BG_COLORBLIND_POSTFIX;
            }
            this.bg.gotoAndStop(this._owningTeam + _loc1_);
        }

        public function setActiveState(param1:int) : void
        {
            if(param1 == HOVER_STATE)
            {
                this.sectorBaseHover.visible = true;
                this.setHoverColor();
            }
            else
            {
                this.sectorBaseHover.visible = false;
            }
        }

        public function setHoverColor() : void
        {
            var _loc1_:String = HOVER_POSTFIX;
            if(this._vmManager.isColorBlind && this._owningTeam == ENEMY)
            {
                _loc1_ = HOVER_COLORBLIND_POSTFIX;
            }
            this.sectorBaseHover.gotoAndStop(this._owningTeam + _loc1_);
        }
    }
}
