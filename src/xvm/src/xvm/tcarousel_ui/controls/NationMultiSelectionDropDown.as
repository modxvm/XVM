/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package vm.tcarousel_ui.controls
{
    import com.xvm.*;
    import com.xvm.components.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;

    public class NationMultiSelectionDropDown extends MultiSelectionDropDown
    {
        public static const FILTER_ALL_NATION:Number=-1;

        public function NationMultiSelectionDropDown()
        {
            super();

            var nations:INations = App.utils.nations;
            var nationsData:Array = nations.getNationsData();
            var dp:Array = [ ];
            for (var i:int = 0; i < nationsData.length; ++i)
            {
                var item:Object = nationsData[i];
                item["icon"] = "../maps/icons/filters/nations/" + nations.getNationName(item["data"]) + ".png";
                dp.push(item);
            }
            dataProvider = new DataProvider(dp);

            icon.source = "../maps/icons/filters/nations/all.png";
            menuRowCount = dataProvider.length;
            menuDirection = "up";
        }
    }
}
