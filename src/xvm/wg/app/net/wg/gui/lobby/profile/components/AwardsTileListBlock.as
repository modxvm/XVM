package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.events.Event;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;


   public class AwardsTileListBlock extends UIComponent
   {
          
      public function AwardsTileListBlock() {
         super();
      }

      protected static const DATA_PROVIDER_INV:String = "dpInv";

      protected static const LABEL_INV:String = "lblInv";

      public var textField:TextField;

      private var _labelText:String = "";

      public var tileList:ResizableTileList;

      protected var _dataProvider:Array;

      override protected function configUI() : void {
         super.configUI();
         addEventListener(Event.RESIZE,this.tileResizeHandler,false,0,true);
         this.tileList.direction = DirectionMode.VERTICAL;
         this.tileList.columnCount = 12;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(DATA_PROVIDER_INV))
         {
            this.applyDataChanges();
         }
         if(isInvalid(LABEL_INV))
         {
            this.applyLabel();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applySizeChanges();
         }
      }

      protected function applyLabel() : void {
         this.textField.text = this._labelText;
      }

      protected function applySizeChanges() : void {
         _height = this.tileList.y + this.tileList.height;
      }

      protected function applyDataChanges() : void {
         this.tileList.dataProvider = new DataProvider(this._dataProvider);
         invalidate(LABEL_INV);
      }

      private function tileResizeHandler(param1:Event) : void {
         this.applySizeChanges();
      }

      public function set labelText(param1:String) : void {
         this._labelText = param1;
         invalidate(LABEL_INV);
      }

      public function get dataProvider() : Array {
         return this._dataProvider;
      }

      public function set dataProvider(param1:Array) : void {
         this._dataProvider = param1;
         invalidate(DATA_PROVIDER_INV);
      }

      override protected function onDispose() : void {
         if(this.tileList)
         {
            this.tileList.dispose();
            this.tileList = null;
         }
         if(this.dataProvider)
         {
            this.dataProvider = null;
         }
         super.onDispose();
      }

      public function get labelText() : String {
         return this._labelText;
      }
   }

}