package net.wg.gui.notification 
{
    import flash.events.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.motion.*;
    
    public class ServiceMessagePopUp extends net.wg.gui.notification.ServiceMessage
    {
        public function ServiceMessagePopUp()
        {
            this.tweenManager = new net.wg.gui.utils.ExcludeTweenManager();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            textField.selectable = false;
            if (!isNaN(this._livingTime)) 
            {
                App.utils.scheduler.scheduleTask(this.startMessageHiding, this._livingTime);
            }
            return;
        }

        internal function startMessageHiding():void
        {
            var loc1:*=null;
            if (isNaN(this._animationSpeed)) 
            {
                dispatchEvent(new flash.events.Event(HIDED));
            }
            else 
            {
                loc1 = this.tweenManager.registerAndLaunch(this._animationSpeed, this, {"alpha":0}, {"onComplete":this.onHideTweenComplete});
                loc1.fastTransform = false;
            }
            return;
        }

        internal function onHideTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.tweenManager.unregister(arg1);
            dispatchEvent(new flash.events.Event(HIDED));
            return;
        }

        public function get livingTime():Number
        {
            return this._livingTime;
        }

        public function set livingTime(arg1:Number):void
        {
            this._livingTime = arg1;
            return;
        }

        public function set animationSpeed(arg1:Number):void
        {
            this._animationSpeed = arg1;
            return;
        }

        public function get animationSpeed():Number
        {
            return this._animationSpeed;
        }

        public override function dispose():void
        {
            App.utils.scheduler.cancelTask(this.startMessageHiding);
            if (this.tweenManager) 
            {
                this.tweenManager.unregisterAll();
                this.tweenManager = null;
            }
            super.dispose();
            return;
        }

        public static const HIDED:String="hided";

        internal var _livingTime:Number=NaN;

        internal var _animationSpeed:Number=NaN;

        internal var tweenManager:net.wg.gui.utils.ExcludeTweenManager;
    }
}
