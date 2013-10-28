package net.wg.gui.prebattle.squad
{
   import net.wg.data.components.ContextItemGenerator;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.daapi.PlayerInfo;
   import org.idmedia.as3commons.util.Map;


   public class SquadWindowCIGenerator extends ContextItemGenerator
   {
          
      public function SquadWindowCIGenerator(param1:Boolean, param2:Boolean, param3:Boolean=false) {
         super();
         this._isOnline = param1;
         this._canKickPlayer = param2;
         this._enableDeninciations = param3;
      }

      private var _isOnline:Boolean = false;

      private var _canKickPlayer:Boolean = false;

      private var _enableDeninciations:Boolean = false;

      override public function generateData(param1:PlayerInfo, param2:Number=NaN) : Vector.<IContextItem> {
         var _loc3_:Vector.<IContextItem> = super.generateData(param1);
         _loc3_.splice(1,0,getDenunciationsSubmenu(param2,param1,!this._enableDeninciations));
         return _loc3_;
      }

      override protected function createSimpleDataIDs(param1:String, param2:String, param3:String, param4:String) : Map {
         return App.utils.commons.createMap(["userInfo",{},param1,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},param2,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},param3,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},"copyToClipBoard",{},param4,{"enabled":(isEnabledInRoaming?this._isOnline:isEnabledInRoaming)},"kickPlayer",{"enabled":this._canKickPlayer}]);
      }
   }

}