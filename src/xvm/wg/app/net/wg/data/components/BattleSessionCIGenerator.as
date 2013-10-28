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

      override protected function createSimpleDataIDs(param1:String, param2:String, param3:String, param4:String) : Map {
         return App.utils.commons.createMap(["userInfo",{},param1,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},param2,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},param3,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},"copyToClipBoard",{},param4,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},"kickPlayer",{"enabled":this._canKickPlayer}]);
      }
   }

}