package com.xvm.components
{
    public class DropDown extends DropDownImageText // from controls.swf
    {
        public function DropDown()
        {
            super();
            autoSize = "none";
            dropdown = "DropdownMenu_ScrollingList";
            enabled = true;
            enableInitCallback = false;
            focusable = true;
            itemRenderer = ListItemRedererImageText;
            menuDirection = "down";
            menuMargin = 2;
            inspectableMenuOffset = {top:0, right:0, bottom:4, left:3};
            inspectableMenuPadding = {top:0, right:0, bottom:-1, left:0};
            menuRowsFixed = false;
            menuWidth = 151;
            menuWrapping = "normal";
            scrollBar = "";
            showEmptyItems = false;
            inspectableThumbOffset = {top:0, bottom:0};
            visible = true;
        }
    }
}
