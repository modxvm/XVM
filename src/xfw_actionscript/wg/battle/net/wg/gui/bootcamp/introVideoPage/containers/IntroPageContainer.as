package net.wg.gui.bootcamp.introVideoPage.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class IntroPageContainer extends Sprite implements IDisposable
    {

        private static const DASHLINE_WIDTH:Number = 400;

        private static const LOGO_CENTER_OFFSET:Number = -250;

        public var introLogo:IntroLogoContainer;

        public function IntroPageContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.introLogo.dispose();
            this.introLogo = null;
        }

        public function setSize(param1:int, param2:int) : void
        {
            this.introLogo.x = param1 >> 1;
            this.introLogo.y = (param2 >> 1) + LOGO_CENTER_OFFSET;
            this.introLogo.dashLength = DASHLINE_WIDTH;
        }

        public function get referralDescription() : String
        {
            return this.introLogo.referralDescription;
        }

        public function set referralDescription(param1:String) : void
        {
            this.introLogo.referralDescription = param1;
        }

        public function get logoDescription() : String
        {
            return this.introLogo.logoDescription;
        }

        public function set logoDescription(param1:String) : void
        {
            this.introLogo.logoDescription = param1;
        }

        public function setReferralVisibility(param1:Boolean = false) : void
        {
            this.introLogo.setReferralVisibility(param1);
        }
    }
}
