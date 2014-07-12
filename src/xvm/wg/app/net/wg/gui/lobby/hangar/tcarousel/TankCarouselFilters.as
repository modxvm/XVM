package net.wg.gui.lobby.hangar.tcarousel
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.DropDownImageText;
    import net.wg.gui.components.controls.CheckBox;
    
    public class TankCarouselFilters extends UIComponent
    {
        
        public function TankCarouselFilters() {
            super();
        }
        
        public static var FILTER_ALL_TYPES:String = "none";
        
        public static var FILTER_ALL_NATION:Number = -1;
        
        public static var FILTER_USSR:Number = 0;
        
        public static var FILTER_GERMANY:Number = 1;
        
        public static var FILTER_READY:String = "ready";
        
        public var nationFilter:net.wg.gui.components.controls.DropDownImageText;
        
        public var tankFilter:net.wg.gui.components.controls.DropDownImageText;
        
        public var checkBoxToMain:CheckBox;
        
        override protected function onDispose() : void {
            this.nationFilter.dispose();
            this.nationFilter = null;
            this.tankFilter.dispose();
            this.tankFilter = null;
            this.checkBoxToMain.dispose();
            this.checkBoxToMain = null;
            super.onDispose();
        }
        
        public function close() : void {
            if((this.nationFilter) && (this.nationFilter.isOpen()))
            {
                this.nationFilter.close();
            }
            if((this.tankFilter) && (this.tankFilter.isOpen()))
            {
                this.tankFilter.close();
            }
        }
        
        override public function get enabled() : Boolean {
            return super.enabled;
        }
        
        override public function set enabled(param1:Boolean) : void {
            if(param1 == super.enabled)
            {
                return;
            }
            this.nationFilter.enabled = param1;
            this.tankFilter.enabled = param1;
            this.checkBoxToMain.enabled = param1;
            super.enabled = param1;
        }
    }
}
