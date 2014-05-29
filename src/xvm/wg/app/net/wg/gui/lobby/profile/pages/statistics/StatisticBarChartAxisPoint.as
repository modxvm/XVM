package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.events.MouseEvent;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;


   public class StatisticBarChartAxisPoint extends SimpleLoader implements IListItemRenderer
   {
          
      public function StatisticBarChartAxisPoint() {
         super();
      }

      private static function mouseRollOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      protected var _data:Object;

      private var _tooltip:String = null;

      private var _initialized:Boolean;

      public function get tooltip() : String {
         return this._tooltip;
      }

      override protected function onLoadingComplete() : void {
         this._initialized = true;
         super.onLoadingComplete();
      }

      public function setData(param1:Object) : void {
         this._data = param1;
         setSource(StatisticChartInfo(this._data).icon);
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,mouseRollOutHandler,false,0,true);
         }
      }

      private function disposeHandlers() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,mouseRollOutHandler);
      }

      protected function mouseRollOverHandler(param1:MouseEvent) : void {
         this.showToolTip();
      }

      protected function showToolTip() : void {
          
      }

      public function get index() : uint {
         return 0;
      }

      public function set index(param1:uint) : void {
          
      }

      public function get owner() : UIComponent {
         return null;
      }

      public function set owner(param1:UIComponent) : void {
          
      }

      public function get selectable() : Boolean {
         return false;
      }

      public function set selectable(param1:Boolean) : void {
          
      }

      public function get selected() : Boolean {
         return false;
      }

      public function set selected(param1:Boolean) : void {
          
      }

      public function get displayFocus() : Boolean {
         return false;
      }

      public function set displayFocus(param1:Boolean) : void {
          
      }

      public function setListData(param1:ListData) : void {
          
      }

      public function getData() : Object {
         return this._data;
      }

      public function get enabled() : Boolean {
         return false;
      }

      public function set enabled(param1:Boolean) : void {
          
      }

      public function get focusTarget() : UIComponent {
         return null;
      }

      public function set focusTarget(param1:UIComponent) : void {
          
      }

      public function validateNow(param1:Event=null) : void {
          
      }

      public function handleInput(param1:InputEvent) : void {
          
      }

      override protected function onDispose() : void {
         this.disposeHandlers();
         this._data = null;
         super.onDispose();
      }

      public function get initialized() : Boolean {
         return this._initialized;
      }
   }

}