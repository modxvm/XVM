package net.wg.gui.ny.cmpnts
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.IndexEvent;

    public class NYButtonBarGroup extends UIComponentEx
    {

        private static const OUT_STATE:Number = 0.7;

        private static const OVER_STATE:Number = 1;

        private var _selectedIndex:int = -1;

        private var _buttons:Vector.<ISoundButtonEx>;

        private var _currentSelected:ISoundButtonEx = null;

        private var _currentShine:ISoundButtonEx = null;

        private var _isSliderDragging:Boolean = false;

        public function NYButtonBarGroup()
        {
            super();
            this._buttons = new Vector.<ISoundButtonEx>();
        }

        override protected function onDispose() : void
        {
            var _loc1_:SoundButtonEx = null;
            this._currentSelected = null;
            this._currentShine = null;
            for each(_loc1_ in this._buttons)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
                _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
                _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
            }
            this._buttons.splice(0,this._buttons.length);
            this._buttons = null;
            super.onDispose();
        }

        public function addButton(param1:ISoundButtonEx) : void
        {
            this._buttons.push(param1);
            param1.addEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
        }

        public function selectSnapValue(param1:int) : void
        {
            var _loc2_:ISoundButtonEx = this._buttons[param1];
            if(this._currentShine != _loc2_)
            {
                if(this._currentShine != null && this._currentSelected != this._currentShine)
                {
                    this._currentShine.alpha = OUT_STATE;
                }
                if(this._currentSelected != _loc2_)
                {
                    _loc2_.alpha = OVER_STATE;
                }
                this._currentShine = _loc2_;
            }
        }

        public function setData(param1:Array) : void
        {
            App.utils.asserter.assert(this._buttons.length == param1.length,"Invalid count of tooltips");
            var _loc2_:int = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._buttons[_loc3_].tooltip = param1[_loc3_];
                _loc3_++;
            }
        }

        public function setIndex(param1:int) : void
        {
            if(this._selectedIndex != param1)
            {
                this._selectedIndex = param1;
                if(this._currentSelected)
                {
                    this._currentSelected.selected = false;
                    this._currentSelected.alpha = OUT_STATE;
                }
                this._currentSelected = this._buttons[this._selectedIndex];
                this._currentSelected.selected = true;
                this._currentSelected.alpha = OVER_STATE;
                this._currentShine = this._currentSelected;
            }
        }

        override public function set enabled(param1:Boolean) : void
        {
            var _loc2_:ISoundButtonEx = null;
            super.enabled = param1;
            for each(_loc2_ in this._buttons)
            {
                _loc2_.enabled = enabled;
            }
        }

        public function set isSliderDragging(param1:Boolean) : void
        {
            this._isSliderDragging = param1;
        }

        private function onItemClickHandler(param1:ButtonEvent) : void
        {
            this.setIndex(this._buttons.indexOf(param1.target));
            dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,true,true,this._selectedIndex));
        }

        private function onItemMouseOverHandler(param1:MouseEvent) : void
        {
            if(this._isSliderDragging)
            {
                return;
            }
            if(this._currentSelected != param1.target)
            {
                param1.target.alpha = OVER_STATE;
            }
        }

        private function onItemMouseOutHandler(param1:MouseEvent) : void
        {
            if(this._isSliderDragging)
            {
                return;
            }
            if(this._currentSelected != param1.target)
            {
                param1.target.alpha = OUT_STATE;
            }
        }
    }
}
