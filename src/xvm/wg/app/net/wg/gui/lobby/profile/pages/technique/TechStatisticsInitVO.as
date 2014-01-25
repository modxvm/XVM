package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class TechStatisticsInitVO extends DAAPIDataClass
   {
          
      public function TechStatisticsInitVO(param1:Object) {
         super(param1);
      }

      public var hangarVehiclesLabel:String = "";

      public var isInHangarSelected:Boolean;
   }

}