package net.wg.gui.battle.components.containers.inject
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.gui.components.containers.GFWrapper;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class GFInjectBattleComponent extends BattleDisplayable
    {

        private var _wrapper:GFWrapper = null;

        public function GFInjectBattleComponent()
        {
            super();
        }

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            if(this._wrapper == null && param1.name == GFWrapper.GF_WRAPPER_NAME)
            {
                this._wrapper = GFWrapper(param1);
                this._wrapper.setSize(initedWidth,initedHeight);
            }
            return super.addChild(param1);
        }

        public function setSize(param1:Number, param2:Number) : void
        {
            if(initedWidth == param1 && initedHeight == param2)
            {
                return;
            }
            this.width = initedWidth = param1;
            this.height = initedHeight = param2;
            this.scaleX = this.scaleY = 1;
            if(this._wrapper != null)
            {
                this._wrapper.setSize(param1,param2);
                this._wrapper.dispatchEvent(new Event(Event.RESIZE));
            }
            invalidateSize();
        }

        override protected function updateVisibility() : void
        {
            super.updateVisibility();
            if(visible)
            {
                invalidateSize();
            }
        }
    }
}
