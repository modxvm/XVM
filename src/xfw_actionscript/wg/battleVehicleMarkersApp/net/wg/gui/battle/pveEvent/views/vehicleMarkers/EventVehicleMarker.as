package net.wg.gui.battle.pveEvent.views.vehicleMarkers
{
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventVehicleMarker extends VehicleMarker
    {

        private static const HIDE_DURATION:int = 300;

        private static const HIDE_DELAY:int = 2000;

        private static const MESSAGE_OFFSET:int = 10;

        private static const VISIBLE_ALPHA:Number = 1;

        private static const INVISIBLE_ALPHA:Number = 0.0;

        public var message:EventVehicleMarkerMessage = null;

        public var roleMark:MovieClip = null;

        public var behaviorMC:MovieClip = null;

        private var _hideTween:Tween;

        public function EventVehicleMarker()
        {
            super();
            this.message.visible = false;
            this.roleMark.visible = false;
            marker.addChild(this.behaviorMC);
            marker.addChild(this.roleMark);
        }

        override protected function getVNameVisible() : Boolean
        {
            if(StringUtils.isEmpty(model.vType))
            {
                return false;
            }
            return super.getVNameVisible();
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
            marker.vehicleTypeIcon.visible = false;
            vmManager.drawWithCenterAlign(param1,this.roleMark.graphics,true,true);
        }

        public function setEnemyBehavior(param1:String) : void
        {
            if(this.behaviorMC.currentLabels.indexOf(param1) != -1)
            {
                this.behaviorMC.gotoAndStop(param1);
            }
        }

        public function clearStatusTimer(param1:int) : void
        {
            statusContainer.clearEffectTimer(param1);
        }

        override protected function onDispose() : void
        {
            this.message.dispose();
            this.message = null;
            this.roleMark = null;
            this.behaviorMC = null;
            this.clearTween();
            super.onDispose();
        }

        override protected function layoutExtended(param1:int) : void
        {
            super.layoutExtended(param1);
            this.message.y = param1 - MESSAGE_OFFSET;
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
    }
}
