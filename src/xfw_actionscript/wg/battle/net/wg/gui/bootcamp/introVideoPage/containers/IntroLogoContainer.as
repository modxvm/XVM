package net.wg.gui.bootcamp.introVideoPage.containers
{
    import scaleform.clik.core.UIComponent;
    import flash.display.Sprite;
    import net.wg.gui.components.common.BaseLogoView;
    import flash.text.TextField;

    public class IntroLogoContainer extends UIComponent
    {

        public var dashline:Sprite;

        public var wotLogo:BaseLogoView = null;

        public var txtDescription:TextField;

        public var txtReferral:TextField;

        public function IntroLogoContainer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:String = App.globalVarsMgr.getLocaleOverrideS();
            if(_loc1_)
            {
                this.wotLogo.setLocale(_loc1_);
            }
        }

        override protected function onDispose() : void
        {
            this.txtDescription = null;
            this.txtReferral = null;
            this.dashline = null;
            if(this.wotLogo != null)
            {
                this.wotLogo.dispose();
                this.wotLogo = null;
            }
            super.onDispose();
        }

        public function setReferralVisibility(param1:Boolean = false) : void
        {
            this.dashline.visible = param1;
            this.txtReferral.visible = param1;
        }

        public function get referralDescription() : String
        {
            return this.txtReferral.text;
        }

        public function set referralDescription(param1:String) : void
        {
            this.txtReferral.text = param1;
        }

        public function get logoDescription() : String
        {
            return this.txtDescription.text;
        }

        public function set logoDescription(param1:String) : void
        {
            this.txtDescription.text = param1;
        }

        public function set dashLength(param1:Number) : void
        {
            this.dashline.x = Math.ceil(this.dashline.width >> 1) * -1;
        }
    }
}
