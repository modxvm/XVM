package net.wg.gui.components.common.waiting 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class Waiting extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function Waiting()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                if (this.waitingComponent) 
                {
                    this.waitingComponent.setSize(_width, _height);
                }
            }
            if (isInvalid(TEXT_INVALID)) 
            {
                if (this.waitingComponent) 
                {
                    this.waitingComponent.setMessage(this._text);
                }
            }
            return;
        }

        public function setMessage(arg1:String):void
        {
            this._text = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        public function show():void
        {
            visible = true;
            if (!this.waitingComponent) 
            {
                this.waitingComponent = net.wg.gui.components.common.waiting.WaitingComponent(App.utils.classFactory.getObject(net.wg.data.constants.Linkages.WAITING_COMPONENT));
                addChild(this.waitingComponent);
                invalidate(TEXT_INVALID, scaleform.clik.constants.InvalidationType.SIZE);
            }
            return;
        }

        public function hide():void
        {
            visible = false;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.waitingComponent) 
            {
                if (this.waitingComponent.parent) 
                {
                    this.waitingComponent.parent.removeChild(this.waitingComponent);
                }
                this.waitingComponent = null;
            }
            if (this.waitingComponent) 
            {
                this.waitingComponent.dispose();
                if (this.waitingComponent.parent) 
                {
                    this.waitingComponent.parent.removeChild(this.waitingComponent);
                    this.waitingComponent = null;
                }
            }
            return;
        }

        
        {
            TEXT_INVALID = "txtInv";
        }

        internal var waitingComponent:net.wg.gui.components.common.waiting.WaitingComponent;

        internal var _text:String;

        internal static var TEXT_INVALID:String="txtInv";
    }
}
