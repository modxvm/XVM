package net.wg.gui.lobby.vehicleBuyWindow 
{
    import fl.transitions.easing.*;
    import flash.display.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.motion.*;
    
    public class VehicleBuyWindowAnimManager extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function VehicleBuyWindowAnimManager(arg1:net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindow)
        {
            super();
            this.animTarget = arg1;
            return;
        }

        public function launch(arg1:Boolean, arg2:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=NaN;
            if (!this.initialized) 
            {
                this.initialize();
                this.initialized = true;
            }
            if (arg1) 
            {
                loc1 = Math.round((App.appHeight - this.windowOpenedHeight) / 2);
                this.tweenToY(this.animTarget.footerMc, this.footerOpenedY, arg2);
                this.tweenToY(flash.display.MovieClip(this.animTarget.window), loc1, arg2);
                this.tweenToAlpha(this.animTarget.bodyMc, 1, arg2);
                this.tweenToHeight(this.animTarget.window.getBackground(), this.windowOpenedHeight, arg2);
                this.tweenToHeight(this.animTarget.backgroundMc, this.darkBackgroundOpenHeight, arg2);
                this.tweenToHeight(this.animTarget.bodyMaskMc, this.maskOpenHeight, arg2);
            }
            else 
            {
                loc2 = Math.round((App.appHeight - this.windowClosedHeight) / 2);
                this.tweenToY(this.animTarget.footerMc, this.footerClosedY, arg2);
                this.tweenToY(flash.display.MovieClip(this.animTarget.window), loc2, arg2);
                this.tweenToAlpha(this.animTarget.bodyMc, 0, arg2);
                this.tweenToHeight(this.animTarget.window.getBackground(), this.windowClosedHeight, arg2);
                this.tweenToHeight(this.animTarget.backgroundMc, this.darkBackgroundCloseHeight, arg2);
                this.tweenToHeight(this.animTarget.bodyMaskMc, this.maskCloseHeight, arg2);
            }
            return;
        }

        public function dispose():void
        {
            this.animTarget = null;
            if (this.excludeTween) 
            {
                this.excludeTween.dispose();
                this.excludeTween = null;
            }
            return;
        }

        internal function initialize():void
        {
            var loc1:*=this.animTarget.footerMc;
            this.footerOpenedY = loc1.y;
            this.footerClosedY = this.animTarget.bodyMc.y;
            var loc2:*=this.animTarget.window;
            this.darkBackgroundOpenHeight = this.animTarget.backgroundMc.height;
            this.darkBackgroundCloseHeight = this.footerClosedY + loc1.submitBtn.y - this.margin;
            this.windowOpenedHeight = loc2.getBackground().height;
            this.windowClosedHeight = this.footerClosedY + loc1.height + loc2.sourceView.y + (loc2.getBackground().height - loc2.sourceView.y - loc2.sourceView.height);
            this.maskCloseHeight = 1;
            this.maskOpenHeight = this.animTarget.bodyMaskMc.height;
            this.excludeTween = new net.wg.gui.utils.ExcludeTweenManager();
            return;
        }

        internal function tweenToY(arg1:flash.display.MovieClip, arg2:int, arg3:Boolean):void
        {
            var loc1:*=null;
            if (arg3) 
                arg1.y = arg2;
            else 
            {
                (loc1 = {}).y = arg2;
                this.excludeTween.registerAndLaunch(this._duration, arg1, loc1, this.getDefaultTweenSet());
            }
            return;
        }

        internal function tweenToAlpha(arg1:flash.display.MovieClip, arg2:Number, arg3:Boolean):void
        {
            var loc1:*=null;
            if (arg3) 
                arg1.alpha = arg2;
            else 
            {
                (loc1 = {}).alpha = arg2;
                this.excludeTween.registerAndLaunch(this._duration, arg1, loc1, this.getDefaultTweenSet());
            }
            return;
        }

        internal function tweenToHeight(arg1:flash.display.MovieClip, arg2:Number, arg3:Boolean):void
        {
            var loc1:*=null;
            if (arg3) 
                arg1.height = arg2;
            else 
            {
                (loc1 = {}).height = arg2;
                this.excludeTween.registerAndLaunch(this._duration, arg1, loc1, this.getDefaultTweenSet());
            }
            return;
        }

        internal function onTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.excludeTween.unregister(arg1);
            return;
        }

        internal function getDefaultTweenSet():Object
        {
            var loc1:*={};
            loc1.ease = fl.transitions.easing.Strong.easeOut;
            loc1.onComplete = this.onTweenComplete;
            return loc1;
        }

        internal var animTarget:net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindow;

        internal var footerOpenedY:int;

        internal var footerClosedY:int;

        internal var windowClosedHeight:uint;

        internal var windowOpenedHeight:uint;

        internal var darkBackgroundCloseHeight:uint;

        internal var darkBackgroundOpenHeight:uint;

        internal var maskCloseHeight:uint;

        internal var maskOpenHeight:uint;

        internal var _duration:uint=400;

        internal var initialized:Boolean;

        internal var margin:uint=4;

        internal var excludeTween:net.wg.gui.utils.ExcludeTweenManager;
    }
}
