package net.wg.data.components
{
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.daapi.PlayerInfo;
   import org.idmedia.as3commons.util.Map;


   public class BattleSessionCIGenerator extends ContextItemGenerator
   {
          
      public function BattleSessionCIGenerator(param1:Boolean, param2:Boolean) {
         super();
         this._isOnline = param1;
         this._canKickPlayer = param2;
      }

      private var _isOnline:Boolean = false;

      private var _canKickPlayer:Boolean = false;

      override public function generateData(param1:PlayerInfo, param2:Number=NaN) : Vector.<IContextItem> {
         var _loc3_:Vector.<IContextItem> = super.generateData(param1);
         _loc3_.splice(1,0,getDenunciationsSubmenu(param2,param1));
         return _loc3_;
      }

      override protected function createSimpleDataIDs(param1:PlayerInfo, param2:String, param3:String, param4:String, param5:String) : Map {
         var _loc6_:Boolean = (param1.canCreateChannel?this._isOnline:param1.canCreateChannel) && (param1.isFriend);
         return App.utils.commons.createMap(["userInfo",{},param2,{"enabled":_loc6_},param3,{"enabled":(param1.canAddToFriend?this._isOnline:param1.canAddToFriend)},param4,{"enabled":param1.canAddToIgnore},"copyToClipBoard",{},param5,{"enabled":this._isOnline},"kickPlayerFromPrebattle",{"enabled":this._canKickPlayer}]);
      }
   }

}