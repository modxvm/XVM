package net.wg.gui.prebattle.battleSession 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.utils.*;
    
    public class BattleSessionListRenderer extends net.wg.gui.components.controls.TextFieldShort
    {
        public function BattleSessionListRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.shadowColor = "Black";
            this.textColor = 16777215;
            this.textSize = 15;
            constraints.addElement("opponentsField", this.opponentsField, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("timeField", this.timeField, scaleform.clik.utils.Constraints.ALL);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_DATA) && this.dataVO) 
            {
                this.afterSetData();
            }
            return;
        }

        internal function afterSetData():void
        {
            textField.text = this.dataVO.descr;
            this.opponentsField.text = this.dataVO.opponents;
            this.timeField.text = this.dataVO.startTime;
            DebugUtils.LOG_DEBUG(this.dataVO.descr, this.dataVO.opponents, this.dataVO.startTime);
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                this.dataVO = null;
                visible = false;
                return;
            }
            if (!visible) 
            {
                visible = true;
            }
            this.dataVO = new net.wg.gui.prebattle.battleSession.BSListRendererVO(arg1);
            super.setData(arg1);
            this.label = this.dataVO.descr;
            invalidate(INVALIDATE_DATA);
            validateNow();
            return;
        }

        internal static const INVALIDATE_DATA:String="invalidateData";

        public var opponentsField:flash.text.TextField;

        public var timeField:flash.text.TextField;

        internal var dataVO:net.wg.gui.prebattle.battleSession.BSListRendererVO=null;
    }
}
