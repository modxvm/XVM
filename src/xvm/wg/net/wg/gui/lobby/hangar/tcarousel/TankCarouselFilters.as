package net.wg.gui.lobby.hangar.tcarousel 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class TankCarouselFilters extends scaleform.clik.core.UIComponent
    {
        public function TankCarouselFilters()
        {
            super();
            return;
        }

        public function close():void
        {
            if (this.nationFilter && this.nationFilter.isOpen()) 
                this.nationFilter.close();
            if (this.tankFilter && this.tankFilter.isOpen()) 
                this.tankFilter.close();
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
                return;
            this.nationFilter.enabled = arg1;
            this.tankFilter.enabled = arg1;
            this.checkBoxToMain.enabled = arg1;
            super.enabled = arg1;
            return;
        }

        public static const FILTER_ALL_TYPES:String="none";

        public static const FILTER_ALL_NATION:Number=-1;

        public static const FILTER_USSR:Number=0;

        public static const FILTER_GERMANY:Number=1;

        public static const FILTER_READY:String="ready";

        public var nationFilter:net.wg.gui.components.controls.DropDownImageText;

        public var tankFilter:net.wg.gui.components.controls.DropDownImageText;

        public var checkBoxToMain:net.wg.gui.components.controls.CheckBox;
    }
}
