package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.data.managers.impl.*;
    
    public class StatisticsChartsUtils extends Object
    {
        public function StatisticsChartsUtils()
        {
            super();
            return;
        }

        public static function showTypeTooltip(arg1:Object, arg2:String):void
        {
            var loc1:*={};
            if (arg1 && arg1.hasOwnProperty("xField")) 
            {
                loc1.value = App.utils.locale.makeString(DIALOGS.vehicleselldialog_vehicletype(arg1["xField"]));
            }
            App.toolTipMgr.showComplexWithParams(arg2, new net.wg.data.managers.impl.ToolTipParams(loc1, {}));
            return;
        }

        public static function showNationTooltip(arg1:Object, arg2:String):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*={};
            if (arg1 && arg1.hasOwnProperty("xField")) 
            {
                loc2 = App.utils.nations.getNationsData();
                loc3 = arg1["xField"];
                var loc5:*=0;
                var loc6:*=loc2;
                for each (loc4 in loc6) 
                {
                    if (loc4.data != loc3) 
                    {
                        continue;
                    }
                    loc1.value = App.utils.locale.makeString(loc4.label);
                    break;
                }
            }
            App.toolTipMgr.showComplexWithParams(arg2, new net.wg.data.managers.impl.ToolTipParams(loc1, {}));
            return;
        }

        public static function showLevelTooltip(arg1:Object, arg2:String):void
        {
            var loc1:*=null;
            if (arg2) 
            {
                loc1 = {};
                if (arg1 && arg1.hasOwnProperty("xField")) 
                {
                    loc1.value = arg1["xField"].toString();
                }
                App.toolTipMgr.showComplexWithParams(arg2, new net.wg.data.managers.impl.ToolTipParams(loc1, {}));
            }
            return;
        }
    }
}
