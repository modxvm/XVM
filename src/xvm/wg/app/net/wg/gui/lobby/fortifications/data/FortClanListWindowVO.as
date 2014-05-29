package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class FortClanListWindowVO extends DAAPIDataClass
   {
          
      public function FortClanListWindowVO(param1:Object) {
         this._members = [];
         super(param1);
      }

      private static const MEMBERS:String = "members";

      private var _windowTitle:String = "";

      private var _members:Array;

      public function get windowTitle() : String {
         return this._windowTitle;
      }

      public function set windowTitle(param1:String) : void {
         this._windowTitle = param1;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Object = null;
         var _loc4_:ClanListRendererVO = null;
         if(param1 == MEMBERS)
         {
            for each (_loc3_ in param2)
            {
               _loc4_ = new ClanListRendererVO(_loc3_);
               this._members.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }

      override protected function onDispose() : void {
         var _loc1_:FortClanMemberVO = null;
         for each (_loc1_ in this._members)
         {
            _loc1_.dispose();
         }
         this._members.splice(0,this._members.length);
         super.onDispose();
      }

      public function get members() : Array {
         return this._members;
      }

      public function set members(param1:Array) : void {
         this._members = param1;
      }
   }

}