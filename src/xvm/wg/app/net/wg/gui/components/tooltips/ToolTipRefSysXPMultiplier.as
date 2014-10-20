package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysXPMultiplierVO;
    import net.wg.gui.components.interfaces.IToolTipRefSysXPMultiplierBlock;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.display.MovieClip;
    import scaleform.clik.utils.Padding;
    
    public class ToolTipRefSysXPMultiplier extends ToolTipSpecial
    {
        
        public function ToolTipRefSysXPMultiplier()
        {
            super();
            contentMargin = new Padding(18,19,18,19);
            this.titleTF = content.titleTF;
            this.descriptionTF = content.descriptionTF;
            this.conditionsTF = content.conditionsTF;
            this.bottomTF = content.bottomTF;
            this.whiteBg = content.whiteBg;
            separators = new Vector.<Separator>();
            this.xpBlocks = new Vector.<ToolTipRefSysXPMultiplierBlock>();
        }
        
        private static var XP_BLOCK_UI:String = "ToolTipRefSysXPMultiplierBlockUI";
        
        private static var BG_WIDTH:int = 374;
        
        private static var BG_HEIGHT:int = 304;
        
        private static var WHITE_BG_HEIGHT:int = 120;
        
        private static var TEXT_PADDING:int = 5;
        
        private static var XP_BLOCK_PADDING:int = 40;
        
        public var titleTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var conditionsTF:TextField = null;
        
        public var bottomTF:TextField = null;
        
        public var whiteBg:Sprite = null;
        
        private var xpBlocks:Vector.<ToolTipRefSysXPMultiplierBlock> = null;
        
        private var model:ToolTipRefSysXPMultiplierVO = null;
        
        override protected function onDispose() : void
        {
            var _loc1_:IToolTipRefSysXPMultiplierBlock = null;
            this.titleTF = null;
            this.descriptionTF = null;
            this.conditionsTF = null;
            this.bottomTF = null;
            this.whiteBg = null;
            while(content.numChildren > 0)
            {
                content.removeChildAt(0);
            }
            for each(_loc1_ in this.xpBlocks)
            {
                _loc1_.dispose();
            }
            this.xpBlocks.splice(0,this.xpBlocks.length);
            this.xpBlocks = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function redraw() : void
        {
            this.setData();
            this.updatePositions();
            super.redraw();
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            background.width = BG_WIDTH;
            background.height = BG_HEIGHT;
        }
        
        override protected function updatePositions() : void
        {
            var _loc1_:Separator = null;
            var _loc2_:IToolTipRefSysXPMultiplierBlock = null;
            this.descriptionTF.x = this.conditionsTF.x = this.bottomTF.x = this.titleTF.x = contentMargin.left + bgShadowMargin.left;
            this.titleTF.y = topPosition;
            this.descriptionTF.y = this.titleTF.y + this.titleTF.height + 1 ^ 0;
            this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_PADDING;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = this.descriptionTF.y + this.descriptionTF.height + 13 ^ 0;
            separators.push(_loc1_);
            this.whiteBg.x = 0;
            this.whiteBg.y = _loc1_.y + _loc1_.height ^ 0;
            this.whiteBg.width = background.width;
            this.whiteBg.height = WHITE_BG_HEIGHT;
            this.conditionsTF.y = _loc1_.y + _loc1_.height + 16 ^ 0;
            this.conditionsTF.height = this.conditionsTF.textHeight;
            var _loc3_:int = this.model.xpBlocksVOs.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc2_ = this.createXPBlock(content);
                _loc2_.update(this.model.xpBlocksVOs[_loc4_]);
                _loc2_.x = this.conditionsTF.x + XP_BLOCK_PADDING;
                _loc2_.y = this.conditionsTF.y + 25 + _loc2_.height * _loc4_ ^ 0;
                this.xpBlocks.push(_loc2_);
                _loc4_++;
            }
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = this.whiteBg.y + this.whiteBg.height ^ 0;
            separators.push(_loc1_);
            this.bottomTF.y = _loc1_.y + _loc1_.height + 14 ^ 0;
            this.bottomTF.height = this.bottomTF.textHeight + TEXT_PADDING;
            super.updatePositions();
        }
        
        private function createXPBlock(param1:MovieClip) : IToolTipRefSysXPMultiplierBlock
        {
            var _loc2_:IToolTipRefSysXPMultiplierBlock = App.utils.classFactory.getComponent(XP_BLOCK_UI,ToolTipRefSysXPMultiplierBlock);
            param1.addChild(_loc2_ as MovieClip);
            return _loc2_;
        }
        
        private function setData() : void
        {
            this.model = new ToolTipRefSysXPMultiplierVO(_data);
            this.titleTF.htmlText = this.model.titleText;
            this.descriptionTF.htmlText = this.model.descriptionText;
            this.conditionsTF.htmlText = this.model.conditionsText;
            this.bottomTF.htmlText = this.model.bottomText;
        }
    }
}
