package net.wg.gui.lobby.tankman
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Shape;
    import net.wg.data.constants.Linkages;
    import flash.display.MovieClip;
    import scaleform.gfx.Extensions;
    
    public class PersonalCaseBlocksArea extends UIComponent
    {
        
        public function PersonalCaseBlocksArea()
        {
            super();
        }
        
        private static var Y_START_POSITION:uint = 17;
        
        private static var PADDING_BETWEEN_BLOCKS:uint = 20;
        
        private static var PADDING_BETWEEN_BLOCK_TITLE:uint = 11;
        
        private var data:Array;
        
        private var isElementsCreated:Boolean = false;
        
        private var paddingY:int = 17;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.removeElements();
        }
        
        private function removeElements() : void
        {
            var _loc1_:uint = this.numChildren;
            var _loc2_:int = _loc1_ - 1;
            while(_loc2_ >= 0)
            {
                if(this.getChildAt(_loc2_) is IDisposable)
                {
                    IDisposable(this.getChildAt(_loc2_)).dispose();
                }
                this.removeChildAt(_loc2_);
                _loc2_--;
            }
        }
        
        public function setData(param1:Array) : void
        {
            if(!App.instance || param1 == null)
            {
                return;
            }
            this.data = param1;
            if(this.isElementsCreated)
            {
                this.updateBlocks();
            }
            else
            {
                this.initializeBlocks();
            }
        }
        
        private function updateBlocks() : void
        {
            var _loc3_:Object = null;
            this.paddingY = Y_START_POSITION;
            var _loc1_:int = this.numChildren;
            var _loc2_:int = _loc1_ - 1;
            while(_loc2_ >= 0)
            {
                _loc3_ = this.getChildAt(_loc2_);
                if(this.getChildAt(_loc2_) is Shape == false)
                {
                    this.removeChildAt(_loc2_);
                }
                _loc2_--;
            }
            this.initializeBlocks();
        }
        
        private function initializeBlocks() : void
        {
            var _loc2_:Object = null;
            var _loc1_:* = 0;
            while(_loc1_ < this.data.length)
            {
                _loc2_ = this.data[_loc1_];
                this.createTitles(_loc2_);
                _loc1_++;
            }
            this.isElementsCreated = true;
        }
        
        private function createTitles(param1:Object) : void
        {
            var _loc2_:MovieClip = this.classFactory(Linkages.PERSONAL_CASE_TITLE_BLOCK);
            if(Extensions.isScaleform)
            {
                _loc2_["blockName"].text = MENU.profile_stats_blocks(param1.label);
            }
            else
            {
                _loc2_["blockName"].text = param1.label;
            }
            _loc2_.y = this.paddingY;
            this.addChild(_loc2_);
            this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCKS;
            this.creteRows(param1.stats);
        }
        
        private function creteRows(param1:Array) : void
        {
            var _loc3_:Object = null;
            var _loc4_:PersonalCaseBlockItem = null;
            var _loc2_:* = 0;
            while(_loc2_ < param1.length)
            {
                _loc3_ = param1[_loc2_];
                _loc4_ = this.classFactory(Linkages.PERSONAL_CASE_BLOCK_ITEM);
                _loc4_.setData = _loc3_;
                _loc4_.y = this.paddingY;
                this.addChild(_loc4_);
                this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCKS;
                _loc2_++;
            }
            this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCK_TITLE;
        }
        
        private function classFactory(param1:String) : *
        {
            return App.utils.classFactory.getComponent(param1,MovieClip);
        }
    }
}
