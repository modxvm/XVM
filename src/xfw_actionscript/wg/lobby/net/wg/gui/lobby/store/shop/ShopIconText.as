package net.wg.gui.lobby.store.shop
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class ShopIconText extends Sprite implements IDisposable
    {

        private static const TF_V_SPACE:Number = 4;

        private static const TF_H_SPACE:Number = 3;

        public var textField:TextField = null;

        public var hit:Sprite = null;

        public function ShopIconText()
        {
            super();
            hitArea = this.hit;
        }

        public function dispose() : void
        {
            this.hit = null;
            this.textField = null;
        }

        public function updateText(param1:String) : void
        {
            this.textField.htmlText = param1;
            this.textField.width = this.textField.textWidth + TF_H_SPACE;
            this.textField.height = this.textField.textHeight + TF_V_SPACE;
            if(this.hit)
            {
                this.hit.width = this.textField.x + this.textField.width;
            }
        }
    }
}
