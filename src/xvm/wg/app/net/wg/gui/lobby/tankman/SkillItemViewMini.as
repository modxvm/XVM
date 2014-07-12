package net.wg.gui.lobby.tankman
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.text.TextField;
   
   public class SkillItemViewMini extends UIComponent
   {
      
      public function SkillItemViewMini() {
         super();
      }
      
      public static const TYPE_SKILL:String = "skill";
      
      public static const TYPE_NEW_SKILL:String = "new_skill";
      
      public static const TYPE_SKILLS:String = "skills";
      
      public static const TYPE_NEW_SKILLS:String = "new_skills";
      
      public static const TYPE_CURRENT_SKILL:String = "current_skill";
      
      public static const TYPE_CURRENT_NEW_SKILL:String = "current_new_skill";
      
      public static const LEVEL_POSTFIX:String = "%";
      
      public static const COUNT_POSTFIX:String = " x 100%";
      
      public var icon:UILoaderAlt;
      
      public var textField:TextField;
      
      private var _text:String = "";
      
      private var _level:Number = 0;
      
      private var _count:int = 0;
      
      private var _type:String;
      
      override protected function onDispose() : void {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function set text(param1:String) : void {
         this._text = param1;
         this.textField.htmlText = this._text;
      }
      
      public function get level() : Number {
         return this._level;
      }
      
      public function set level(param1:Number) : void {
         this._level = param1;
         this.text = isNaN(this._level)?"":this._level.toString() + LEVEL_POSTFIX;
      }
      
      public function get count() : int {
         return this._count;
      }
      
      public function set count(param1:int) : void {
         this._count = param1;
         this.text = this._count.toString() + COUNT_POSTFIX;
      }
      
      public function get type() : String {
         return this._type;
      }
      
      public function set type(param1:String) : void {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         this.updateType();
      }
      
      protected function updateType() : void {
         if(this._type == TYPE_CURRENT_NEW_SKILL || this._type == TYPE_NEW_SKILL || this._type == TYPE_NEW_SKILLS)
         {
            this.iconSource = null;
         }
         gotoAndPlay(this._type);
      }
      
      public function get iconSource() : String {
         return this.icon.source;
      }
      
      public function set iconSource(param1:String) : void {
         this.icon.source = param1;
         this.icon.visible = Boolean(param1);
      }
   }
}
