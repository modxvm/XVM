package net.wg.gui.lobby.tankman 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class RankElement extends scaleform.clik.core.UIComponent
    {
        public function RankElement()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.icoLoader.dispose();
            return;
        }

        public var icoLoader:net.wg.gui.components.controls.UILoaderAlt;
    }
}
