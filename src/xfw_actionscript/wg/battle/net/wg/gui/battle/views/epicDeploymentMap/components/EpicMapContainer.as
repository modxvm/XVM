package net.wg.gui.battle.views.epicDeploymentMap.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
    import net.wg.data.constants.Values;

    public class EpicMapContainer extends MovieClip implements IDisposable
    {

        public static const NORMAL_DEPLOY_STATE:String = "normal_invisible";

        public static const DISABLED_DEPLOY_STATE:String = "disabled";

        public static const AVAILABLE_DEPLOY_STATE:String = "available";

        public static const SELECTED_DEPLOY_STATE:String = "selected";

        public static const HIGHLIGHT_DEPLOY_STATE:String = "highlight";

        public static const AVAILABLE_DEPLOY_HOVER_STATE:String = "available_over";

        public var mapHit:MovieClip = null;

        public var mapMask:MovieClip = null;

        public var respawnPointLeft:MovieClip = null;

        public var respawnPointCenter:MovieClip = null;

        public var respawnPointRight:MovieClip = null;

        public var entriesContainer:EpicDeploymentMapEntriesContainer = null;

        public var laneHighlight1:MovieClip = null;

        public var laneHighlight2:MovieClip = null;

        public var laneHighlight3:MovieClip = null;

        public var laneLocked1Mc:MovieClip = null;

        public var laneLocked2Mc:MovieClip = null;

        public var laneLocked3Mc:MovieClip = null;

        private var _clickAreaSpr:Sprite = null;

        private var _respawnPoints:Vector.<MovieClip> = null;

        private var _laneHighlights:Vector.<MovieClip> = null;

        private var _laneLockedMcs:Vector.<MovieClip> = null;

        private var _laneStates:Vector.<String> = null;

        public function EpicMapContainer()
        {
            super();
            this._clickAreaSpr = new Sprite();
            addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
            this.mapHit.visible = true;
            this._clickAreaSpr.hitArea = this.mapHit;
            this._respawnPoints = new <MovieClip>[this.respawnPointLeft,this.respawnPointCenter,this.respawnPointRight];
            this._laneStates = new <String>[Values.EMPTY_STR,Values.EMPTY_STR,Values.EMPTY_STR];
            this._laneHighlights = new <MovieClip>[this.laneHighlight1,this.laneHighlight2,this.laneHighlight3];
            this._laneLockedMcs = new <MovieClip>[this.laneLocked1Mc,this.laneLocked2Mc,this.laneLocked3Mc];
            this.respawnPointLeft.visible = this.respawnPointCenter.visible = this.respawnPointRight.visible = false;
            this.respawnPointLeft.mouseEnabled = this.respawnPointCenter.mouseEnabled = this.respawnPointRight.mouseEnabled = false;
            this.respawnPointLeft.mouseChildren = this.respawnPointCenter.mouseChildren = this.respawnPointRight.mouseChildren = false;
            this.entriesContainer.mouseEnabled = this.entriesContainer.mouseChildren = false;
            this.respawnPointLeft.respawnLane.gotoAndStop(1);
            this.respawnPointCenter.respawnLane.gotoAndStop(2);
            this.respawnPointRight.respawnLane.gotoAndStop(3);
            var _loc1_:int = this._laneLockedMcs.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._laneLockedMcs[_loc2_].visible = false;
                _loc2_++;
            }
        }

        public final function dispose() : void
        {
            this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this._clickAreaSpr = null;
            this._laneStates.splice(0,this._laneStates.length);
            this._laneStates = null;
            this._laneLockedMcs.splice(0,this._laneLockedMcs.length);
            this._laneLockedMcs = null;
            this._laneHighlights.splice(0,this._laneHighlights.length);
            this._laneHighlights = null;
            this._respawnPoints.splice(0,this._respawnPoints.length);
            this._respawnPoints = null;
            this.mapHit = null;
            this.mapMask = null;
            this.respawnPointLeft.stop();
            this.respawnPointLeft = null;
            this.respawnPointCenter.stop();
            this.respawnPointCenter = null;
            this.respawnPointRight.stop();
            this.respawnPointRight = null;
            this.entriesContainer.dispose();
            this.entriesContainer = null;
            this.laneHighlight1.stop();
            this.laneHighlight1 = null;
            this.laneHighlight2.stop();
            this.laneHighlight2 = null;
            this.laneHighlight3.stop();
            this.laneHighlight3 = null;
            this.laneLocked1Mc = null;
            this.laneLocked2Mc = null;
            this.laneLocked3Mc = null;
        }

        public function initializeMouseHandler() : void
        {
            this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
        }

        public function setLaneHighlightState(param1:int, param2:String) : void
        {
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            if(param1 < 0)
            {
                return;
            }
            if(param2 == SELECTED_DEPLOY_STATE || param2 == HIGHLIGHT_DEPLOY_STATE)
            {
                _loc3_ = 1 << param1 & 3;
                _loc4_ = 1 << _loc3_ & 3;
                if(this._laneStates[_loc3_] == SELECTED_DEPLOY_STATE || this._laneStates[_loc3_] == HIGHLIGHT_DEPLOY_STATE)
                {
                    this._laneStates[_loc3_] = NORMAL_DEPLOY_STATE;
                    this._laneHighlights[_loc3_].gotoAndStop(NORMAL_DEPLOY_STATE);
                }
                if(this._laneStates[_loc4_] == SELECTED_DEPLOY_STATE || this._laneStates[_loc4_] == HIGHLIGHT_DEPLOY_STATE)
                {
                    this._laneStates[_loc4_] = NORMAL_DEPLOY_STATE;
                    this._laneHighlights[_loc4_].gotoAndStop(NORMAL_DEPLOY_STATE);
                }
            }
            this._laneStates[param1] = param2;
            this._laneHighlights[param1].gotoAndStop(param2);
        }

        public function setLockedLaneVisibility(param1:int, param2:Boolean, param3:String = "") : void
        {
            if(this._laneLockedMcs[param1].visible == param2)
            {
                return;
            }
            this._laneLockedMcs[param1].visible = param2;
            this._laneLockedMcs[param1].lockedTF.text = param3;
        }

        public function setRespawnPointState(param1:int, param2:String, param3:Boolean) : void
        {
            var _loc4_:MovieClip = this._respawnPoints[param1];
            _loc4_.visible = param3;
            if(_loc4_.currentLabel != param2)
            {
                this._respawnPoints[param1].gotoAndPlay(param2);
            }
        }

        public function updateRespawnPointPosition(param1:int, param2:Point, param3:int, param4:int) : void
        {
            this._respawnPoints[param1].x = param2.x * param3;
            this._respawnPoints[param1].y = (1 - param2.y) * param4;
        }

        public function updateVisiblity(param1:Boolean) : void
        {
            var _loc4_:MovieClip = null;
            var _loc2_:int = this._laneHighlights.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._laneHighlights[_loc3_].visible = param1;
                _loc4_ = this._respawnPoints[_loc3_];
                _loc4_.visible = param1;
                _loc3_++;
            }
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
            {
                if(this.mapHit.mouseX < 0 || this.mapHit.mouseY < 0 || this.mapHit.mouseX > this.width || this.mapHit.mouseY > this.height)
                {
                    return;
                }
                dispatchEvent(new EpicDeploymentMapEvent(EpicDeploymentMapEvent.MAP_CLICKED,this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON));
            }
        }
    }
}
