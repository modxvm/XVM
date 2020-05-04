package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.DisplayObject;

    public class EventAwardHolder extends UIComponentEx
    {

        public var renderer:EventAwardItemRendererBase;

        public function EventAwardHolder()
        {
            super();
        }

        override protected function onDispose() : void
        {
            stop();
            if(this.renderer != null)
            {
                removeChild(DisplayObject(this.renderer));
                this.renderer.dispose();
                this.renderer = null;
            }
            super.onDispose();
        }

        public function setData(param1:Object) : void
        {
            if(this.renderer != null)
            {
                this.renderer.setData(param1);
            }
        }

        public function setLinkageID(param1:String) : void
        {
            this.renderer = App.utils.classFactory.getComponent(param1,DisplayObject);
            addChild(DisplayObject(this.renderer));
            setSize(this.renderer.width,this.renderer.height);
        }
    }
}
