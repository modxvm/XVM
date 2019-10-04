package net.wg.gui.lobby.personalMissions.components.popupComponents
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class FreeSheetTitle extends MovieClip implements IDisposable
    {

        public var titleTf:TextField;

        public function FreeSheetTitle()
        {
            super();
        }

        public final function dispose() : void
        {
            this.titleTf = null;
        }

        public function setTitle(param1:String) : void
        {
            this.titleTf.text = param1;
        }
    }
}
