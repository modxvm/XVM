package net.wg.gui.prebattle.company 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    
    public class GroupPlayersDropDownMenu extends net.wg.gui.components.controls.DropdownMenu
    {
        public function GroupPlayersDropDownMenu()
        {
            super();
            return;
        }

        public function set prbID(arg1:int):void
        {
            this._prbID = arg1;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (_dropdownRef) 
                _dropdownRef.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onClickDropDownMenu, false);
            return;
        }

        protected override function showDropdown():void
        {
            super.showDropdown();
            _dropdownRef.buttonMode = true;
            _dropdownRef.mouseEnabled = true;
            _dropdownRef.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onClickDropDownMenu, false, 1110, true);
            return;
        }

        internal function onClickDropDownMenu(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.wg.gui.prebattle.company.CompanyEvent(net.wg.gui.prebattle.company.CompanyEvent.DROP_LIST_CLICK, true);
            loc1.prbID = this._prbID;
            dispatchEvent(loc1);
            return;
        }

        public override function open():void
        {
            selected = true;
            this.showDropdown();
            return;
        }

        protected override function changeFocus():void
        {
            return;
        }

        public override function close():void
        {
            selected = false;
            hideDropdown();
            return;
        }

        internal var _prbID:int;
    }
}
