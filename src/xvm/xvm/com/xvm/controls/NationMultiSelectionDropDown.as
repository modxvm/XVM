package com.xvm.controls
{
    import com.xvm.components.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;

    public class NationMultiSelectionDropDown extends DropDown
    {
        public static const FILTER_ALL_NATION:Number=-1;

        public function NationMultiSelectionDropDown()
        {
            super();

            var nations:INations = App.utils.nations;
            var nationsData:Array = nations.getNationsData();
            var dp:Array = [ { "label":MENU.NATIONS_ALL, "data":FILTER_ALL_NATION, "icon":"../maps/icons/filters/nations/all.png" } ];
            for (var i:int = 0; i < nationsData.length; ++i)
            {
                var item:Object = nationsData[i];
                item["icon"] = "../maps/icons/filters/nations/" + nations.getNationName(item["data"]) + ".png";
                dp.push(item);
            }
            dataProvider = new DataProvider(dp);

            menuRowCount = dataProvider.length;
            selectedIndex = 0;
        }
    }
}
