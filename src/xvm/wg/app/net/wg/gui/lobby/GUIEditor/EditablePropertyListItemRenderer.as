package net.wg.gui.lobby.GUIEditor
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import flash.geom.Point;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   import flash.events.Event;


   public class EditablePropertyListItemRenderer extends ListItemRenderer
   {
          
      public function EditablePropertyListItemRenderer() {
         super();
      }

      public var valueField:TextField = null;

      override protected function draw() : void {
         var _loc1_:Point = null;
         super.draw();
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         mouseEnabled = true;
         if(isInvalid(InvalidationType.DATA))
         {
            if(enabled)
            {
               _loc1_ = new Point(mouseX,mouseY);
               _loc1_ = this.localToGlobal(_loc1_);
               if(this.hitTestPoint(_loc1_.x,_loc1_.y,true))
               {
                  setState("over");
                  dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
               }
            }
         }
         if(data != null)
         {
            textField.text = data.label;
            this.valueField.text = data.value;
         }
         else
         {
            this.valueField.text = "";
         }
      }

      override protected function configUI() : void {
         super.configUI();
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         mouseEnabled = true;
         this.valueField.addEventListener(Event.CHANGE,this.onTextInputHandler);
      }

      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidateData();
      }

      override public function dispose() : void {
         super.dispose();
         this.valueField.removeEventListener(Event.CHANGE,this.onTextInputHandler);
         this.valueField = null;
         textField = null;
      }

      private function onTextInputHandler(param1:Event) : void {
         dispatchEvent(new ChangePropertyEvent(ChangePropertyEvent.CHANGE_PROPERTY,textField.text,this.valueField.text));
      }
   }

}