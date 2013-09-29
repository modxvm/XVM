package net.wg.gui.lobby.profile.headerBar 
{
    import flash.display.*;
    import net.wg.gui.components.advanced.*;
    import scaleform.clik.controls.*;
    
    public class ProfileHeaderButtonBar extends net.wg.gui.components.advanced.ButtonBarEx
    {
        public function ProfileHeaderButtonBar()
        {
            super();
            spacing = 10;
            return;
        }

        protected override function populateRendererData(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            super.populateRendererData(arg1, arg2);
            if (arg2 == (_dataProvider.length - 1)) 
            {
                if (arg1 is net.wg.gui.lobby.profile.headerBar.ProfileTabButton) 
                {
                    net.wg.gui.lobby.profile.headerBar.ProfileTabButton(arg1).showLastLineItem = true;
                }
            }
            arg1.validateNow();
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 == _selectedIndex) 
            {
                return;
            }
            super.selectedIndex = arg1;
            var loc1:*=_renderers[_selectedIndex];
            if (loc1) 
            {
                loc1.parent.setChildIndex(loc1, (loc1.parent.numChildren - 1));
            }
            return;
        }
    }
}
