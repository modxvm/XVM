package net.wg.gui.prebattle.company 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.utils.*;
    
    public class CompanyDropItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function CompanyDropItemRenderer()
        {
            super();
            buttonMode = true;
            mouseEnabled = true;
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (!(this.data == null) && arg1 == this.data) 
            {
                return;
            }
            super.setData(arg1);
            invalidate("invalidateWindow");
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(this.numberField.name, this.numberField, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.bg.name, this.bg, scaleform.clik.utils.Constraints.ALL);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid("invalidateWindow") && data && !this.isUpdated) 
            {
                this.isUpdated = true;
                this.afterSetData();
            }
            return;
        }

        internal function afterSetData():void
        {
            if (data != null) 
            {
                this.label = String(data["label"]);
                if (data["color"] != null) 
                {
                    textField.textColor = data["color"];
                }
            }
            this.numberField.text = String(index + 1);
            this.bg.visible = !Boolean(index % 2);
            return;
        }

        internal function cutText(arg1:String):String
        {
            var loc1:*=null;
            var loc2:*=0;
            textField.text = arg1;
            if (textField.getLineLength(1) != -1) 
            {
                loc1 = arg1;
                loc2 = textField.getLineLength(0);
                loc1 = loc1.substr(0, loc2 - 2);
                loc1 = loc1 + "..";
                textField.text = loc1;
            }
            return textField.text;
        }

        public override function set label(arg1:String):void
        {
            arg1 = this.cutText(arg1);
            super.label = arg1;
            return;
        }

        public var numberField:flash.text.TextField;

        public var bg:flash.display.MovieClip;

        internal var isUpdated:Boolean=false;
    }
}
