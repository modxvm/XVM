package net.wg.gui.bootcamp.introVideoPage.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.SoundButtonEx;

    public class LoadingContainer extends MovieClip implements IDisposable
    {

        private static const BUTTON_SPACING:int = 10;

        public var btnSelect:SoundButtonEx;

        public var btnSkip:SoundButtonEx;

        public var gradientBg:MovieClip;

        public function LoadingContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.gradientBg = null;
            this.btnSelect.dispose();
            this.btnSelect = null;
        }

        public function setSize(param1:int, param2:int) : void
        {
            this.gradientBg.width = param1;
            this.gradientBg.x = -this.gradientBg.width >> 1;
        }

        public function get selectButtonVisible() : Boolean
        {
            return this.btnSelect.visible;
        }

        public function set selectButtonVisible(param1:Boolean) : void
        {
            this.btnSelect.visible = param1;
            this.updateButtonSLayout();
        }

        public function get skipButtonVisible() : Boolean
        {
            return this.btnSkip.visible;
        }

        public function set skipButtonVisible(param1:Boolean) : void
        {
            this.btnSkip.visible = param1;
            this.updateButtonSLayout();
        }

        public function get selectLabel() : String
        {
            return this.btnSelect.label;
        }

        public function set selectLabel(param1:String) : void
        {
            this.btnSelect.label = param1;
        }

        public function get skipLabel() : String
        {
            return this.btnSkip.label;
        }

        public function set skipLabel(param1:String) : void
        {
            this.btnSkip.label = param1;
        }

        private function updateButtonSLayout() : void
        {
            if(this.skipButtonVisible)
            {
                this.btnSelect.x = BUTTON_SPACING >> 1;
                this.btnSkip.x = -this.btnSkip.width - (BUTTON_SPACING >> 1);
            }
            else
            {
                this.btnSelect.x = -this.btnSelect.width >> 1;
            }
        }
    }
}
