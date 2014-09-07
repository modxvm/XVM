package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.gui.components.controls.DropdownMenu;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.interfaces.IDataProvider;
    
    public class FortPeriodDefenceWindowHelper extends Object
    {
        
        public function FortPeriodDefenceWindowHelper()
        {
            super();
        }
        
        public function setDataInDropDown(param1:DropdownMenu, param2:Array, param3:int) : void
        {
            var _loc4_:* = 0;
            var _loc5_:String = null;
            if(param3 == -1)
            {
                param2.unshift(App.utils.locale.makeString(FORTIFICATIONS.PERIODDEFENCEWINDOW_DROPDOWNBTN_NOTSELECTED));
            }
            param1.dataProvider = new DataProvider(param2);
            if(param3 == -1)
            {
                param1.selectedIndex = 0;
            }
            else
            {
                _loc4_ = 0;
                while(_loc4_ < param2.length)
                {
                    if(param2[_loc4_].id == param3)
                    {
                        break;
                    }
                    _loc4_++;
                }
                _loc5_ = "No such elemnt with id = " + param3 + " in dropDown.dataProvider";
                App.utils.asserter.assert(_loc4_ < param2.length,_loc5_);
                param1.selectedIndex = _loc4_;
            }
        }
        
        public function removeDefaultDataDropDown(param1:int, param2:DropdownMenu) : void
        {
            var _loc3_:IDataProvider = param2.dataProvider;
            var _loc4_:int = _loc3_.indexOf(App.utils.locale.makeString(FORTIFICATIONS.PERIODDEFENCEWINDOW_DROPDOWNBTN_NOTSELECTED));
            if(!(param1 == 0) && !(_loc4_ == -1))
            {
                (_loc3_ as Array).splice(_loc4_,1);
                param2.rowCount = param2.rowCount - 1;
                param2.selectedIndex = param2.selectedIndex - 1;
            }
        }
    }
}
