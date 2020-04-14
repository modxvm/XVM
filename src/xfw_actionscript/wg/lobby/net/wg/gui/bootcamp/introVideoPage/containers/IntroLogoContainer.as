package net.wg.gui.bootcamp.introVideoPage.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class IntroLogoContainer extends Sprite implements IDisposable
    {

        public var dashline:Sprite;

        public var txtDescription:TextField;

        public var txtReferral:TextField;

        public function IntroLogoContainer()
        {
            super();
        }

        public function set referralDescription(param1:String) : void
        {
            this.txtReferral.text = param1;
        }

        public function get referralDescription() : String
        {
            return this.txtReferral.text;
        }

        public function set logoDescription(param1:String) : void
        {
            this.txtDescription.text = param1;
        }

        public function get logoDescription() : String
        {
            return this.txtDescription.text;
        }

        public function set dashLength(param1:Number) : void
        {
            this.dashline.x = Math.ceil(this.dashline.width >> 1) * -1;
        }

        public function setReferralVisibility(param1:Boolean = false) : void
        {
            this.dashline.visible = param1;
            this.txtReferral.visible = param1;
        }

        public final function dispose() : void
        {
            this.txtDescription = null;
            this.txtReferral = null;
            this.dashline = null;
        }
    }
}
