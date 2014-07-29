package net.wg.gui.cyberSport.controls
{
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import flash.display.MovieClip;
    import flash.events.Event;
    
    public class ButtonDnmIconSlim extends ButtonDnmIcon
    {
        
        public function ButtonDnmIconSlim()
        {
            super();
        }
        
        public var btnBorder:MovieClip;
        
        override protected function completeHandler(param1:Event) : void
        {
            if((loader) && (this.btnBorder.contains(loader)))
            {
                this.btnBorder.removeChild(loader);
            }
            this.btnBorder.addChild(loader);
            loader.scaleX = 1 / scaleX;
            loader.scaleY = 1 / scaleY;
            loader.x = Math.floor((this.btnBorder.width - loader.width) / 2);
            loader.y = Math.floor((this.btnBorder.height - loader.height) / 2);
        }
    }
}
