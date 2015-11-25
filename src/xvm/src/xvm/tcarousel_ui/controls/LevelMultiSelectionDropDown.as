/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui.controls
{
    import com.xvm.*;
    import scaleform.clik.data.*;
    import xvm.tcarousel_ui.components.*;

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
