/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniqueWindow extends Technique
    {
        public function TechniqueWindow(window:ProfileTechniqueWindow, playerName:String, accountDBID:int):void
        {
            super(window, playerName, accountDBID);
        }

//        override protected function createFilters():void
//        {
//            super.createFilters();
//
//            filter.visible = false;
//            filter.x = 680;
//            filter.y = -47;
//        }
    }
}
