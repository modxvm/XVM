package net.wg.gui.lobby.profile.components 
{
    import flash.text.*;
    
    public class CenteredLineIconText extends net.wg.gui.lobby.profile.components.LineDescrIconText
    {
        public function CenteredLineIconText()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            descriptionTextField.autoSize = flash.text.TextFieldAutoSize.CENTER;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (this.isLayoutChanged) 
            {
                this.isLayoutChanged = false;
                loc1 = Math.max(textComponent.textField.width, textComponent.background.width);
                textComponent.textField.x = loc1 - textComponent.textField.width >> 1;
                textComponent.background.x = loc1 - textComponent.background.width >> 1;
                loc1 = Math.max(textComponent.width, descriptionTextField.width);
                textComponent.x = loc1 - textComponent.width >> 1;
                descriptionTextField.x = loc1 - descriptionTextField.width >> 1;
            }
            return;
        }

        public override function set description(arg1:String):void
        {
            super.description = arg1;
            this.isLayoutChanged = true;
            invalidate();
            return;
        }

        public override function set text(arg1:String):void
        {
            super.text = arg1;
            this.isLayoutChanged = true;
            invalidate();
            return;
        }

        public override function set iconSource(arg1:String):void
        {
            return;
        }

        internal var isLayoutChanged:Boolean;
    }
}
