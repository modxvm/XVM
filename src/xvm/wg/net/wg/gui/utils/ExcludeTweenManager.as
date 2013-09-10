package net.wg.gui.utils 
{
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.motion.*;
    
    public class ExcludeTweenManager extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function ExcludeTweenManager()
        {
            super();
            this.currentTweens = new flash.utils.Dictionary(true);
            return;
        }

        public function registerAndLaunch(arg1:Number, arg2:Object, arg3:Object, arg4:Object):scaleform.clik.motion.Tween
        {
            var loc1:*=null;
            if (this.currentTweens[arg2]) 
            {
                (loc1 = scaleform.clik.motion.Tween(this.currentTweens[arg2])).paused = true;
                this.unregister(loc1);
            }
            loc1 = new scaleform.clik.motion.Tween(arg1, arg2, arg3, arg4);
            this.currentTweens[arg2] = loc1;
            return loc1;
        }

        public function unregister(arg1:scaleform.clik.motion.Tween):void
        {
            if (this.currentTweens && this.currentTweens[arg1.target]) 
                delete this.currentTweens[arg1.target];
            return;
        }

        public function unregisterAll():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.currentTweens;
            for (loc1 in loc4) 
            {
                loc2 = scaleform.clik.motion.Tween(this.currentTweens[loc1]);
                loc2.onComplete = null;
                loc2.onChange = null;
                loc2.paused = true;
                delete this.currentTweens[loc1];
            }
            return;
        }

        public function dispose():void
        {
            this.unregisterAll();
            this.currentTweens = null;
            return;
        }

        internal var currentTweens:flash.utils.Dictionary;
    }
}
