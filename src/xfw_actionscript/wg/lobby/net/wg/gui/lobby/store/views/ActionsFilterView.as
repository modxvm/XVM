package net.wg.gui.lobby.store.views
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.CheckBox;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class ActionsFilterView extends UIComponentEx
    {

        public var textField:TextField = null;

        public var checkBox:CheckBox = null;

        public var background:MovieClip = null;

        public var hit:MovieClip = null;

        public function ActionsFilterView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.textField.mouseEnabled = false;
            this.background.mouseEnabled = false;
            this.background.mouseChildren = false;
            buttonMode = true;
            this.checkBox.validateNow();
            this.checkBox.hitArea = this.hit;
            this.checkBox.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
        }

        override protected function onDispose() : void
        {
            this.checkBox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
            this.checkBox.dispose();
            this.checkBox = null;
            this.background = null;
            this.textField = null;
            this.hit = null;
            super.onDispose();
        }

        public function get selected() : Boolean
        {
            return this.checkBox.selected;
        }

        public function set selected(param1:Boolean) : void
        {
            this.checkBox.selected = param1;
        }

        public function set text(param1:String) : void
        {
            this.textField.htmlText = param1;
        }

        private function onCheckBoxSelectHandler(param1:Event) : void
        {
            dispatchEvent(param1);
        }
    }
}
