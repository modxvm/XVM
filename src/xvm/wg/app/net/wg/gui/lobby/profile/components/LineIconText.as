package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class LineIconText extends UIComponent
   {
          
      public function LineIconText() {
         super();
      }

      public static const TEXT_INVALID:String = "txtInv";

      public static const ICON_INVALID:String = "iconInv";

      public var textComponent:UnderlinedText;

      public var icon:UILoaderAlt;

      protected var _text:String = "";

      private var _iconSource:String;

      public function set text(param1:String) : void {
         this._text = param1;
         invalidate(TEXT_INVALID);
      }

      public function get text() : String {
         return this._text;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(TEXT_INVALID))
         {
            this.applyText();
         }
         if((isInvalid(ICON_INVALID)) && (this.icon))
         {
            this.icon.source = this._iconSource;
         }
      }

      protected function applyText() : void {
         this.textComponent.text = this._text;
      }

      public function get iconSource() : String {
         return this._iconSource;
      }

      public function set iconSource(param1:String) : void {
         this._iconSource = param1;
         invalidate(ICON_INVALID);
      }

      override public function dispose() : void {
         super.dispose();
         if(this.icon)
         {
            this.icon.dispose();
         }
         this.icon = null;
      }
   }

}