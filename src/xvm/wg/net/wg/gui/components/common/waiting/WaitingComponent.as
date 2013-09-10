package net.wg.gui.components.common.waiting 
{
    import flash.display.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.utils.*;
    
    public class WaitingComponent extends scaleform.clik.core.UIComponent
    {
        public function WaitingComponent()
        {
            super();
            return;
        }

        public function setAnimationStatus(arg1:Boolean):void
        {
            if (this._isStopped != arg1) 
            {
                this._isStopped = arg1;
                invalidate(ANIMATION_STATUS_INVALID);
            }
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(this.waitingMc.name, this.waitingMc, scaleform.clik.utils.Constraints.CENTER_H | scaleform.clik.utils.Constraints.CENTER_V);
            constraints.addElement(this.backgroundMc.name, this.backgroundMc, scaleform.clik.utils.Constraints.ALL);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
                this.backgroundMc.x = this.backgroundMc.x ^ 0;
                this.backgroundMc.y = this.backgroundMc.y ^ 0;
                this.waitingMc.x = this.waitingMc.x ^ 0;
                this.waitingMc.y = this.waitingMc.y ^ 0;
            }
            if (isInvalid(TEXT_INVALID)) 
                this.waitingMc.setMessage(this.text);
            if (isInvalid(ANIMATION_STATUS_INVALID)) 
                if (this._isStopped) 
                    this.waitingMc.stop();
                else 
                    this.waitingMc.play();
            return;
        }

        public function setMessage(arg1:String):void
        {
            this.text = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        internal static const TEXT_INVALID:String="textInv";

        internal static const ANIMATION_STATUS_INVALID:String="animStatusInv";

        public var waitingMc:net.wg.gui.components.common.waiting.WaitingMc;

        public var backgroundMc:flash.display.Sprite;

        internal var text:String="";

        internal var _isStopped:Boolean;
    }
}
