package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.interfaces.IToolTipRefSysAwardsBlock;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysDescriptionVO;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import scaleform.clik.utils.Padding;
    
    public class ToolTipRefSysDescription extends ToolTipSpecial
    {
        
        public function ToolTipRefSysDescription()
        {
            super();
            contentWidth = CONTENT_WIDTH;
            contentMargin = new Padding(18,12,12,24);
            this.titleTF = content.titleTF;
            this.actionTF = content.actionTF;
            this.conditionsTF = content.conditionsTF;
            this.awardsTitleTF = content.awardsTitleTF;
            this.bottomTF = content.bottomTF;
            this.whiteBg = content.whiteBg;
            this.textBlocks = new Vector.<IToolTipRefSysAwardsBlock>();
        }
        
        private static var TEXT_BLOCK_UI:String = "RefSysAwardsBlockUI";
        
        private static var CONTENT_WIDTH:int = 357;
        
        private static var TEXT_PADDING:int = 5;
        
        public var titleTF:TextField = null;
        
        public var actionTF:TextField = null;
        
        public var conditionsTF:TextField = null;
        
        public var awardsTitleTF:TextField = null;
        
        public var bottomTF:TextField = null;
        
        public var whiteBg:Sprite = null;
        
        private var textBlocks:Vector.<IToolTipRefSysAwardsBlock> = null;
        
        private var model:ToolTipRefSysDescriptionVO = null;
        
        public function createTextBlock(param1:MovieClip) : IToolTipRefSysAwardsBlock
        {
            var _loc2_:IToolTipRefSysAwardsBlock = App.utils.classFactory.getComponent(TEXT_BLOCK_UI,ToolTipRefSysAwardsBlock);
            param1.addChild(_loc2_ as MovieClip);
            return _loc2_;
        }
        
        override protected function redraw() : void
        {
            separators = new Vector.<Separator>();
            this.setData();
            this.updatePositions();
            super.redraw();
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            if(this.whiteBg.visible)
            {
                this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IToolTipRefSysAwardsBlock = null;
            this.titleTF = null;
            this.actionTF = null;
            this.conditionsTF = null;
            this.awardsTitleTF = null;
            this.bottomTF = null;
            this.whiteBg = null;
            while(content.numChildren > 0)
            {
                content.removeChildAt(0);
            }
            for each(_loc1_ in this.textBlocks)
            {
                _loc1_.dispose();
            }
            this.textBlocks.splice(0,this.textBlocks.length);
            this.textBlocks = null;
            separators.splice(0,separators.length);
            separators = null;
            this.model.dispose();
            this.model = null;
            super.onDispose();
        }
        
        override protected function updatePositions() : void
        {
            var _loc4_:DisplayObject = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc1_:IToolTipRefSysAwardsBlock = null;
            var _loc2_:Separator = null;
            var _loc3_:Array = [this.titleTF,this.actionTF,this.conditionsTF,this.awardsTitleTF,this.bottomTF];
            for each(_loc4_ in _loc3_)
            {
                _loc4_.x = contentMargin.left;
                _loc4_.width = contentWidth - contentMargin.horizontal;
            }
            this.titleTF.y = contentMargin.top;
            this.actionTF.y = this.titleTF.y + this.titleTF.height + 10 ^ 0;
            this.actionTF.height = this.actionTF.textHeight + TEXT_PADDING;
            this.conditionsTF.y = this.actionTF.y + this.actionTF.height + 4 ^ 0;
            this.conditionsTF.height = this.conditionsTF.textHeight + TEXT_PADDING ^ 0;
            _loc2_ = Utils.instance.createSeparate(content);
            _loc2_.y = this.conditionsTF.y + this.conditionsTF.height + 18 ^ 0;
            separators.push(_loc2_);
            this.whiteBg.y = _loc2_.y + _loc2_.height ^ 0;
            this.awardsTitleTF.y = _loc2_.y + _loc2_.height + 16 ^ 0;
            _loc5_ = this.model.blocksVOs.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
                _loc1_ = this.createTextBlock(content);
                _loc1_.update(this.model.blocksVOs[_loc6_]);
                _loc1_.x = contentMargin.left;
                _loc1_.y = this.awardsTitleTF.y + 25 + (_loc1_.height - 4) * _loc6_ ^ 0;
                this.textBlocks.push(_loc1_);
                _loc6_++;
            }
            _loc2_ = Utils.instance.createSeparate(content);
            _loc2_.y = _loc1_.y + _loc1_.height + 14 ^ 0;
            separators.push(_loc2_);
            this.whiteBg.height = _loc2_.y - this.whiteBg.y ^ 0;
            this.bottomTF.y = _loc2_.y + _loc2_.height + 17 ^ 0;
            this.bottomTF.height = this.bottomTF.textHeight + TEXT_PADDING;
        }
        
        private function setData() : void
        {
            this.model = new ToolTipRefSysDescriptionVO(_data);
            this.titleTF.htmlText = this.model.titleTF;
            this.actionTF.htmlText = this.model.actionTF;
            this.conditionsTF.htmlText = this.model.conditionsTF;
            this.awardsTitleTF.htmlText = this.model.awardsTitleTF;
            this.bottomTF.htmlText = this.model.bottomTF;
        }
    }
}
