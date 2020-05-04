package net.wg.gui.battle.views.vehicleMarkers
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleEngineerEffectMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
    import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
    import flash.events.Event;

    public class VehicleStatusContainerMarker extends BattleUIComponent
    {

        private static const BASE_HEIGHT:int = 55;

        private static const STUN:int = 0;

        private static const INSPIRING:int = 1;

        private static const INSPIRED:int = 2;

        private static const ENGINEER:int = 3;

        private static const STUN_PRIORITY:int = 10;

        private static const INSPIRING_PRIORITY:int = 20;

        private static const INSPIRED_PRIORITY:int = 0;

        private static const ENGINEER_PRIORITY:int = 30;

        public var baseEngineerMarker:VehicleEngineerEffectMarker = null;

        public var inspireMarker:VehicleInspireMarker = null;

        public var inspireTargetMarker:VehicleInspireTargetMarker = null;

        public var stunMarker:VehicleStunMarker = null;

        private var _statusEffectMarkers:Vector.<VehicleAnimatedStatusBaseMarker> = null;

        private var _activeEffectID:int = -1;

        private var _oneShotOngoing:Boolean = false;

        private var _oneShotStatusID:int = -1;

        private var _statusPriorities:Vector.<int> = null;

        public function VehicleStatusContainerMarker()
        {
            super();
            this._statusEffectMarkers = new <VehicleAnimatedStatusBaseMarker>[this.stunMarker,this.inspireMarker,this.inspireTargetMarker,this.baseEngineerMarker];
            this.stunMarker.setStatusID(STUN);
            this.inspireMarker.setStatusID(INSPIRING);
            this.inspireTargetMarker.setStatusID(INSPIRED);
            this.baseEngineerMarker.setStatusID(ENGINEER);
            this.setStatusPriorities();
        }

        override protected function onDispose() : void
        {
            this.stunMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.baseEngineerMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.inspireMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.inspireTargetMarker.removeEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.baseEngineerMarker.dispose();
            this.baseEngineerMarker = null;
            this.inspireMarker.dispose();
            this.inspireMarker = null;
            this.stunMarker.dispose();
            this.stunMarker = null;
            this.inspireTargetMarker.dispose();
            this.inspireTargetMarker = null;
            this._statusPriorities.splice(0,this._statusPriorities.length);
            this._statusPriorities = null;
            this._statusEffectMarkers.slice(0,this._statusEffectMarkers.length);
            this._statusEffectMarkers = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.stunMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.baseEngineerMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.inspireMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.inspireTargetMarker.addEventListener(StatusAnimationEvent.EVENT_HIDDEN,this.onStatusAnimationEventHiddenHandler);
            this.stunMarker.setupFrameEvents();
            this.baseEngineerMarker.setupFrameEvents();
            this.inspireMarker.setupFrameEvents();
            this.inspireTargetMarker.setupFrameEvents();
        }

        public function hideMarker(param1:int, param2:int, param3:Boolean) : void
        {
            var _loc4_:VehicleAnimatedStatusBaseMarker = null;
            this._activeEffectID = param2;
            if(param1 > -1)
            {
                this._statusEffectMarkers[param1].hideEffectTimer(param3);
            }
            if(param2 > -1)
            {
                this._statusEffectMarkers[param2].setVisibility(true);
            }
            else
            {
                for each(_loc4_ in this._statusEffectMarkers)
                {
                    _loc4_.setVisibility(false);
                }
            }
        }

        public function isVisible() : Boolean
        {
            return this._activeEffectID == -1?false:this._statusEffectMarkers[this._activeEffectID].isVisible();
        }

        public function setEffectColor(param1:String, param2:uint) : void
        {
            this.stunMarker.setEffectColor(param1,param2);
            this.baseEngineerMarker.setEffectColor(param1,param2);
            this.inspireMarker.setEffectColor(param1,param2);
            this.inspireTargetMarker.setEffectColor(param1,param2);
        }

        public function setSecondString(param1:String) : void
        {
            this.stunMarker.setSecondString(param1);
            this.inspireMarker.setSecondString(param1);
        }

        public function setStatusPriorities() : void
        {
            this._statusPriorities = new Vector.<int>(0);
            this._statusPriorities[STUN] = STUN_PRIORITY;
            this._statusPriorities[INSPIRING] = INSPIRING_PRIORITY;
            this._statusPriorities[INSPIRED] = INSPIRED_PRIORITY;
            this._statusPriorities[ENGINEER] = ENGINEER_PRIORITY;
        }

        public function showMarker(param1:int, param2:Boolean, param3:Number, param4:int, param5:Boolean = true) : void
        {
            if(this._activeEffectID != -1 && this._activeEffectID != param1)
            {
                this._statusEffectMarkers[this._activeEffectID].setVisibility(false);
                if(param1 != param4)
                {
                    if(this._oneShotOngoing && this._statusPriorities[param1] > this._statusPriorities[this._oneShotStatusID])
                    {
                        this._statusEffectMarkers[this._oneShotStatusID].resetMarkerStates();
                    }
                    this._statusEffectMarkers[param1].showOneshotAnimation(param3,param2,param5);
                    this._oneShotOngoing = true;
                    this._oneShotStatusID = param1;
                    this._activeEffectID = param4;
                }
                else
                {
                    this._statusEffectMarkers[param1].showEffectTimer(param3,param5,param2);
                    this._activeEffectID = param4;
                }
            }
            else
            {
                this._statusEffectMarkers[param1].showEffectTimer(param3,param5,param2);
                this._activeEffectID = param4;
            }
        }

        public function updateEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void
        {
            this._statusEffectMarkers[param1].updateEffectTimer(param2,this._activeEffectID == param1,param3);
        }

        public function clearEffectTimer(param1:int) : void
        {
            this._statusEffectMarkers[param1].clearTimer();
        }

        override public function get height() : Number
        {
            return BASE_HEIGHT;
        }

        private function onStatusAnimationEventHiddenHandler(param1:StatusAnimationEvent) : void
        {
            if(param1.isOneShotAnimation)
            {
                this._oneShotOngoing = false;
                this._oneShotStatusID = -1;
            }
            if(this._activeEffectID > 0)
            {
                this._statusEffectMarkers[this._activeEffectID].setVisibility(true);
            }
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
