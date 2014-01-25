package net.wg.gui.cyberSport.helpers
{
   import net.wg.data.components.ContextItemGenerator;
   import org.idmedia.as3commons.util.Map;
   import net.wg.data.daapi.PlayerInfo;


   public class CSPlayerCIGenerator extends ContextItemGenerator
   {
          
      public function CSPlayerCIGenerator(param1:Boolean=false) {
         this.canKickPlayer = param1;
         super();
      }

      public var canKickPlayer:Boolean;

      override protected function createSimpleDataIDs(param1:PlayerInfo, param2:String, param3:String, param4:String, param5:String) : Map {
         var _loc6_:Map = super.createSimpleDataIDs(param1,param2,param3,param4,param5);
         if(this.canKickPlayer)
         {
            _loc6_.put("kickPlayer",{"enabled":true});
         }
         return _loc6_;
      }
   }

}