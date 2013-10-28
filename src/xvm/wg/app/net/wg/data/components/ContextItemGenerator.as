package net.wg.data.components
{
   import org.idmedia.as3commons.util.Map;
   import net.wg.data.daapi.PlayerInfo;


   public class ContextItemGenerator extends AbstractContextItemGenerator
   {
          
      public function ContextItemGenerator() {
         super();
      }

      override protected function getDenunciationsIDs(param1:PlayerInfo) : Map {
         return App.utils.commons.createMap(["offend",{},"flood",{},"openingOfAllyPos",{},"allyEjection",{},"notFairPlay",{},"teamKill",{},"bot",{}]);
      }

      override protected function createSimpleDataIDs(param1:String, param2:String, param3:String, param4:String) : Map {
         return App.utils.commons.createMap(["userInfo",{},param1,{"enabled":isEnabledInRoaming},param2,{"enabled":isEnabledInRoaming},param3,{},"copyToClipBoard",{},param4,{}]);
      }
   }

}