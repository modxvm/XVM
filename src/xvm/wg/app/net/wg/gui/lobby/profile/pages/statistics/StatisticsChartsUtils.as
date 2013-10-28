package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.managers.impl.ToolTipParams;


   public class StatisticsChartsUtils extends Object
   {
          
      public function StatisticsChartsUtils() {
         super();
      }

      public static function showTypeTooltip(param1:Object, param2:String) : void {
         var _loc3_:Object = {};
         if((param1) && (param1.hasOwnProperty("xField")))
         {
            _loc3_.value = App.utils.locale.makeString(DIALOGS.vehicleselldialog_vehicletype(param1["xField"]));
         }
         App.toolTipMgr.showComplexWithParams(param2,new ToolTipParams(_loc3_,{}));
      }

      public static function showNationTooltip(param1:Object, param2:String) : void {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc3_:Object = {};
         if((param1) && (param1.hasOwnProperty("xField")))
         {
            _loc4_ = App.utils.nations.getNationsData();
            _loc5_ = param1["xField"];
            for each (_loc6_ in _loc4_)
            {
               if(_loc6_.data == _loc5_)
               {
                  _loc3_.value = App.utils.locale.makeString(_loc6_.label);
                  break;
               }
            }
         }
         App.toolTipMgr.showComplexWithParams(param2,new ToolTipParams(_loc3_,{}));
      }

      public static function showLevelTooltip(param1:Object, param2:String) : void {
         var _loc3_:Object = null;
         if(param2)
         {
            _loc3_ = {};
            if((param1) && (param1.hasOwnProperty("xField")))
            {
               _loc3_.value = param1["xField"].toString();
            }
            App.toolTipMgr.showComplexWithParams(param2,new ToolTipParams(_loc3_,{}));
         }
      }
   }

}