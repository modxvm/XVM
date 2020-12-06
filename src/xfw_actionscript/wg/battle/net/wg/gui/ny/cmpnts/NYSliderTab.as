package net.wg.gui.ny.cmpnts
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.Image;

    public class NYSliderTab extends SoundButtonEx
    {

        public var imageIdle:Image = null;

        public var imageSelect:Image = null;

        public function NYSliderTab()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.imageIdle.dispose();
            this.imageIdle = null;
            this.imageSelect.dispose();
            this.imageSelect = null;
            super.onDispose();
        }

        override public function set selected(param1:Boolean) : void
        {
            super.selected = param1;
            mouseEnabled = !param1;
        }

        override public function canPlaySound(param1:String) : Boolean
        {
            return false;
        }
    }
}
