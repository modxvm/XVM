package net.wg.gui.lobby.profile.pages.technique
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileTechniqueEmptyScreen extends UIComponent
   {
      
      public function ProfileTechniqueEmptyScreen() {
         super();
      }
      
      private var _text:String = "";
      
      public var textField:TextField;
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textField.text = this._text;
         }
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function set text(param1:String) : void {
         this._text = param1;
         invalidateData();
      }
   }
}
