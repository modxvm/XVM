package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.components.chart.FrameChartItem;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   import net.wg.data.managers.IToolTipParams;
   import flash.geom.Point;


   public class StatisticBarChartItem extends FrameChartItem
   {
          
      public function StatisticBarChartItem() {
         super();
         stop();
      }

      public static const topTextColor:uint = 16777215;

      public static const textColor:uint = 12696220;

      private static function hideToolTip() : void {
         App.toolTipMgr.hide();
      }

      public var textField:TextField;

      public var mcMask:MovieClip;

      public var background:Sprite;

      private var _tooltip:String = null;

      override protected function configUI() : void {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }

      protected function mouseRollOutHandler(param1:MouseEvent) : void {
         hideToolTip();
      }

      protected function mouseRollOverHandler(param1:MouseEvent) : void {
         this.showToolTip(null);
      }

      protected function showToolTip(param1:IToolTipParams) : void {
          
      }

      override protected function applyValueChange() : void {
         this.gotoAndStop(value + 1);
         var _loc1_:StatisticChartInfo = StatisticChartInfo(_data);
         this.textField.text = _loc1_.yField.toString();
         this.textField.textColor = value == 100?topTextColor:textColor;
         this.textField.y = this.mcMask.y - this.mcMask.height - this.textField.height;
         this.textField.x = Math.round(this.background.x + this.background.width / 2 - this.textField.width / 2);
      }

      public function getThumbDimensions() : Point {
         return new Point(this.background.width,this.background.height);
      }

      override public function dispose() : void {
         this.disposeHandlers();
         super.dispose();
      }

      private function disposeHandlers() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }

      public function get tooltip() : String {
         return this._tooltip;
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }
   }

}