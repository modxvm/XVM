package net.wg.gui.components.controls.achievements 
{
    import flash.display.*;
    
    public class BeigeCounter extends net.wg.gui.components.controls.achievements.CounterComponent
    {
        public function BeigeCounter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this._labels = this.currentLabels;
            tooltip = TOOLTIPS.ACHIEVEMENT_ATTR_DEGREE;
            return;
        }

        public override function receiveBottomPadding():Number
        {
            return 0;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (isInvalid(CLASS_INV)) 
            {
                gotoAndStop("empty");
                if (this._labels) 
                {
                    loc1 = 0;
                    while (loc1 < this._labels.length) 
                    {
                        loc2 = this._labels[loc1];
                        if (loc2.name == "level" + this._classValue) 
                            gotoAndStop(loc2.name);
                        ++loc1;
                    }
                }
            }
            return;
        }

        public override function get text():String
        {
            return this._classValue;
        }

        public override function set text(arg1:String):void
        {
            this._classValue = arg1;
            invalidate(CLASS_INV);
            return;
        }

        internal static const CLASS_INV:String="classInvalid";

        internal var _labels:Array=null;

        internal var _classValue:String="";
    }
}
