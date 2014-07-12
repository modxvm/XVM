package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.TankmenVO;
    import net.wg.data.managers.ITooltipProps;
    import net.wg.gui.events.UILoaderEvent;
    import flash.text.TextFormat;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
    import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
    import flash.text.StyleSheet;
    
    public class ToolTipTankmen extends ToolTipSpecial
    {
        
        public function ToolTipTankmen() {
            super();
            this.headerTF = content.headerTF;
            this.tooltipStatus = content.tooltipStatus;
            this.tooltipStatusNewSkill = content.tooltipStatusNewSkill;
            this.tankInfoHeaderTF = content.tankInfoHeaderTF;
            this.tankInfoTF = content.tankInfoTF;
            this.vehicleIco = content.vehicleIco;
            this.whiteBg = content.whiteBg;
        }
        
        public var headerTF:TextField = null;
        
        public var tooltipStatus:Status = null;
        
        public var tooltipStatusNewSkill:Status = null;
        
        public var tankInfoHeaderTF:TextField = null;
        
        public var tankInfoTF:TextField = null;
        
        public var vehicleIco:UILoaderAlt = null;
        
        public var whiteBg:Sprite = null;
        
        private var dataVO:TankmenVO = null;
        
        override public function build(param1:Object, param2:ITooltipProps) : void {
            super.build(param1,param2);
        }
        
        override protected function onDispose() : void {
            if(this.vehicleIco.hasEventListener(UILoaderEvent.COMPLETE))
            {
                this.vehicleIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            }
            super.onDispose();
        }
        
        override public function toString() : String {
            return "[WG ToolTipTankmen " + name + "]";
        }
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function redraw() : void {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        override protected function updateSize() : void {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.whiteBg.width = content.width + bgShadowMargin.horizontal;
        }
        
        private function getSign(param1:Number) : String {
            return param1 >= 0?"+":"";
        }
        
        private function onIcoLoaded(param1:UILoaderEvent) : void {
            if(this.vehicleIco.hasEventListener(UILoaderEvent.COMPLETE))
            {
                this.vehicleIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            }
            this.vehicleIco.scaleX = -1;
            this.vehicleIco.x = contentMargin.left + bgShadowMargin.left + this.vehicleIco.width;
            this.tankInfoTF.x = this.vehicleIco.x + 5;
        }
    }
}
