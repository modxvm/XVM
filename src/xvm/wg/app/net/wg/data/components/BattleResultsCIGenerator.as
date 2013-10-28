package net.wg.data.components
{
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.daapi.PlayerInfo;


   public class BattleResultsCIGenerator extends ContextItemGenerator
   {
          
      public function BattleResultsCIGenerator(param1:Boolean) {
         super();
         this._isOwnSquad = param1;
      }

      private var _isOwnSquad:Boolean;

      public function get isOwnSquad() : Boolean {
         return this._isOwnSquad;
      }

      public function set isOwnSquad(param1:Boolean) : void {
         this._isOwnSquad = param1;
      }

      override public function generateData(param1:PlayerInfo, param2:Number=NaN) : Vector.<IContextItem> {
         var _loc3_:Vector.<IContextItem> = super.generateData(param1);
         _loc3_.splice(1,0,getDenunciationsSubmenu(param2,param1,this.isOwnSquad));
         return _loc3_;
      }
   }

}