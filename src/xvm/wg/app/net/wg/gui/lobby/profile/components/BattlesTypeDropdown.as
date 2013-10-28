package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class BattlesTypeDropdown extends UIComponent
   {
          
      public function BattlesTypeDropdown() {
         super();
      }

      public var txtLabel:TextField;

      public var dropdownMenu:DropdownMenu;

      private var _padding:int = 1;

      private var _selectedItem:String;

      override protected function configUI() : void {
         var _loc4_:String = null;
         super.configUI();
         if(App.utils)
         {
            this.txtLabel.autoSize = TextFieldAutoSize.RIGHT;
            this.txtLabel.text = App.utils.locale.makeString(PROFILE.PROFILE_DROPDOWN_BATTLESTYPE);
         }
         this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.menuIndexChangeHandler,false,0,true);
         var _loc1_:Array = [];
         var _loc2_:Array = [PROFILE.PROFILE_DROPDOWN_LABELS_ALL,PROFILE.PROFILE_DROPDOWN_LABELS_TEAM];
         var _loc3_:uint = _loc2_.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            _loc1_.push(
               {
                  "label":App.utils.locale.makeString(_loc4_),
                  "key":_loc4_
               }
            );
            _loc5_++;
         }
         this.dropdownMenu.dataProvider = new DataProvider(_loc1_);
         this.dropdownMenu.validateNow();
      }

      override protected function draw() : void {
         var _loc1_:IDataProvider = null;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._selectedItem)
            {
               _loc1_ = this.dropdownMenu.dataProvider;
               _loc2_ = _loc1_.length;
               _loc4_ = -1;
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  _loc3_ = _loc1_[_loc5_];
                  if(_loc3_.key == this._selectedItem)
                  {
                     _loc4_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               this.dropdownMenu.selectedIndex = _loc4_;
            }
         }
      }

      private function menuIndexChangeHandler(param1:ListEvent=null) : void {
         param1.stopImmediatePropagation();
         this._selectedItem = param1.itemData.key;
         dispatchEvent(new Event(Event.CHANGE));
      }

      public function get selectedItem() : String {
         return this._selectedItem;
      }

      public function set selectedItem(param1:String) : void {
         this._selectedItem = param1;
         invalidateData();
      }
   }

}