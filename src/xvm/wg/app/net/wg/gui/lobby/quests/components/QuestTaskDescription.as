package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class QuestTaskDescription extends UIComponent
    {
        
        public function QuestTaskDescription()
        {
            super();
            this.textField.wordWrap = true;
        }
        
        public var textField:TextField = null;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.textField.height = this.textField.textHeight + 5;
                _height = this.textField.y + this.textField.height;
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
    }
}
