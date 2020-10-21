package net.wg.gui.lobby.eventStylesTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.display.MovieClip;

    public class AuthorInfoPanel extends Sprite implements IDisposable
    {

        private static const TITLE_Y:int = 33;

        private static const DESCR_Y:int = 65;

        private static const OFFSET:int = 260;

        public var titleTF:TextField = null;

        public var descrTF:TextField = null;

        public var authorImage:MovieClip = null;

        public function AuthorInfoPanel()
        {
            super();
        }

        public function setData(param1:String, param2:String) : void
        {
            this.titleTF.text = param1;
            this.descrTF.text = param2;
        }

        public function set authorVisible(param1:Boolean) : void
        {
            this.authorImage.visible = param1;
            this.titleTF.y = TITLE_Y;
            this.descrTF.y = DESCR_Y;
            if(!this.authorImage.visible)
            {
                this.titleTF.y = this.titleTF.y - OFFSET;
                this.descrTF.y = this.descrTF.y - OFFSET;
            }
        }

        public final function dispose() : void
        {
            this.titleTF = null;
            this.descrTF = null;
            this.authorImage = null;
        }
    }
}
