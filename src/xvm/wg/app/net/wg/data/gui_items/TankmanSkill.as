package net.wg.data.gui_items
{
   import net.wg.data.constants.ItemTypes;
   
   public class TankmanSkill extends GUIItem
   {
      
      public function TankmanSkill(param1:String, param2:int = -1) {
         super(ItemTypes.TANKMAN_SKILL,[param1,param2]);
         this._skillName = param1;
         this._tankmanID = param2;
      }
      
      private var _skillName:String;
      
      private var _tankmanID:int;
      
      public function get skillName() : String {
         return this._skillName;
      }
      
      public function get tankmanID() : int {
         return this._tankmanID;
      }
      
      public function get isPerk() : Boolean {
         return Boolean(_getAttr("isPerk"));
      }
      
      public function get level() : uint {
         return uint(_getAttr("level"));
      }
      
      public function get roleType() : String {
         return String(_getAttr("roleType"));
      }
      
      public function get isActive() : Boolean {
         return Boolean(_getAttr("isActive"));
      }
      
      public function get userName() : String {
         return String(_getAttr("userName"));
      }
      
      public function get description() : String {
         return String(_getAttr("description"));
      }
      
      public function get shortDescription() : String {
         return String(_getAttr("shortDescription"));
      }
      
      public function get icon() : String {
         return String(_getAttr("icon"));
      }
   }
}
