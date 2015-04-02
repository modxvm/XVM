package com.xvm.controls
{
    import com.xvm.components.*;
    import scaleform.clik.data.*;

    public class LevelMultiSelectionDropDown extends MultiSelectionDropDown
    {
        public function LevelMultiSelectionDropDown()
        {
            super();

            var dp:Array = [];
            for (var i:int = 1; i <= 10; ++i)
            {
                dp.push({
                    label: "",
                    icon: "../maps/icons/levels/tank_level_" + i + ".png",
                    data: i
                });
            }
            dataProvider = new DataProvider(dp);

            icon.source = "../maps/icons/buttons/tab_sort_button/level.png";
            menuRowCount = dataProvider.length;
            menuDirection = "up";
        }

    }

}
