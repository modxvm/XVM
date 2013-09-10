package net.wg.gui.components.controls 
{
    import scaleform.clik.data.*;
    
    public class NationDropDownMenu extends net.wg.gui.components.controls.DropdownMenu
    {
        public function NationDropDownMenu()
        {
            super();
            return;
        }

        public function createNationFilter(arg1:Array):void
        {
            var loc2:*=null;
            var loc1:*=[{"label":MENU.NATIONS_ALL, "data":-1}];
            while (arg1.length > 0) 
            {
                loc2 = {"label":MENU.nations(arg1.shift()), "data":arg1.shift()};
                loc1.push(loc2);
            }
            this.setStaticData(loc1);
            return;
        }

        internal function setStaticData(arg1:Array):void
        {
            dataProvider.cleanUp();
            dataProvider = new scaleform.clik.data.DataProvider(arg1);
            invalidateData();
            return;
        }
    }
}
