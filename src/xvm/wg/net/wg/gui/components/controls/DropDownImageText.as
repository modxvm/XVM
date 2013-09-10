package net.wg.gui.components.controls 
{
    public class DropDownImageText extends net.wg.gui.components.controls.DropdownMenu
    {
        public function DropDownImageText()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function populateText(arg1:Object):void
        {
            super.populateText(arg1);
            this.icon.visible = true;
            if (arg1) 
                this.icon.source = arg1.icon;
            return;
        }

        public override function toString():String
        {
            return "[WG DropDownImageText " + name + "]";
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
