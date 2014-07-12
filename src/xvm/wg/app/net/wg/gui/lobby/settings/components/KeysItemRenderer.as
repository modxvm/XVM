package net.wg.gui.lobby.settings.components
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.display.Sprite;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import net.wg.data.constants.KeysMap;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class KeysItemRenderer extends ListItemRenderer
   {
      
      public function KeysItemRenderer() {
         super();
      }
      
      public var keyInput:KeyInput;
      
      public var bg:Sprite;
      
      public var underline:Sprite;
      
      private var _header:Boolean;
      
      private const INVALID_DATA:String = "invalid_data";
      
      private const INVALID_TEXT:String = "invalid_text";
      
      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidate(this.INVALID_DATA);
      }
      
      override protected function onDispose() : void {
         if(data)
         {
            data = null;
         }
         if((this.keyInput) && (this.keyInput.hasEventListener(KeyInputEvents.CHANGE)))
         {
            this.keyInput.removeEventListener(KeyInputEvents.CHANGE,this.onKeyChange);
            this.keyInput.dispose();
         }
         super.onDispose();
      }
      
      override public function toString() : String {
         return "[WG KeysItemRenderer " + name + "]";
      }
      
      public function isSelected() : Boolean {
         return this.keyInput.selected;
      }
      
      override public function get enabled() : Boolean {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void {
         var _loc2_:String = null;
         super.enabled = param1;
         mouseChildren = true;
         if(super.enabled)
         {
            _loc2_ = _focusIndicator == null && ((_displayFocus) || (_focused))?"over":"up";
         }
         else
         {
            _loc2_ = "disabled";
         }
         setState(_loc2_);
      }
      
      override public function get label() : String {
         return _label;
      }
      
      override public function set label(param1:String) : void {
         if(_label == param1)
         {
            return;
         }
         _label = param1;
         invalidate(this.INVALID_TEXT);
      }
      
      public function get header() : Boolean {
         return this._header;
      }
      
      public function set header(param1:Boolean) : void {
         if(param1 == this._header)
         {
            return;
         }
         this._header = param1;
         setState("up");
      }
      
      override protected function configUI() : void {
         constraintsDisabled = true;
         super.configUI();
         mouseChildren = true;
         if(this.keyInput)
         {
            this.keyInput.addEventListener(KeyInputEvents.CHANGE,this.onKeyChange);
            this.keyInput.mouseEnabled = true;
            this.keyInput.mouseChildren = true;
            this.keyInput.buttonMode = true;
         }
      }
      
      override protected function draw() : void {
         if(data)
         {
            if(isInvalid(this.INVALID_DATA))
            {
               this.header = data.header;
               this.keyInput.visible = !data.header;
               this.underline.visible = data.showUnderline;
               this.label = data.label;
               if(!this.header)
               {
                  this.keyInput.keys = data.keysRang;
                  this.keyInput.keyDefault = data.keyDefault;
                  this.keyInput.key = data.key;
               }
            }
            if(isInvalid(this.INVALID_TEXT))
            {
               this.setText();
            }
         }
         super.draw();
      }
      
      override protected function updateText() : void {
         if(this._header)
         {
            super.updateText();
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String> {
         if(this._header)
         {
            return Vector.<String>(["header_",""]);
         }
         return _selected?statesSelected:statesDefault;
      }
      
      private function keyCodeWasUsed(param1:Number) : Object {
         if(param1 == KeysMap.KEY_NONE)
         {
            return null;
         }
         var _loc2_:IDataProvider = KeysScrollingList(owner).dataProvider;
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(!_loc2_[_loc4_].header && !(_loc4_ == this.index))
            {
               if(this.keyInput.keyCode == _loc2_[_loc4_].key)
               {
                  return _loc2_[_loc4_];
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      private function setText() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(!(_label == null) && !(textField == null))
         {
            _loc1_ = data.additionalDiscr?10:0;
            _loc2_ = this.bg.height - textField.height;
            _loc3_ = textField.height;
            textField.multiline = true;
            textField.wordWrap = true;
            textField.htmlText = _label;
            textField.height = Math.max(textField.textHeight + 5,_loc3_);
            this.bg.height = textField.height + _loc2_ + _loc1_;
            this.height = this.actualHeight | 0;
            this.keyInput.y = this.height - this.keyInput.height >> 1;
            this.underline.y = this.actualHeight - this.underline.height | 0;
         }
      }
      
      private function onKeyChange(param1:KeyInputEvents) : void {
         var _loc2_:Object = this.keyCodeWasUsed(param1.keyCode);
         if(_loc2_)
         {
            _loc2_.key = KeysMap.KEY_NONE;
         }
         if((data) && (data.hasOwnProperty("key")))
         {
            data.key = param1.keyCode;
         }
         dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE,param1.keyCode));
      }
   }
}
