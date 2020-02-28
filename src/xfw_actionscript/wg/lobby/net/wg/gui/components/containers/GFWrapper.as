package net.wg.gui.components.containers
{
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.text.TextFieldType;

    public class GFWrapper extends BaseContainerWrapper
    {

        public static const GF_WRAPPER_NAME:String = "GFWrapper";

        private static const BITMAP_NAME:String = "gamefaceBitmap";

        private static const TF_NAME:String = "gfInputFixTF";

        private static const IME_TF_NAME:String = "gfimeTF";

        public var inputFixTF:TextField = null;

        public var imeTF:TextField = null;

        public var gamefaceBitmap:Bitmap = null;

        public function GFWrapper()
        {
            super();
            name = GF_WRAPPER_NAME;
            this.addGFBitmap();
            this.addInputFixTF();
            this.addIMETF();
        }

        public static function createWrapper() : GFWrapper
        {
            return new GFWrapper();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            if(this.inputFixTF != null)
            {
                this.inputFixTF.width = param1;
                this.inputFixTF.height = param2;
            }
            if(this.gamefaceBitmap != null)
            {
                this.gamefaceBitmap.width = param1;
                this.gamefaceBitmap.height = param2;
            }
        }

        override protected function onDispose() : void
        {
            this.gamefaceBitmap = null;
            this.inputFixTF = null;
            this.imeTF = null;
            super.onDispose();
        }

        private function addGFBitmap() : void
        {
            this.gamefaceBitmap = new Bitmap();
            this.gamefaceBitmap.name = BITMAP_NAME;
            addChild(this.gamefaceBitmap);
        }

        private function addInputFixTF() : void
        {
            this.inputFixTF = new TextField();
            this.inputFixTF.name = TF_NAME;
            this.inputFixTF.maxChars = 1;
            this.inputFixTF.alpha = 0;
            this.inputFixTF.type = TextFieldType.DYNAMIC;
            this.inputFixTF.selectable = false;
            addChild(this.inputFixTF);
        }

        private function addIMETF() : void
        {
            this.imeTF = new TextField();
            this.imeTF.name = IME_TF_NAME;
            this.imeTF.maxChars = 1;
            this.imeTF.alpha = 0;
            this.imeTF.type = TextFieldType.INPUT;
            this.imeTF.selectable = false;
        }
    }
}
