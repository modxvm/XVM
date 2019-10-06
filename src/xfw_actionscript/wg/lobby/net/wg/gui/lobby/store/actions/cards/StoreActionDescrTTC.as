package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.HyperLink;
    import scaleform.clik.utils.Padding;
    import flash.display.DisplayObject;
    import net.wg.gui.components.tooltips.inblocks.data.TooltipInBlocksVO;
    import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
    import flash.geom.Rectangle;
    import scaleform.clik.motion.Tween;
    import net.wg.utils.IUtils;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.data.constants.Errors;
    import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
    import net.wg.data.VO.PaddingVO;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.components.tooltips.inblocks.TooltipInBlocksUtils;
    import flash.events.Event;
    import fl.motion.easing.Cubic;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.data.constants.Values;

    public class StoreActionDescrTTC extends MovieClip implements IDisposable
    {

        private static const DASHLINE_UI_LINKAGE:String = "DashLine_UI";

        private static const SHOW_TWEEN_DURATION:int = 350;

        private static const SEPARATOR_OFFSET:int = 30;

        private static const SEPARATOR_WIDTH:int = 350;

        public var description:TextField = null;

        public var actionBtn:ISoundButtonEx = null;

        public var linkBtn:HyperLink = null;

        protected var contentMargin:Padding;

        protected var separators:Vector.<DisplayObject> = null;

        protected var topPosition:Number = 0;

        private var _inBlocksData:TooltipInBlocksVO;

        private var _blocks:Vector.<ITooltipBlock>;

        private var _validationScheduled:Boolean = false;

        private var _cardBounds:Rectangle = null;

        private var _showTween:Tween;

        private var _utils:IUtils;

        public function StoreActionDescrTTC()
        {
            this.contentMargin = new Padding(113,0,20,-38);
            this._utils = App.utils;
            super();
            visible = false;
            alpha = 0;
        }

        public final function dispose() : void
        {
            this._utils.scheduler.cancelTask(this.scheduleValidation);
            this.unscheduleValidation();
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.clearTween();
            this.cleaUpSeparators();
            this.clearBlocks();
            this.actionBtn.dispose();
            this.actionBtn = null;
            this.linkBtn.dispose();
            this.linkBtn = null;
            this.description = null;
            this.contentMargin = null;
            if(this._inBlocksData != null)
            {
                this._inBlocksData.dispose();
                this._inBlocksData = null;
            }
            this._cardBounds = null;
            this._utils = null;
        }

        public function setData(param1:StoreActionCardVo) : void
        {
            this._utils.asserter.assertNotNull(param1.storeItemDescrVo.ttcDataVO,"ttcDataVO" + Errors.CANT_NULL);
            this._inBlocksData = new TooltipInBlocksVO(param1.storeItemDescrVo.ttcDataVO);
            this.scheduleValidation();
            if(param1.hasLinkBtn)
            {
                this.actionBtn.visible = false;
                this.linkBtn.label = param1.linkBtnLabel;
                this.linkBtn.validateNow();
                this.linkBtn.visible = true;
                this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            else if(param1.hasActionBtn)
            {
                this.linkBtn.visible = false;
                this.actionBtn.label = param1.actionBtnLabel;
                this.actionBtn.validateNow();
                this.actionBtn.visible = true;
                this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            else
            {
                this.linkBtn.visible = false;
                this.actionBtn.visible = false;
            }
        }

        public function updateCardSize(param1:Rectangle) : void
        {
            this._cardBounds = param1;
            this.setBtnPosition(this.linkBtn);
            this.setBtnPosition(this.actionBtn);
        }

        public function updateTimeLimit(param1:Boolean) : void
        {
            this.linkBtn.enabled = !param1;
            this.actionBtn.enabled = !param1;
        }

        private function clearTween() : void
        {
            if(this._showTween != null)
            {
                this._showTween.dispose();
                this._showTween = null;
            }
        }

        private function cleaUpSeparators() : void
        {
            var _loc1_:DisplayObject = null;
            if(this.separators != null)
            {
                for each(_loc1_ in this.separators)
                {
                    this.removeChild(_loc1_);
                    _loc1_.x = _loc1_.y = 0;
                    IDisposable(_loc1_).dispose();
                }
                this.separators.splice(0,this.separators.length);
                this.separators = null;
            }
        }

        private function clearBlocks() : void
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:ITooltipBlock = null;
            if(this._blocks != null)
            {
                for each(_loc2_ in this._blocks)
                {
                    _loc2_.removeEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
                    this.removeChild(_loc2_.getDisplayObject());
                    _loc1_ = _loc2_.getBg();
                    if(_loc1_ != null)
                    {
                        removeChild(_loc1_);
                    }
                    _loc2_.dispose();
                }
                this._blocks.fixed = false;
                this._blocks.splice(0,this._blocks.length);
                this._blocks = null;
            }
        }

        private function setBtnPosition(param1:IUIComponentEx) : void
        {
            param1.x = (this._cardBounds.width - param1.actualWidth >> 1) + this._cardBounds.left - this.x ^ 0;
        }

        private function createSeparator() : DisplayObject
        {
            var _loc1_:DashLine = this._utils.classFactory.getComponent(DASHLINE_UI_LINKAGE,DashLine);
            _loc1_.x = this.contentMargin.left + SEPARATOR_OFFSET;
            _loc1_.width = SEPARATOR_WIDTH;
            this.addChild(DisplayObject(_loc1_));
            return _loc1_;
        }

        private function buildBlocks() : void
        {
            var _loc1_:ITooltipBlock = null;
            var _loc2_:DisplayObject = null;
            var _loc5_:BlockDataItemVO = null;
            var _loc9_:PaddingVO = null;
            var _loc11_:DisplayObjectContainer = null;
            this.separators = new Vector.<DisplayObject>();
            var _loc3_:Vector.<BlockDataItemVO> = this._inBlocksData.blocksData;
            var _loc4_:int = _loc3_.length;
            var _loc6_:Number = this._inBlocksData.width;
            var _loc7_:Number = _loc6_ - (this.contentMargin.left + this.contentMargin.right);
            var _loc8_:TooltipInBlocksUtils = TooltipInBlocksUtils.instance;
            this._blocks = new Vector.<ITooltipBlock>(_loc4_,true);
            var _loc10_:* = 0;
            while(_loc10_ < _loc4_)
            {
                _loc5_ = _loc3_[_loc10_];
                _loc9_ = _loc5_.padding;
                if(_loc10_ > 0)
                {
                    this.separators.push(this.createSeparator());
                }
                _loc1_ = _loc8_.createBlock(_loc5_.linkage);
                this._blocks[_loc10_] = _loc1_;
                if(_loc6_ > 0)
                {
                    _loc1_.setBlockWidth(_loc7_ - (_loc9_ != null?_loc9_.left + _loc9_.right:0.0));
                }
                _loc1_.setBlockData(_loc5_.data);
                _loc1_.addEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
                _loc2_ = _loc1_.getDisplayObject();
                _loc11_ = _loc2_ as DisplayObjectContainer;
                if(_loc11_)
                {
                    _loc11_.mouseChildren = _loc11_.mouseEnabled = false;
                }
                this.addChild(_loc2_);
                _loc10_++;
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

        private function onTweenCompleteHandler() : void
        {
            this.clearTween();
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

        private function unscheduleValidation() : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this._validationScheduled = false;
        }

        private function rearrangeBlocks() : void
        {
            var _loc3_:DisplayObject = null;
            var _loc4_:ITooltipBlock = null;
            var _loc5_:DisplayObject = null;
            var _loc6_:DisplayObject = null;
            var _loc7_:* = NaN;
            var _loc10_:* = 0;
            var _loc13_:PaddingVO = null;
            var _loc14_:* = false;
            var _loc15_:* = false;
            var _loc16_:* = false;
            var _loc1_:Number = this._inBlocksData != null?this._inBlocksData.marginAfterBlock:0;
            var _loc2_:Number = this._inBlocksData != null?this._inBlocksData.marginAfterSeparator:0;
            this.topPosition = this.contentMargin.top;
            var _loc8_:Number = this.contentMargin.left | 0;
            var _loc9_:int = this._blocks.length;
            var _loc11_:Number = this.width + this.contentMargin.left + this.contentMargin.right;
            var _loc12_:Vector.<BlockDataItemVO> = this._inBlocksData.blocksData;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
                _loc7_ = this.topPosition;
                if(_loc10_ > 0)
                {
                    _loc3_ = this.separators[_loc10_ - 1];
                    _loc3_.y = this.topPosition | 0;
                    this.topPosition = this.topPosition + _loc2_;
                }
                _loc4_ = this._blocks[_loc10_];
                _loc5_ = _loc4_.getDisplayObject();
                _loc13_ = _loc12_[_loc10_].padding;
                _loc14_ = _loc13_ != null;
                this.topPosition = this.topPosition + (_loc14_?_loc13_.top:0.0);
                _loc5_.x = _loc8_ + (_loc14_?_loc13_.left:0.0);
                _loc5_.y = this.topPosition | 0;
                _loc15_ = _loc10_ == _loc9_ - 1;
                this.topPosition = this.topPosition + (_loc4_.getHeight() + (_loc15_?0:_loc1_) + (_loc14_?_loc13_.bottom:0.0));
                _loc6_ = _loc4_.getBg();
                _loc16_ = _loc4_.getStretchBg();
                if(_loc6_ != null)
                {
                    _loc6_.x = _loc16_?0:_loc8_;
                    _loc6_.y = _loc7_ | 0;
                    if(_loc16_)
                    {
                        _loc6_.width = _loc11_;
                        _loc6_.height = this.topPosition - _loc7_;
                        if(_loc15_)
                        {
                            _loc6_.height = _loc6_.height + this.contentMargin.bottom;
                        }
                    }
                }
                _loc10_++;
            }
        }

        private function scheduleValidation() : void
        {
            if(!this._validationScheduled)
            {
                addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                this._validationScheduled = true;
            }
        }

        private function isBlocksBuilt() : Boolean
        {
            return this._blocks != null && this._blocks.length > 0;
        }

        private function show() : void
        {
            visible = true;
            this._showTween = new Tween(SHOW_TWEEN_DURATION,this,{"alpha":1},{
                "ease":Cubic.easeInOut,
                "paused":false,
                "onComplete":this.onTweenCompleteHandler
            });
        }

        private function onActionBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ACTION_CLICK,Values.EMPTY_STR,Values.EMPTY_STR));
        }

        private function onEnterFrameHandler(param1:Event) : void
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
                this.unscheduleValidation();
                this.rearrangeBlocks();
                this.show();
            }
        }

        private function onBlockSizeChangeHandler(param1:ToolTipBlockEvent) : void
        {
            this.scheduleValidation();
        }
    }
}
