package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    
    public class IndicatorLabels extends MovieClip implements IDisposable
    {
        
        public function IndicatorLabels()
        {
            super();
        }
        
        public var hpValue:TextField;
        
        public var defResValue:TextField;
        
        public function dispose() : void
        {
            this.hpValue = null;
            this.defResValue = null;
        }
    }
}
