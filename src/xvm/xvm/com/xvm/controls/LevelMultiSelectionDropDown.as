package com.xvm.controls
{
    import com.xvm.components.*;
    import scaleform.clik.data.*;

    public class LevelMultiSelectionDropDown extends DropDown
    {
        public function LevelMultiSelectionDropDown()
        {
            super();

            var dp:Array = [ { label: "", icon: "../maps/icons/buttons/tab_sort_button/level.png", data: -1 } ];
            for (var i:Number = 1; i <= 10; i++)
                dp.push( { label: "", icon: "../maps/icons/levels/tank_level_" + i + ".png", data: i } );
            dataProvider = new DataProvider(dp);

            menuRowCount = dataProvider.length;
            selectedIndex = 0;
            menuWidth = 95;
        }

    }

}
