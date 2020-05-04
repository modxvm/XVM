package net.wg.gui.battle.views.directionIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import scaleform.gfx.TextFieldEx;

    public class BaseValueIndicator extends Sprite implements IDisposable
    {

        public var eventControlPointTF:TextField = null;

        public var greenTF:TextField = null;

        public var redTF:TextField = null;

        public var purpleTF:TextField = null;

        public var yellowTF:TextField = null;

        public var whiteTF:TextField = null;

        private var _currTF:TextField = null;

        private var _value:String = "";

        private var _align:String = "center";

        public function BaseValueIndicator()
        {
            super();
            this.eventControlPointTF.visible = false;
            this.greenTF.visible = false;
            this.redTF.visible = false;
            this.purpleTF.visible = false;
            this.yellowTF.visible = false;
            TextFieldEx.setNoTranslate(this.greenTF,true);
            TextFieldEx.setNoTranslate(this.redTF,true);
            TextFieldEx.setNoTranslate(this.purpleTF,true);
            TextFieldEx.setNoTranslate(this.yellowTF,true);
            TextFieldEx.setNoTranslate(this.eventControlPointTF,true);
            TextFieldEx.setNoTranslate(this.whiteTF,true);
        }

        public final function dispose() : void
        {
            this.greenTF = null;
            this.redTF = null;
            this.purpleTF = null;
            this.yellowTF = null;
            this.eventControlPointTF = null;
            this.whiteTF = null;
            this._currTF = null;
        }

        public function setValue(param1:String) : void
        {
            if(!param1 || param1 == this._value)
            {
                return;
            }
            this._value = param1;
            if(this._currTF)
            {
                this.updateValue();
            }
        }

        public function setShape(param1:String) : void
        {
            if(param1 == this._value)
            {
                return;
            }
            if(this._currTF)
            {
                this._currTF.visible = false;
            }
            switch(param1)
            {
                case DirectionIndicatorShape.SHAPE_GREEN:
                    this._currTF = this.greenTF;
                    break;
                case DirectionIndicatorShape.SHAPE_RED:
                    this._currTF = this.redTF;
                    break;
                case DirectionIndicatorShape.SHAPE_PURPLE:
                    this._currTF = this.purpleTF;
                    break;
                case DirectionIndicatorShape.SHAPE_YELLOW:
                    this._currTF = this.yellowTF;
                    break;
                case DirectionIndicatorShape.SHAPE_EVENT_KILL:
                case DirectionIndicatorShape.SHAPE_EVENT_CAPTUREBASE:
                case DirectionIndicatorShape.SHAPE_EVENT_OURBASE:
                    this._currTF = this.whiteTF;
                    break;
                case DirectionIndicatorShape.SHAPE_EVENT_CAPTUREA:
                case DirectionIndicatorShape.SHAPE_EVENT_CAPTUREB:
                case DirectionIndicatorShape.SHAPE_EVENT_CAPTUREC:
                case DirectionIndicatorShape.SHAPE_EVENT_ATTACK:
                case DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RED:
                case DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RECTANGLE:
                    this._currTF = this.eventControlPointTF;
                    break;
                default:
                    return;
            }
            this._currTF.visible = true;
            this.updateValue();
        }

        public function setAlign(param1:String) : void
        {
            if(param1 == this._align)
            {
                return;
            }
            this.applyTextAlign(this.greenTF,param1);
            this.applyTextAlign(this.redTF,param1);
            this.applyTextAlign(this.purpleTF,param1);
            this.applyTextAlign(this.yellowTF,param1);
            this.applyTextAlign(this.eventControlPointTF,param1);
            this.applyTextAlign(this.whiteTF,param1);
            this._align = param1;
        }

        protected function updateValue() : void
        {
            this._currTF.text = this._value;
        }

        private function applyTextAlign(param1:TextField, param2:String) : void
        {
            var _loc3_:TextFormat = param1.defaultTextFormat;
            _loc3_.align = param2;
            param1.defaultTextFormat = _loc3_;
        }
    }
}
