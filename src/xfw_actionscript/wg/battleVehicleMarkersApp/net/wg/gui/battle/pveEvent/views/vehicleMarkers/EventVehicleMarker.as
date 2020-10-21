package net.wg.gui.battle.pveEvent.views.vehicleMarkers
{
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
    import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;

    public class EventVehicleMarker extends VehicleMarker
    {

        private static const HIDE_DURATION:int = 300;

        private static const HIDE_DELAY:int = 2000;

        private static const MESSAGE_OFFSET:int = 10;

        private static const ROLE_OFFSET:int = 15;

        private static const VISIBLE_ALPHA:Number = 1;

        private static const INVISIBLE_ALPHA:Number = 0.0;

        private static const SOULS_VALUE1:int = 10;

        private static const SOULS_VALUE2:int = 100;

        private static const SOULS_LABEL_1DIGIT:String = "soul1Digit";

        private static const SOULS_LABEL_2DIGIT:String = "soul2Digit";

        private static const SOULS_LABEL_3DIGIT:String = "soul3Digit";

        private static const SOUL_1OFFSET:int = 5;

        private static const SOUL_2OFFSET:int = 8;

        private static const SOUL_3OFFSET:int = 12;

        public var message:EventVehicleMarkerMessage = null;

        public var roleMark:MovieClip = null;

        public var soulMark:EventVehicleMarkerSouls = null;

        private var _count:int = 0;

        private var _hideTween:Tween;

        public function EventVehicleMarker()
        {
            super();
            this.message.visible = false;
            this.roleMark.visible = false;
            this.soulMark.visible = false;
        }

        public function showActionMessage(param1:String, param2:Boolean) : void
        {
            this.clearTween();
            this.message.setText(param1,param2);
            this.message.alpha = VISIBLE_ALPHA;
            this.message.visible = true;
            this._hideTween = new Tween(HIDE_DURATION,this.message,{"alpha":INVISIBLE_ALPHA},{
                "delay":HIDE_DELAY,
                "onComplete":this.onFadeOutTweenComplete
            });
        }

        public function showEnemyRoleMarker(param1:String) : void
        {
            this.roleMark.visible = true;
            marker.visible = false;
            vmManager.drawWithCenterAlign(param1,this.roleMark.graphics,true,true);
        }

        public function setBossMode() : void
        {
            var _loc2_:String = null;
            var _loc1_:VehicleMarkerSettings = new VehicleMarkerSettings();
            for(_loc2_ in super.markerSettings)
            {
                _loc1_[_loc2_] = super.markerSettings[_loc2_];
            }
            _loc1_[MARKER + BASE + HEALTH_BAR] = 0;
            _loc1_[MARKER + BASE + HEALTH_LBL] = HPDisplayMode.HIDDEN;
            _loc1_[MARKER + ALT + HEALTH_BAR] = 0;
            _loc1_[MARKER + ALT + HEALTH_LBL] = HPDisplayMode.HIDDEN;
            _loc1_[MARKER + ALT + LEVEL] = 0;
            _loc1_[MARKER + BASE + LEVEL] = 0;
            _loc1_[MARKER + ALT + V_NAME_LBL] = 0;
            _loc1_[MARKER + BASE + V_NAME_LBL] = 0;
            _loc1_[MARKER + ALT + ICON] = 0;
            _loc1_[MARKER + BASE + ICON] = 0;
            super.markerSettings = _loc1_;
            updateMarkerSettings();
        }

        private function setSoulMarkOffset() : void
        {
            var _loc1_:* = 0;
            if(this._count < SOULS_VALUE1)
            {
                _loc1_ = SOUL_1OFFSET;
            }
            else if(this._count < SOULS_VALUE2)
            {
                _loc1_ = SOUL_2OFFSET;
            }
            else
            {
                _loc1_ = SOUL_3OFFSET;
            }
            this.soulMark.y = marker.y + _loc1_;
        }

        public function showSoulMark(param1:int) : void
        {
            this.soulMark.setText(param1.toString());
            this.soulMark.visible = param1 > 0;
            marker.visible = !this.soulMark.visible;
            if(param1 < SOULS_VALUE1)
            {
                this.soulMark.setSoulIcon(SOULS_LABEL_1DIGIT);
            }
            else if(param1 < SOULS_VALUE2)
            {
                this.soulMark.setSoulIcon(SOULS_LABEL_2DIGIT);
            }
            else
            {
                this.soulMark.setSoulIcon(SOULS_LABEL_3DIGIT);
            }
            this._count = param1;
            this.setSoulMarkOffset();
        }

        override protected function onDispose() : void
        {
            this.message.dispose();
            this.message = null;
            this.roleMark = null;
            this.soulMark.dispose();
            this.soulMark = null;
            this.clearTween();
            super.onDispose();
        }

        override protected function layoutExtended(param1:int) : void
        {
            super.layoutExtended(param1);
            this.roleMark.y = marker.y + ROLE_OFFSET;
            this.message.y = param1 - MESSAGE_OFFSET;
            this.setSoulMarkOffset();
        }

        private function onFadeOutTweenComplete() : void
        {
            this.message.visible = false;
        }

        private function clearTween() : void
        {
            if(this._hideTween != null)
            {
                this._hideTween.paused = true;
                this._hideTween.dispose();
                this._hideTween = null;
            }
        }

        override public function setIsStickyAndOutOfScreen(param1:Boolean) : void
        {
            super.setIsStickyAndOutOfScreen(param1);
            marker.visible = marker.visible && !this.soulMark.visible && !this.roleMark.visible;
        }
    }
}
