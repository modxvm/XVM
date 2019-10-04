package net.wg.gui.battle.views.radialMenu.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class Content extends Sprite implements IDisposable
    {

        public var icons:Icons = null;

        public var titleTF:TextField = null;

        public var keyTF:TextField = null;

        public function Content()
        {
            super();
            TextFieldEx.setNoTranslate(this.keyTF,true);
        }

        public function dispose() : void
        {
            this.icons.dispose();
            this.icons = null;
            this.titleTF = null;
            this.keyTF = null;
        }
    }
}
