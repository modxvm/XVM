package net.wg.gui.lobby.moduleInfo
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ModuleEffects extends UIComponent
   {
      
      public function ModuleEffects() {
         super();
      }
      
      public var effectsTF:TextField = null;
      
      protected var _bottomMargin:Number = 20;
      
      public function setEffects(param1:Object = null) : void {
         if(param1)
         {
            this.effectsTF.multiline = true;
            this.effectsTF.autoSize = TextFieldAutoSize.LEFT;
            this.effectsTF.multiline = true;
            this.effectsTF.htmlText = this.getEffectParams(param1);
            height = this.effectsTF.y + this.effectsTF.textHeight + this._bottomMargin;
         }
      }
      
      public function get bottomMargin() : Number {
         return this._bottomMargin;
      }
      
      public function set bottomMargin(param1:Number) : void {
         this._bottomMargin = param1;
      }
      
      private function getEffectParams(param1:Object) : String {
         var _loc2_:* = "";
         var _loc3_:Number = 25;
         var _loc4_:ILocale = App.utils.locale;
         if((param1.effectOnUse) && (!(param1.effectOnUse == "")) && !(param1.effectOnUse == undefined))
         {
            _loc2_ = _loc2_ + this.getEquipmentUsageBlock(_loc4_.makeString(TOOLTIPS.EQUIPMENT_ONUSE),_loc4_.makeString(param1.effectOnUse),_loc3_);
         }
         if(!(param1.effectAlways == "") && !(param1.effectAlways == "") && !(param1.effectAlways == undefined))
         {
            _loc2_ = _loc2_ + this.getEquipmentUsageBlock(_loc4_.makeString(TOOLTIPS.EQUIPMENT_ALWAYS),_loc4_.makeString(param1.effectAlways),_loc3_);
         }
         if(_loc2_ != "")
         {
            _loc2_ = Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.EQUIPMENT_EFFECT),"#cbad78",14,"$TitleFont",true) + _loc2_;
         }
         if(!(param1.effectRestriction == "") && !(param1.effectRestriction == "") && !(param1.effectRestriction == undefined))
         {
            _loc2_ = _loc2_ + ("<br/>" + Utils.instance.htmlWrapper(App.utils.locale.makeString(param1.effectRestriction),"#cbad78",13,"$FieldFont") + Utils.instance.htmlWrapper(" ","#cbad78",28,"$FieldFont"));
         }
         return _loc2_;
      }
      
      private function getEquipmentUsageBlock(param1:String, param2:String, param3:int = 20) : String {
         var param1:String = param1 == ""?"":Utils.instance.htmlWrapper(param1,"#c1ba9c",13,"$FieldFont",true) + Utils.instance.htmlWrapper(" ","#c1ba9c",param3,"$FieldFont");
         var param2:String = param2 == ""?"":Utils.instance.htmlWrapper(param2,"#95907f",12,"$FieldFont");
         var _loc4_:String = "<br/>" + param1 + "<br/>" + param2;
         return _loc4_;
      }
   }
}
