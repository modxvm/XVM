package net.wg.gui.components.paginator
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.display.MovieClip;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
    import flash.utils.Dictionary;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.MISSIONS_STATES;
    import flash.text.TextFormat;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundTypes;

    public class PaginationDetailsNumButton extends SoundListItemRenderer implements IUpdatable
    {

        private static const STATE_INACTIVE:String = "inactive";

        private static const STATE_COMPLETED:String = "completed";

        private static const STATE_NA:String = "notavailable";

        private static const STATE_SELECTED:String = "selected";

        private static const COL_NORMAL_STATE_INACTIVE:int = 9211004;

        private static const COL_NORMAL_STATE_COMPLETED:int = 8442938;

        private static const COL_NORMAL_STATE_NA:int = 16721687;

        private static const COL_NORMAL_STATE_SELECTED:int = 15327935;

        private static const COL_HOVER_STATE_INACTIVE:int = 15327935;

        private static const COL_HOVER_STATE_COMPLETED:int = 8442938;

        private static const COL_HOVER_STATE_NA:int = 16721687;

        private static const COL_HOVER_STATE_SELECTED:int = 15327935;

        private static const STATE_OVER:String = "over";

        private static const STATE_DOWN:String = "down";

        public var bg:MovieClip;

        private var _tooltipMgr:ITooltipMgr;

        private var _vo:PaginatorPageNumVO;

        private var _colorNormal:Dictionary;

        private var _colorHover:Dictionary;

        private var _isDisabled:Boolean = false;

        public function PaginationDetailsNumButton()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
            soundType = SoundTypes.PAGINATION_NUM_ITEM_RENDERER;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._vo && isInvalid(InvalidationType.DATA))
            {
                groupName = this._vo.buttonsGroup;
                this._isDisabled = this._vo.status == MISSIONS_STATES.DISABLED;
                useHandCursor = buttonMode = !this._isDisabled;
            }
        }

        override protected function updateAfterStateChange() : void
        {
            var _loc1_:TextFormat = null;
            var _loc2_:* = 0;
            var _loc3_:String = null;
            super.updateAfterStateChange();
            if(this._vo)
            {
                _loc1_ = textField.defaultTextFormat;
                _loc3_ = STATE_INACTIVE;
                if(this._vo.status == MISSIONS_STATES.COMPLETED || this._vo.status == MISSIONS_STATES.FULL_COMPLETED)
                {
                    _loc3_ = STATE_COMPLETED;
                }
                else if(this._vo.status == MISSIONS_STATES.NOT_AVAILABLE || this._vo.status == MISSIONS_STATES.DISABLED)
                {
                    _loc3_ = STATE_NA;
                }
                this.bg.gotoAndStop(_loc3_);
                if(_baseDisposed)
                {
                    return;
                }
                if(selected)
                {
                    _loc3_ = STATE_SELECTED;
                }
                if(selected || _state == STATE_OVER || _state == STATE_DOWN)
                {
                    _loc2_ = this._colorHover[_loc3_];
                }
                else
                {
                    _loc2_ = this._colorNormal[_loc3_];
                }
                _loc1_.color = _loc2_;
                textField.text = this._vo.label;
                textField.setTextFormat(_loc1_);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            enabled = true;
            toggle = true;
            allowDeselect = false;
        }

        override protected function onDispose() : void
        {
            App.utils.data.cleanupDynamicObject(this._colorNormal);
            this._colorNormal = null;
            App.utils.data.cleanupDynamicObject(this._colorHover);
            this._colorHover = null;
            removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this._tooltipMgr = null;
            this._vo = null;
            this.bg = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._colorNormal = new Dictionary();
            this._colorNormal[STATE_INACTIVE] = COL_NORMAL_STATE_INACTIVE;
            this._colorNormal[STATE_COMPLETED] = COL_NORMAL_STATE_COMPLETED;
            this._colorNormal[STATE_NA] = COL_NORMAL_STATE_NA;
            this._colorNormal[STATE_SELECTED] = COL_NORMAL_STATE_SELECTED;
            this._colorHover = new Dictionary();
            this._colorHover[STATE_INACTIVE] = COL_HOVER_STATE_INACTIVE;
            this._colorHover[STATE_COMPLETED] = COL_HOVER_STATE_COMPLETED;
            this._colorHover[STATE_NA] = COL_HOVER_STATE_NA;
            this._colorHover[STATE_SELECTED] = COL_HOVER_STATE_SELECTED;
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            if(!this._isDisabled)
            {
                super.handleClick(param1);
            }
        }

        override protected function setState(param1:String) : void
        {
            if(!this._isDisabled)
            {
                super.setState(param1);
            }
        }

        public function showTooltip() : void
        {
            if(this._vo.tooltip == null)
            {
                return;
            }
            if(this._vo.tooltip.isSpecial)
            {
                this._tooltipMgr.showSpecial.apply(this,[this._vo.tooltip.specialAlias,null].concat(this._vo.tooltip.specialArgs));
            }
            else
            {
                this._tooltipMgr.showComplex(this._vo.tooltip.tooltip);
            }
        }

        public function update(param1:Object) : void
        {
            this._vo = PaginatorPageNumVO(param1);
            super.data = param1;
            invalidateState();
        }

        public function get pageIndex() : int
        {
            return this._vo.pageIndex;
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            this.showTooltip();
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
