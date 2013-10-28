package net.wg.data.components
{
   import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.daapi.PlayerInfo;
   import org.idmedia.as3commons.util.Map;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.data.constants.Errors;


   public class AbstractContextItemGenerator extends Object implements IUserContextMenuGenerator
   {
          
      public function AbstractContextItemGenerator() {
         super();
      }

      private var _isEnabledInRoaming:Boolean = true;

      public function generateData(param1:PlayerInfo, param2:Number=NaN) : Vector.<IContextItem> {
         this.isEnabledInRoaming = param1.isEnabledInRoaming;
         return this.getContextItems(param1,this.getSimpleDataIDs);
      }

      protected function getDenunciationsSubmenu(param1:Number, param2:PlayerInfo, param3:Boolean=false) : IContextItem {
         var _loc4_:* = "appeal";
         var _loc5_:* = App.utils.locale.makeString(MENU.CONTEXTMENU_APPEAL) + " (" + param1 + ")";
         var _loc6_:* = !(param1 == 0 || (param3));
         var _loc7_:Vector.<IContextItem> = this.getContextItems(param2,this.getDenunciationsIDs);
         var _loc8_:IContextItem = new ContextItem(_loc4_,_loc5_,{"enabled":_loc6_},_loc7_);
         return _loc8_;
      }

      protected function getContextItems(param1:PlayerInfo, param2:Function) : Vector.<IContextItem> {
         var _loc5_:String = null;
         var _loc3_:Vector.<IContextItem> = new Vector.<IContextItem>();
         var _loc4_:Map = param2(param1);
         for each (_loc5_ in _loc4_.keySet().toArray())
         {
            if(_loc5_ != Values.EMPTY_STR)
            {
               _loc3_.push(new UserContextItem(_loc5_,_loc4_.get(_loc5_)));
            }
         }
         return _loc3_;
      }

      protected function getDenunciationsIDs(param1:PlayerInfo) : Map {
         throw new AbstractException("getDenunciationsIDs" + Errors.ABSTRACT_INVOKE);
      }

      protected function getSimpleDataIDs(param1:PlayerInfo) : Map {
         var _loc2_:String = param1.isFriend?"removeFromFriends":"addToFriends";
         var _loc3_:String = param1.isIgnored?"removeFromIgnored":"addToIgnored";
         var _loc4_:String = param1.isFriend?"createPrivateChannel":Values.EMPTY_STR;
         var _loc5_:String = Values.EMPTY_STR;
         if(App.voiceChatMgr.isVOIPEnabledS())
         {
            _loc5_ = param1.isMuted?"unsetMuted":"setMuted";
         }
         return this.createSimpleDataIDs(_loc4_,_loc2_,_loc3_,_loc5_);
      }

      protected function createSimpleDataIDs(param1:String, param2:String, param3:String, param4:String) : Map {
         throw new AbstractException("createSimpleDataIDs" + Errors.ABSTRACT_INVOKE);
      }

      public function get isEnabledInRoaming() : Boolean {
         return this._isEnabledInRoaming;
      }

      public function set isEnabledInRoaming(param1:Boolean) : void {
         this._isEnabledInRoaming = param1;
      }
   }

}