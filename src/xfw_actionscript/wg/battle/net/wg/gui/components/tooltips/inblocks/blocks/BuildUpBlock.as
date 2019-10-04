package net.wg.gui.components.tooltips.inblocks.blocks
{
    import net.wg.infrastructure.interfaces.pool.IPoolItem;
    import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlocks;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
    import net.wg.gui.components.tooltips.inblocks.data.BuildUpBlockVO;
    import flash.display.DisplayObject;
    import net.wg.utils.ICounterManager;
    import net.wg.gui.components.tooltips.layout.BaseTooltipLayout;
    import net.wg.gui.components.tooltips.layout.TooltipHorizontalLayout;
    import net.wg.gui.components.tooltips.layout.TooltipVerticalLayout;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
    import net.wg.utils.ICounterProps;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import flash.text.TextFormatAlign;
    import net.wg.data.constants.Linkages;
    import net.wg.infrastructure.managers.counter.CounterManager;
    import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
    import net.wg.data.VO.PaddingVO;
    import net.wg.gui.components.tooltips.inblocks.TooltipInBlocksUtils;
    import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
    import net.wg.gui.components.tooltips.inblocks.interfaces.ITootipBlocksData;

    public class BuildUpBlock extends BaseTooltipBlock implements IPoolItem, ITooltipBlocks
    {

        private static const PADDING_BOTTOM:int = 7;

        private static const COUNTER_OFFSET_X:int = -14;

        private static const COUNTER_OFFSET_Y:int = -9;

        public var background:Sprite;

        private var _blocks:Vector.<ITooltipBlock>;

        private var _blockData:BuildUpBlockVO;

        private var _blockWidth:int = 0;

        private var _blockHeight:int = 0;

        private var _highlightBlockDO:DisplayObject;

        private var _counterManager:ICounterManager;

        private var _layout:BaseTooltipLayout;

        private var _horizontalLayout:TooltipHorizontalLayout;

        private var _verticalLayout:TooltipVerticalLayout;

        public function BuildUpBlock()
        {
            this._counterManager = App.utils.counterManager;
            super();
        }

        override public function cleanUp() : void
        {
            this.clearBlocks();
            this.clearData();
            if(this._layout)
            {
                this._layout.cleanUp();
                this._layout = null;
            }
            this.x = this.y = this._blockWidth = this._blockHeight = 0;
        }

        override public function getBg() : DisplayObject
        {
            return this.background;
        }

        override public function getHeight() : Number
        {
            return this._blockHeight;
        }

        override public function getStretchBg() : Boolean
        {
            return this._blockData.stretchBg;
        }

        override public function getWidth() : Number
        {
            return this._blockWidth;
        }

        override public function setBlockData(param1:Object) : void
        {
            this.clearData();
            this._blockData = new BuildUpBlockVO(param1);
            if(this._blockData.blocksData == null)
            {
                App.utils.asserter.assert(false,"Blocks data" + Errors.CANT_EMPTY);
            }
            this._layout = this.getLayout();
            invalidateBlock();
        }

        override public function setBlockWidth(param1:int) : void
        {
            this._blockWidth = param1;
        }

        override protected function onDispose() : void
        {
            this.cleanUp();
            this.background = null;
            this._counterManager = null;
            this._horizontalLayout = null;
            this._verticalLayout = null;
            super.onDispose();
        }

        override protected function onValidateBlock() : Boolean
        {
            if(!this.isBlocksBuilt())
            {
                this.buildBlocks();
            }
            else if(this.isInvalidBlocks())
            {
                this.tryValidateBlocks();
            }
            else
            {
                this.updateLayout();
                this.highlightBlock();
                return false;
            }
            return true;
        }

        private function getLayout() : BaseTooltipLayout
        {
            switch(this._blockData.layout)
            {
                case BLOCKS_TOOLTIP_TYPES.LAYOUT_HORIZONTAL:
                    return this._horizontalLayout = this._horizontalLayout || new TooltipHorizontalLayout();
                case BLOCKS_TOOLTIP_TYPES.LAYOUT_VERTICAL:
                default:
                    return this._verticalLayout = this._verticalLayout || new TooltipVerticalLayout();
            }
        }

        private function updateLayout() : void
        {
            this._layout.arrange(this);
            this._blockWidth = this._layout.layoutWidth;
            this._blockHeight = this._layout.layoutHeight + PADDING_BOTTOM;
        }

        private function highlightBlock() : void
        {
            var _loc1_:ICounterProps = null;
            if(this._highlightBlockDO)
            {
                _loc1_ = new CounterProps(COUNTER_OFFSET_X,COUNTER_OFFSET_Y,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_BIG_UI);
                this._counterManager.setCounter(this._highlightBlockDO,CounterManager.COUNTER_EMPTY,null,_loc1_);
            }
        }

        private function isBlocksBuilt() : Boolean
        {
            return this._blocks != null && this._blocks.length > 0;
        }

        private function tryValidateBlocks() : void
        {
            var _loc1_:ITooltipBlock = null;
            for each(_loc1_ in this._blocks)
            {
                if(_loc1_.isBlockInvalid())
                {
                    _loc1_.tryValidateBlock();
                }
            }
        }

        private function isInvalidBlocks() : Boolean
        {
            var _loc1_:ITooltipBlock = null;
            for each(_loc1_ in this._blocks)
            {
                if(_loc1_.isBlockInvalid())
                {
                    return true;
                }
            }
            return false;
        }

        private function clearData() : void
        {
            if(this._blockData != null)
            {
                this._blockData.dispose();
                this._blockData = null;
            }
            if(this._highlightBlockDO)
            {
                this._counterManager.removeCounter(this._highlightBlockDO);
                this._highlightBlockDO = null;
            }
        }

        private function buildBlocks() : void
        {
            var _loc1_:ITooltipBlock = null;
            var _loc2_:DisplayObject = null;
            var _loc3_:BlockDataItemVO = null;
            var _loc8_:PaddingVO = null;
            this.clearBlocks();
            var _loc4_:Vector.<BlockDataItemVO> = this._blockData.blocksData;
            var _loc5_:int = _loc4_.length;
            var _loc6_:* = 0;
            var _loc7_:TooltipInBlocksUtils = TooltipInBlocksUtils.instance;
            this._blocks = new Vector.<ITooltipBlock>(_loc5_,true);
            this._layout.setExpectedWidth(this._blockWidth);
            while(_loc6_ < _loc5_)
            {
                _loc3_ = _loc4_[_loc6_];
                _loc8_ = _loc3_.padding;
                _loc1_ = _loc7_.createBlock(_loc3_.linkage);
                _loc1_.addEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
                this._blocks[_loc6_] = _loc1_;
                this._layout.measureBlock(this._blocks[_loc6_],_loc3_);
                _loc1_.setBlockData(_loc3_.data);
                _loc2_ = _loc1_.getDisplayObject();
                if(_loc3_.data.highlight)
                {
                    this._highlightBlockDO = _loc2_;
                }
                addChild(_loc2_);
                _loc6_++;
            }
        }

        private function clearBlocks() : void
        {
            var _loc1_:ITooltipBlock = null;
            if(this._blocks != null)
            {
                for each(_loc1_ in this._blocks)
                {
                    _loc1_.removeEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
                    removeChild(_loc1_.getDisplayObject());
                    _loc1_.dispose();
                }
                this._blocks.fixed = false;
                this._blocks.splice(0,this._blocks.length);
                this._blocks = null;
            }
        }

        public function get blocks() : Vector.<ITooltipBlock>
        {
            return this._blocks;
        }

        public function get data() : ITootipBlocksData
        {
            return this._blockData;
        }

        private function onBlockSizeChangeHandler(param1:ToolTipBlockEvent) : void
        {
            invalidateBlock();
            dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
        }
    }
}
