package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.advanced.LineDescrIconText;
    import flash.text.TextFieldAutoSize;
    
    public class CenteredLineIconText extends LineDescrIconText
    {
        
        public function CenteredLineIconText()
        {
            super();
        }
        
        private var isLayoutChanged:Boolean;
        
        override protected function configUI() : void
        {
            super.configUI();
            textField.autoSize = TextFieldAutoSize.CENTER;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            super.draw();
            if(this.isLayoutChanged)
            {
                this.isLayoutChanged = false;
                _loc1_ = Math.max(textComponent.textField.width,textComponent.background.width);
                textComponent.textField.x = _loc1_ - textComponent.textField.width >> 1;
                textComponent.background.x = _loc1_ - textComponent.background.width >> 1;
                _loc1_ = Math.max(textComponent.width,textField.width);
                textComponent.x = _loc1_ - textComponent.width >> 1;
                textField.x = _loc1_ - textField.width >> 1;
            }
        }
        
        override public function set description(param1:String) : void
        {
            super.description = param1;
            this.isLayoutChanged = true;
            invalidate();
        }
        
        override public function set text(param1:String) : void
        {
            super.text = param1;
            this.isLayoutChanged = true;
            invalidate();
        }
        
        override public function set iconSource(param1:String) : void
        {
        }
    }
}
