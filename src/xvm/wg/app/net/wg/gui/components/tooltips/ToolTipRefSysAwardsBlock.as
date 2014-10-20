package net.wg.gui.components.tooltips
{
    import flash.display.MovieClip;
    import net.wg.gui.components.interfaces.IToolTipRefSysAwardsBlock;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysAwardsBlockVO;
    
    public class ToolTipRefSysAwardsBlock extends MovieClip implements IToolTipRefSysAwardsBlock
    {
        
        public function ToolTipRefSysAwardsBlock()
        {
            super();
        }
        
        private static var MARGING:int = 4;
        
        private static var RIGTH_TF_PADDING:int = 20;
        
        public var leftTF:TextField = null;
        
        public var rightTF:TextField = null;
        
        public var iconLoader:UILoaderAlt = null;
        
        public function dispose() : void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.leftTF = null;
            this.rightTF = null;
        }
        
        public function update(param1:Object) : void
        {
            this.iconLoader.x = this.leftTF.x + this.leftTF.width + MARGING;
            this.rightTF.x = this.iconLoader.x + RIGTH_TF_PADDING;
            this.rightTF.autoSize = TextFieldAutoSize.LEFT;
            var _loc2_:ToolTipRefSysAwardsBlockVO = ToolTipRefSysAwardsBlockVO(param1);
            this.leftTF.htmlText = _loc2_.leftTF;
            this.iconLoader.source = _loc2_.iconSource;
            this.rightTF.htmlText = _loc2_.rightTF;
        }
    }
}
