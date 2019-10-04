package net.wg.gui.bootcamp.introVideoPage.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class IntroPageContainer extends Sprite implements IDisposable
    {

        private static const DASHLINE_WIDTH:Number = 400;

        private static const LOGO_CENTER_OFFSET:Number = -250;

        private static const INTRO_IMAGE_WIDTH:int = 3439;

        private static const INTRO_IMAGE_HEIGHT:int = 1377;

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
            var _loc3_:Number = param2 / INTRO_IMAGE_HEIGHT;
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

        public function get logoHeader() : String
        {
            return this.introLogo.logoHeader;
        }

        public function set logoHeader(param1:String) : void
        {
            this.introLogo.logoHeader = param1;
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
