package net.wg.gui.prebattle.company
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.clik.utils.Constraints;


   public class CompanyDropItemRenderer extends ListItemRenderer
   {
          
      public function CompanyDropItemRenderer() {
         super();
         buttonMode = true;
         mouseEnabled = true;
      }

      public var numberField:TextField;

      public var bg:MovieClip;

      private var isUpdated:Boolean = false;

      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         if(!(this.data == null) && param1 == this.data)
         {
            return;
         }
         super.setData(param1);
         invalidate("invalidateWindow");
      }

      override protected function configUI() : void {
         super.configUI();
         constraints.addElement(this.numberField.name,this.numberField,Constraints.LEFT);
         constraints.addElement(this.bg.name,this.bg,Constraints.ALL);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid("invalidateWindow")) && (data) && !this.isUpdated)
         {
            this.isUpdated = true;
            this.afterSetData();
         }
      }

      private function afterSetData() : void {
         if(data != null)
         {
            this.label = String(data["label"]);
            if(data["color"] != null)
            {
               textField.textColor = data["color"];
            }
         }
         this.numberField.text = String(index + 1);
         this.bg.visible = !Boolean(index % 2);
      }

      private function cutText(param1:String) : String {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         textField.text = param1;
         if(textField.getLineLength(1) != -1)
         {
            _loc2_ = param1;
            _loc3_ = textField.getLineLength(0);
            _loc2_ = _loc2_.substr(0,_loc3_ - 2);
            _loc2_ = _loc2_ + "..";
            textField.text = _loc2_;
         }
         return textField.text;
      }

      override public function set label(param1:String) : void {
         var param1:String = this.cutText(param1);
         super.label = param1;
      }
   }

}