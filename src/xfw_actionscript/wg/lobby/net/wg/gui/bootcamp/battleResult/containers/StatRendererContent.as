package net.wg.gui.bootcamp.battleResult.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;

    public class StatRendererContent extends MovieClip implements IDisposable
    {

        public var loader:UILoaderAlt;

        public var textFieldValue:TextField;

        public function StatRendererContent()
        {
            super();
        }

        public function setData(param1:String, param2:String) : void
        {
            this.loader.source = param1;
            this.textFieldValue.text = param2;
        }

        public final function dispose() : void
        {
            this.loader.dispose();
            this.loader = null;
            this.textFieldValue = null;
        }
    }
}
