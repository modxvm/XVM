package net.wg.gui.lobby.profile.headerBar
{
    import net.wg.gui.components.advanced.ButtonBarEx;
    import scaleform.clik.controls.Button;
    import flash.display.DisplayObject;
    
    public class ProfileHeaderButtonBar extends ButtonBarEx
    {
        
        public function ProfileHeaderButtonBar() {
            super();
            spacing = 10;
        }
        
        override protected function populateRendererData(param1:Button, param2:uint) : void {
            super.populateRendererData(param1,param2);
            if(param2 == _dataProvider.length - 1)
            {
                if(param1 is ProfileTabButton)
                {
                    ProfileTabButton(param1).showLastLineItem = true;
                }
            }
            param1.validateNow();
        }
        
        override public function set selectedIndex(param1:int) : void {
            if(param1 == _selectedIndex)
            {
                return;
            }
            super.selectedIndex = param1;
            var _loc2_:DisplayObject = _renderers[_selectedIndex];
            if(_loc2_)
            {
                _loc2_.parent.setChildIndex(_loc2_,_loc2_.parent.numChildren - 1);
            }
        }
    }
}
