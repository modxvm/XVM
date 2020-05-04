package net.wg.gui.components.containers
{
    import flash.text.TextField;
    import flash.display.Bitmap;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldType;
    import flash.display.Sprite;

    public class GFWrapper extends BaseContainerWrapper
    {

        public static const GF_WRAPPER_NAME:String = "GFWrapper";

        private static const BITMAP_NAME:String = "gamefaceBitmap";

        private static const TF_NAME:String = "gfInputFixTF";

        private static const IME_TF_NAME:String = "gfimeTF";

        private static const HIT_AREA_SPRITE:String = "hitAreaSprite";

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
            this.addHitArea();
        }

        public static function createWrapper() : GFWrapper
        {
            return new GFWrapper();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this.gamefaceBitmap != null)
                {
                    this.gamefaceBitmap.width = width;
                    this.gamefaceBitmap.height = height;
                }
                if(this.inputFixTF != null)
                {
                    this.inputFixTF.width = width;
                    this.inputFixTF.height = height;
                }
            }
            if(hitArea != null)
            {
                hitArea.width = width;
                hitArea.height = height;
            }
        }

        override protected function onDispose() : void
        {
            this.gamefaceBitmap = null;
            this.inputFixTF = null;
            this.imeTF = null;
            removeChild(hitArea);
            hitArea = null;
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

        private function addHitArea() : void
        {
            var _loc1_:Sprite = new Sprite();
            _loc1_.name = HIT_AREA_SPRITE;
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(16711680,0);
            _loc1_.graphics.drawRect(0,0,1,1);
            _loc1_.graphics.endFill();
            addChild(_loc1_);
            hitArea = _loc1_;
        }
    }
}
