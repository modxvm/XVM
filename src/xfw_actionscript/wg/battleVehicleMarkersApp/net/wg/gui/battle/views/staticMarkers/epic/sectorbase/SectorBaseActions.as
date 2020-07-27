package net.wg.gui.battle.views.staticMarkers.epic.sectorbase
{
    import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Point;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
    import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;

    public class SectorBaseActions extends BaseActionMarker implements IDisposable
    {

        private static const ARROW_POSITION:Point = new Point(0,0);

        private static const REPLY_POSITION:Point = new Point(25,-1);

        private static const DISTANCE_POSITION:Point = new Point(-43,15);

        private static const ATTACK:String = "attack";

        private static const ATTACK_COLORBLIND:String = "attackColorBlind";

        private static const DEFEND:String = "defend";

        private static const ENEMY:String = "enemy";

        private static const NEUTRAL:String = "neutral";

        public var highlightAnimationAttackBase:MovieClip = null;

        public var attackBaseMarker:MovieClip = null;

        public var hoverShadowAttack:MovieClip = null;

        public var clickAnimation:MovieClip = null;

        public var highlightAnimationDefendBase:MovieClip = null;

        public var defendBaseMarker:MovieClip = null;

        public var hoverShadowDefend:MovieClip = null;

        private var _count:int = 0;

        private var _showHighlight:Boolean = true;

        private var _vmManager:VehicleMarkersManager = null;

        private var _baseType:String = "";

        public function SectorBaseActions()
        {
            super();
            this.deactivateAttackAndDefendStates();
            this._vmManager = VehicleMarkersManager.getInstance();
            this.clickAnimation.visible = false;
        }

        override protected function get getReplyPosition() : Point
        {
            return REPLY_POSITION;
        }

        override protected function get getArrowPosition() : Point
        {
            return ARROW_POSITION;
        }

        override protected function get getDistanceToMarkerPosition() : Point
        {
            return DISTANCE_POSITION;
        }

        public function deactivateAttackAndDefendStates() : void
        {
            if(this.attackBaseMarker != null)
            {
                this.attackBaseMarker.visible = false;
            }
            if(this.defendBaseMarker != null)
            {
                this.defendBaseMarker.visible = false;
            }
            if(this.hoverShadowDefend != null)
            {
                this.hoverShadowDefend.visible = false;
            }
            if(this.hoverShadowAttack != null)
            {
                this.hoverShadowAttack.visible = false;
            }
            if(this.highlightAnimationDefendBase != null)
            {
                this.highlightAnimationDefendBase.visible = false;
            }
            if(this.highlightAnimationAttackBase != null)
            {
                this.highlightAnimationAttackBase.visible = false;
            }
        }

        override protected function onDispose() : void
        {
            if(this.highlightAnimationAttackBase != null)
            {
                this.highlightAnimationAttackBase.stop();
                this.highlightAnimationAttackBase = null;
            }
            this.attackBaseMarker = null;
            this.hoverShadowAttack = null;
            if(this.highlightAnimationDefendBase != null)
            {
                this.highlightAnimationDefendBase.stop();
                this.highlightAnimationDefendBase = null;
            }
            this.defendBaseMarker = null;
            this.hoverShadowDefend = null;
            this.clickAnimation = null;
            super.onDispose();
        }

        public function triggerClickAnimation() : void
        {
            this.clickAnimation.visible = true;
            this.clickAnimation.play();
        }

        public function initializeBase(param1:String) : void
        {
            this._baseType = param1;
            this.setBaseColor();
            if(this.attackBaseMarker != null)
            {
                this.attackBaseMarker.visible = false;
            }
            if(this.defendBaseMarker != null)
            {
                this.defendBaseMarker.visible = false;
            }
        }

        public function setBaseColor() : void
        {
            if(this._baseType == ENEMY || this._baseType == NEUTRAL)
            {
                if(this._vmManager.isColorBlind)
                {
                    gotoAndStop(ATTACK_COLORBLIND);
                }
                else
                {
                    gotoAndStop(ATTACK);
                }
            }
            else
            {
                gotoAndStop(DEFEND);
            }
        }

        public function activateHover(param1:Boolean, param2:String) : void
        {
            if(param2 == ENEMY || param2 == NEUTRAL)
            {
                this.hoverShadowAttack.visible = param1;
            }
            else
            {
                this.hoverShadowDefend.visible = param1;
            }
        }

        public function setActiveState(param1:int, param2:String) : void
        {
            if(param1 == ActionMarkerStates.NEUTRAL)
            {
                this.deactivateAttackAndDefendStates();
                this._showHighlight = true;
                return;
            }
            if(param2 == ENEMY || param2 == NEUTRAL)
            {
                if(this._vmManager.isColorBlind)
                {
                    this.setStateForBase(param1,ATTACK_COLORBLIND,this.attackBaseMarker,this.highlightAnimationAttackBase);
                }
                else
                {
                    this.setStateForBase(param1,ATTACK,this.attackBaseMarker,this.highlightAnimationAttackBase);
                }
            }
            else
            {
                this.setStateForBase(param1,DEFEND,this.defendBaseMarker,this.highlightAnimationDefendBase);
            }
        }

        private function setStateForBase(param1:int, param2:String, param3:MovieClip, param4:MovieClip) : void
        {
            gotoAndStop(param2);
            param3.visible = true;
            param4.visible = this._count == 0;
            if(this._count == 0 && this._showHighlight)
            {
                param4.play();
            }
            else if(this._count >= 1)
            {
                this._showHighlight = false;
                param4.stop();
            }
            param3.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param1]);
        }

        override public function setReplyCount(param1:int) : void
        {
            this._count = param1;
            super.setReplyCount(param1);
        }
    }
}
