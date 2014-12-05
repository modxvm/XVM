package net.wg.gui.components.tooltips
{
    import flash.display.MovieClip;
    import net.wg.gui.components.interfaces.IToolTipRefSysXPMultiplierBlock;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysXPMultiplierBlockVO;
    
    public class ToolTipRefSysXPMultiplierBlock extends MovieClip implements IToolTipRefSysXPMultiplierBlock
    {
        
        public function ToolTipRefSysXPMultiplierBlock()
        {
            super();
            this.descriptionTF.wordWrap = true;
            this.descriptionTF.multiline = true;
        }
        
        public var xpIconLoader:UILoaderAlt = null;
        
        public var multiplierTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public function dispose() : void
        {
            this.xpIconLoader.dispose();
            this.xpIconLoader = null;
            this.multiplierTF = null;
            this.descriptionTF = null;
        }
        
        public function update(param1:Object) : void
        {
            var _loc2_:ToolTipRefSysXPMultiplierBlockVO = ToolTipRefSysXPMultiplierBlockVO(param1);
            this.xpIconLoader.source = _loc2_.xpIconSource;
            this.multiplierTF.htmlText = _loc2_.multiplierText;
            this.descriptionTF.htmlText = _loc2_.descriptionText;
            this.descriptionTF.height = this.descriptionTF.textHeight + 5;
        }
    }
}
