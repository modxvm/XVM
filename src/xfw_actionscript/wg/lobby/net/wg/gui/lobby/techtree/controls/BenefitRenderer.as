package net.wg.gui.lobby.techtree.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IImage;
    import flash.text.TextField;

    public class BenefitRenderer extends Sprite implements IDisposable
    {

        public var icon:IImage = null;

        public var labelTF:TextField = null;

        public function BenefitRenderer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:String, param2:String) : void
        {
            this.labelTF.htmlText = param2;
            App.utils.commons.updateTextFieldSize(this.labelTF,false,true);
            this.icon.source = param1;
        }

        protected function onDispose() : void
        {
            this.icon = null;
            this.labelTF = null;
        }
    }
}
