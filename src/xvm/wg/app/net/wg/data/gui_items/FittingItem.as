package net.wg.data.gui_items
{
   import net.wg.data.utilData.ItemPrice;


   public class FittingItem extends GUIItem
   {
          
      public function FittingItem(param1:uint, param2:uint) {
         super(param1,param2);
      }

      public function get buyPrice() : ItemPrice {
         var _loc1_:Array = _getAttr("buyPrice") as Array;
         return new ItemPrice(_loc1_[0],_loc1_[1]);
      }

      public function get sellPrice() : ItemPrice {
         var _loc1_:Array = _getAttr("sellPrice") as Array;
         return new ItemPrice(_loc1_[0],_loc1_[1]);
      }

      public function get actionPrice() : ItemPrice {
         var _loc1_:Array = _getAttr("actionPrice") as Array;
         return new ItemPrice(_loc1_[0],_loc1_[1]);
      }

      public function get isHidden() : Boolean {
         return Boolean(_getAttr("isHidden"));
      }

      public function get inventoryCount() : uint {
         return uint(_getAttr("inventoryCount"));
      }

      public function get nationID() : int {
         return uint(_getAttr("nationID"));
      }

      public function get isRemovable() : Boolean {
         return Boolean(_getAttr("isRemovable"));
      }

      public function get name() : String {
         return String(_getAttr("name"));
      }

      public function get userType() : String {
         return String(_getAttr("userType"));
      }

      public function get userName() : String {
         return String(_getAttr("userName"));
      }

      public function get longUserName() : String {
         return String(_getAttr("longUserName"));
      }

      public function get shortUserName() : String {
         return String(_getAttr("shortUserName"));
      }

      public function get description() : String {
         return String(_getAttr("fullDescription"));
      }

      public function get shortDescription() : String {
         return String(_getAttr("shortDescription"));
      }

      public function get icon() : String {
         return String(_getAttr("icon"));
      }

      public function get level() : uint {
         return uint(_getAttr("level"));
      }
   }

}