package net.wg.gui.components.dogtag
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.Image;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;

    public class DogtagDownPlate extends UIComponentEx
    {

        private static const SPACE_GAP:int = 5;

        private static const ENGRAVING_STAT_VALUE_CONTAINER_OFFSET_Y:int = 70;

        private static const BRACKET_LEFT:String = "[";

        private static const BRACKET_RIGHT:String = "]";

        private static const SPACE:String = " ";

        private static const DEFAULT_BACKGROUND:String = "background_66_0";

        public var engravingStatName:TextField = null;

        private var _characters:Array;

        private var _engravingStatValueContainer:Sprite;

        private var _plate:Image = null;

        public function DogtagDownPlate()
        {
            this._characters = [];
            super();
            this._plate = new Image();
        }

        override protected function configUI() : void
        {
            addChildAt(this._plate,0);
            this._engravingStatValueContainer = new Sprite();
            this._engravingStatValueContainer.y = ENGRAVING_STAT_VALUE_CONTAINER_OFFSET_Y;
            addChild(this._engravingStatValueContainer);
            super.configUI();
        }

        public function setDogTagInfo(param1:String, param2:String) : void
        {
            this._plate.bitmapData = ImageRepository.getInstance().getImageBitmapData(DEFAULT_BACKGROUND);
            this.engravingStatName.text = param1;
            this.buildPhrase(param2);
        }

        private function buildPhrase(param1:String) : void
        {
            var _loc3_:String = null;
            var _loc4_:Image = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:String = null;
            this.removeCharacters();
            var _loc2_:* = 0;
            while(_loc2_ < param1.length)
            {
                _loc3_ = param1.charAt(_loc2_);
                if(_loc3_ == SPACE)
                {
                    this._characters.push(SPACE);
                }
                else
                {
                    _loc4_ = new Image();
                    if(_loc3_ == BRACKET_LEFT)
                    {
                        _loc5_ = param1.indexOf(BRACKET_RIGHT,_loc2_);
                        _loc6_ = _loc5_ - _loc2_ - 1;
                        _loc7_ = param1.substr(_loc2_ + 1,_loc6_);
                        _loc3_ = _loc7_;
                        _loc2_ = _loc2_ + (_loc6_ + 1);
                    }
                    _loc4_.source = RES_ICONS.getDogTagCharacterSmall(_loc3_);
                    this._characters.push(_loc4_);
                }
                _loc2_++;
            }
            _loc4_.addEventListener(Event.CHANGE,this.onSourceLoaded);
        }

        private function onSourceLoaded(param1:Event) : void
        {
            invalidateSize();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:Image = null;
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this._engravingStatValueContainer)
                {
                    _loc1_ = 0;
                    _loc2_ = 0;
                    while(_loc2_ < this._characters.length)
                    {
                        if(this._characters[_loc2_] == SPACE)
                        {
                            _loc1_ = _loc1_ + SPACE_GAP;
                        }
                        else
                        {
                            _loc3_ = this._characters[_loc2_];
                            _loc3_.x = _loc1_;
                            this._engravingStatValueContainer.addChild(_loc3_);
                            _loc1_ = _loc1_ + _loc3_.width;
                        }
                        _loc2_++;
                    }
                    this._engravingStatValueContainer.x = (this.width >> 1) - (this._engravingStatValueContainer.width >> 1);
                }
            }
            super.draw();
        }

        override protected function onDispose() : void
        {
            this._plate.dispose();
            this._plate = null;
            this.removeCharacters();
            this._engravingStatValueContainer = null;
            this._characters = null;
            super.onDispose();
        }

        private function removeCharacters() : void
        {
            var _loc3_:* = undefined;
            var _loc1_:int = this._characters.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = this._characters.pop();
                if(_loc3_ != SPACE)
                {
                    this._engravingStatValueContainer.removeChild(_loc3_);
                    _loc3_.removeEventListener(Event.CHANGE,this.onSourceLoaded);
                    _loc3_.dispose();
                }
                _loc2_++;
            }
        }
    }
}
