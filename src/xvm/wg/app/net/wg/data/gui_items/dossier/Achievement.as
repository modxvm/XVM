package net.wg.data.gui_items.dossier
{
   import net.wg.data.gui_items.GUIItem;
   import net.wg.data.constants.ItemTypes;
   
   public class Achievement extends GUIItem
   {
      
      public function Achievement(param1:String, param2:uint, param3:*) {
         this._dossierType = param2;
         super(ItemTypes.ACHIEVEMENT,[param1,[param2,param3]]);
      }
      
      private var _dossierType:int;
      
      public function get isDossierForCurrentUser() : * {
         var _loc1_:* = false;
         if(this._dossierType == 16)
         {
            _loc1_ = id[1][1] == null;
         }
         else if(this._dossierType == 17)
         {
            _loc1_ = id[1][1][1] == null;
         }
         
         return _loc1_;
      }
      
      public function getSection() : String {
         return String(_callMethod("getSection"));
      }
      
      public function getName() : String {
         return String(_getAttr("name"));
      }
      
      public function getLvlUpTotalValue() : uint {
         return uint(_getAttr("lvlUpTotalValue"));
      }
      
      public function getLvlUpValue() : uint {
         return uint(_getAttr("lvlUpValue"));
      }
      
      public function getActivity() : Boolean {
         return Boolean(_getAttr("isActive"));
      }
      
      public function getUserName() : String {
         return String(_getAttr("userName"));
      }
      
      public function getUserDesription() : String {
         return String(_getAttr("description"));
      }
      
      public function getUserHeroInfo() : String {
         return String(_getAttr("heroInfo"));
      }
      
      public function isRare() : Boolean {
         return Boolean(_callMethod("isRare"));
      }
      
      public function get rareIconId() : * {
         return _callMethod("requestImageID");
      }
      
      public function isInDossier() : Boolean {
         return Boolean(_callMethod("isInDossier"));
      }
      
      public function getDossierCompDescr() : String {
         return String(_callMethod("getDossierCompDescr"));
      }
      
      public function getIcon() : Object {
         return Object(_getAttr("icon"));
      }
      
      public function get icon() : String {
         return this.getIcon()["big"];
      }
      
      public function get section() : String {
         return String(_callMethod("getSection"));
      }
      
      public function get type() : String {
         return String(_callMethod("getType"));
      }
      
      public function get value() : Number {
         return uint(_getAttr("value"));
      }
   }
}
