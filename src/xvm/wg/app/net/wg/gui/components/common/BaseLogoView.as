package net.wg.gui.components.common
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.FrameLabel;
    
    public class BaseLogoView extends MovieClip implements IDisposable
    {
        
        public function BaseLogoView()
        {
            this.overrides = [];
            super();
            this.initOverrides();
        }
        
        private var overrides:Array;
        
        public function setLocale(param1:String) : void
        {
            if(this.hasOverride(param1))
            {
                gotoAndStop(param1);
            }
        }
        
        public function hasOverride(param1:String) : Boolean
        {
            var _loc2_:* = !(this.overrides.indexOf(param1) == -1);
            return _loc2_;
        }
        
        private function initOverrides() : void
        {
            var _loc1_:FrameLabel = null;
            for each(_loc1_ in currentLabels)
            {
                this.overrides.push(_loc1_.name);
            }
        }
        
        public function dispose() : void
        {
            this.overrides.splice(0,this.overrides.length);
            this.overrides = null;
        }
    }
}
