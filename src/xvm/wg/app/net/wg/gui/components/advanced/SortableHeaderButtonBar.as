package net.wg.gui.components.advanced
{
   import scaleform.clik.interfaces.IDataProvider;


   public class SortableHeaderButtonBar extends ButtonBarEx
   {
          
      public function SortableHeaderButtonBar() {
         super();
      }

      public static const BTN_ENABLING_CHANGED:String = "btnEnablingChanged";

      private var lastChangedButton:BtnEnablingData;

      override protected function draw() : void {
         super.draw();
         if((isInvalid(BTN_ENABLING_CHANGED)) && (this.lastChangedButton))
         {
            getButtonAt(this.lastChangedButton.index).enabled = this.lastChangedButton.enabled;
         }
      }

      override public function get dataProvider() : IDataProvider {
         return super.dataProvider;
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
      }

      override protected function updateRenderers() : void {
         super.updateRenderers();
      }

      public function enableButtonAt(param1:Boolean, param2:int) : void {
         if(this.lastChangedButton)
         {
            if(!(this.lastChangedButton.index == param2) || !(this.lastChangedButton.enabled == param1))
            {
               this.lastChangedButton.index = param2;
               this.lastChangedButton.enabled = param1;
               invalidate(BTN_ENABLING_CHANGED);
            }
         }
         else
         {
            this.lastChangedButton = new BtnEnablingData(param2,param1);
            invalidate(BTN_ENABLING_CHANGED);
         }
      }
   }

}

   class BtnEnablingData extends Object
   {
          
      function BtnEnablingData(param1:int, param2:Boolean) {
         super();
         this.index = param1;
         this.enabled = param2;
      }

      public var index:int;

      public var enabled:Boolean;
   }
