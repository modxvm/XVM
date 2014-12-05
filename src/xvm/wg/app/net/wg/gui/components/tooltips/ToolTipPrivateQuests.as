package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.data.managers.ITooltipProps;
    import net.wg.gui.components.tooltips.VO.PrivateQuestsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
    import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
    import net.wg.utils.ILocale;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
    
    public class ToolTipPrivateQuests extends ToolTipSpecial
    {
        
        public function ToolTipPrivateQuests()
        {
            super();
            this.headerTF = content.headerTF;
            this.conditionTF = content.conditionTF;
            this.descriptionTF = content.descriptionTF;
            this.tooltipStatus = content.tooltipStatus;
            this.whiteBg = content.whiteBg;
        }
        
        public var headerTF:TextField = null;
        
        public var conditionTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var tooltipStatus:Status = null;
        
        private var whiteBg:Sprite = null;
        
        override public function build(param1:Object, param2:ITooltipProps) : void
        {
            super.build(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override public function toString() : String
        {
            return "[WG ToolTipVehicle " + name + "]";
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function redraw() : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            var _loc1_:Number = content.width + contentMargin.right - bgShadowMargin.left;
            if(this.whiteBg.visible)
            {
                this.whiteBg.x = bgShadowMargin.left;
                this.whiteBg.width = _loc1_;
            }
        }
    }
}
