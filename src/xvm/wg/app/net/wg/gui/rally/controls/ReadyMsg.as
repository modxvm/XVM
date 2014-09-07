package net.wg.gui.rally.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.constants.InvalidationType;
    
    public class ReadyMsg extends UIComponent
    {
        
        public function ReadyMsg()
        {
            super();
        }
        
        public var tf:TextField;
        
        private var _color:String;
        
        private var _label:String;
        
        override protected function preInitialize() : void
        {
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
        }
        
        override protected function configUI() : void
        {
            constraints.addElement("tf",this.tf,Constraints.ALL);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                gotoAndStop(this._color);
                this.updateAfterStateChange();
                invalidate(InvalidationType.DATA,InvalidationType.SIZE);
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.tf.text = this._label;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                if(constraints)
                {
                    constraints.update(_width,_height);
                }
            }
        }
        
        protected function updateAfterStateChange() : void
        {
            if(!initialized)
            {
                return;
            }
            if(!(constraints == null) && !(this.tf == null))
            {
                constraints.updateElement("tf",this.tf);
            }
        }
        
        public function setMessage(param1:String, param2:String) : void
        {
            this._color = param2;
            this._label = param1;
            invalidateState();
        }
    }
}
