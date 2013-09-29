package net.wg.gui.components.common 
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class BaseLogoView extends flash.display.MovieClip implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function BaseLogoView()
        {
            this.overrides = [];
            super();
            this.initOverrides();
            return;
        }

        public function setLocale(arg1:String):void
        {
            if (this.hasOverride(arg1)) 
            {
                gotoAndStop(arg1);
            }
            return;
        }

        public function hasOverride(arg1:String):Boolean
        {
            var loc1:*=!(this.overrides.indexOf(arg1) == -1);
            return loc1;
        }

        internal function initOverrides():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=currentLabels;
            for each (loc1 in loc3) 
            {
                this.overrides.push(loc1.name);
            }
            return;
        }

        public function dispose():void
        {
            this.overrides.splice(0, this.overrides.length);
            this.overrides = null;
            return;
        }

        internal var overrides:Array;
    }
}
