package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.NormalSortingButton;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.interfaces.IUIComponent;
    import scaleform.clik.controls.Button;

    public class SortableHeaderButtonBar extends ButtonBarEx
    {

        private static const BTN_ENABLING_CHANGED:String = "btnEnablingChanged";

        private static const SORT_DIRECTION_INVALID:String = "sortDirectionInvalid";

        private var _lastChangedButton:BtnEnablingData = null;

        private var _sortDirection:String = "";

        public function SortableHeaderButtonBar()
        {
            super();
        }

        override protected function draw() : void
        {
            var _loc1_:NormalSortingButton = null;
            super.draw();
            if(this._lastChangedButton && isInvalid(BTN_ENABLING_CHANGED))
            {
                getButtonAt(this._lastChangedButton.index).enabled = this._lastChangedButton.enabled;
            }
            if(StringUtils.isNotEmpty(this._sortDirection) && isInvalid(SORT_DIRECTION_INVALID))
            {
                _loc1_ = NormalSortingButton(getButtonAt(selectedIndex));
                _loc1_.sortDirection = this._sortDirection;
            }
        }

        override protected function onDispose() : void
        {
            this._lastChangedButton = null;
            super.onDispose();
        }

        public function enableButtonAt(param1:Boolean, param2:int) : void
        {
            if(this._lastChangedButton != null)
            {
                if(this._lastChangedButton.index != param2 || this._lastChangedButton.enabled != param1)
                {
                    this._lastChangedButton.index = param2;
                    this._lastChangedButton.enabled = param1;
                    invalidate(BTN_ENABLING_CHANGED);
                }
            }
            else
            {
                this._lastChangedButton = new BtnEnablingData(param2,param1);
                invalidate(BTN_ENABLING_CHANGED);
            }
        }

        public function hasEnabledRenderers() : Boolean
        {
            var _loc1_:int = this.renderersCount;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                if(IUIComponent(_renderers[_loc2_]).enabled)
                {
                    return true;
                }
                _loc2_++;
            }
            return false;
        }

        public function updateButtonsEnabledState(param1:Boolean) : void
        {
            var _loc2_:Button = null;
            for each(_loc2_ in _renderers)
            {
                _loc2_.enabled = param1 && SortingButtonVO(_loc2_.data).enabled;
            }
        }

        public function set sortDirection(param1:String) : void
        {
            this._sortDirection = param1;
            invalidate(SORT_DIRECTION_INVALID);
        }

        public function get renderersCount() : int
        {
            return _renderers?_renderers.length:-1;
        }
    }
}

class BtnEnablingData extends Object
{

    public var index:int;

    public var enabled:Boolean;

    function BtnEnablingData(param1:int, param2:Boolean)
    {
        super();
        this.index = param1;
        this.enabled = param2;
    }
}
