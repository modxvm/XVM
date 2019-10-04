package net.wg.gui.battle.views.directionIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class DirnIndicatorDistance extends Sprite implements IDisposable
    {

        private static const DISTANCE_POSTFIX:String = "m";

        public var greenTF:TextField = null;

        public var redTF:TextField = null;

        public var purpleTF:TextField = null;

        public var yellowTF:TextField = null;

        private var _currTF:TextField = null;

        private var _distance:Number = NaN;

        public function DirnIndicatorDistance()
        {
            super();
            this.greenTF.visible = false;
            this.redTF.visible = false;
            this.purpleTF.visible = false;
            this.yellowTF.visible = false;
            TextFieldEx.setNoTranslate(this.greenTF,true);
            TextFieldEx.setNoTranslate(this.redTF,true);
            TextFieldEx.setNoTranslate(this.purpleTF,true);
            TextFieldEx.setNoTranslate(this.yellowTF,true);
        }

        public function setShape(param1:String) : void
        {
            if(this._currTF)
            {
                this._currTF.visible = false;
            }
            if(param1 == DirectionIndicatorShape.SHAPE_GREEN)
            {
                this._currTF = this.greenTF;
            }
            else if(param1 == DirectionIndicatorShape.SHAPE_RED)
            {
                this._currTF = this.redTF;
            }
            else if(param1 == DirectionIndicatorShape.SHAPE_PURPLE)
            {
                this._currTF = this.purpleTF;
            }
            else if(param1 == DirectionIndicatorShape.SHAPE_YELLOW)
            {
                this._currTF = this.yellowTF;
            }
            else
            {
                return;
            }
            this._currTF.visible = true;
            if(!isNaN(this._distance))
            {
                this.updateDistance();
            }
        }

        public function setDistance(param1:Number) : void
        {
            if(isNaN(param1))
            {
                return;
            }
            var param1:Number = Math.round(param1);
            if(this._distance == param1)
            {
                return;
            }
            this._distance = param1;
            if(this._currTF)
            {
                this.updateDistance();
            }
        }

        public function dispose() : void
        {
            this.greenTF = null;
            this.redTF = null;
            this.purpleTF = null;
            this.yellowTF = null;
            this._currTF = null;
        }

        private function updateDistance() : void
        {
            this._currTF.text = isNaN(this._distance)?"":this._distance + DISTANCE_POSTFIX;
        }
    }
}
