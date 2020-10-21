package net.wg.gui.lobby.itemsForTokens
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.components.containers.GFWrapper;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import net.wg.gui.components.containers.BaseContainerWrapper;

    public class ItemsForTokens extends AbstractView
    {

        private var _wrapper:GFWrapper = null;

        public function ItemsForTokens()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this._wrapper = null;
            super.onDispose();
        }

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            if(this._wrapper == null && param1.name == GFWrapper.GF_WRAPPER_NAME)
            {
                this._wrapper = GFWrapper(param1);
                this._wrapper.setSize(width,height);
            }
            return super.addChild(param1);
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            if(this._wrapper != null)
            {
                this._wrapper.setSize(param1,param2);
                this._wrapper.dispatchEvent(new Event(Event.RESIZE));
            }
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.setSize(param1,param2);
        }

        public function get wrapper() : BaseContainerWrapper
        {
            return this._wrapper;
        }
    }
}
