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
         return App.utils.commons.createMap(["offend",{},"flood",{},"blackmail",{},"swindle",{},"notFairPlay",{},"forbiddenNick",{},"bot",{}]);
      }

      override protected function createSimpleDataIDs(param1:PlayerInfo, param2:String, param3:String, param4:String, param5:String) : Map {
         return App.utils.commons.createMap(["userInfo",{},param2,{"enabled":(param1.canCreateChannel) && (param1.isFriend)},param3,{"enabled":param1.canAddToFriend},param4,{},"copyToClipBoard",{},param5,{}]);
      }
   }

}