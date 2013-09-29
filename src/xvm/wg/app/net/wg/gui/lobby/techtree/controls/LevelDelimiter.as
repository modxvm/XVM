package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.utils.*;
    
    public class LevelDelimiter extends scaleform.clik.core.UIComponent
    {
        public function LevelDelimiter()
        {
            super();
            return;
        }

        public function get levelNumber():int
        {
            return this._levelNumber;
        }

        public function set levelNumber(arg1:int):void
        {
            if (this._levelNumber == arg1) 
            {
                return;
            }
            this._levelNumber = arg1;
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement(this.level.name, this.level, scaleform.clik.utils.Constraints.CENTER_H);
            constraints.addElement(this.background.name, this.background, scaleform.clik.utils.Constraints.ALL);
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (!(this.level == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.level.gotoAndStop(this._levelNumber);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
            }
            return;
        }

        internal var _levelNumber:int=1;

        public var level:flash.display.MovieClip;

        public var background:flash.display.Sprite;
    }
}
