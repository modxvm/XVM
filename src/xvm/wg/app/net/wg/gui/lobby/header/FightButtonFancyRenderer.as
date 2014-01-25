package net.wg.gui.lobby.header
{
   import net.wg.gui.components.controls.FightListItemRenderer;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.text.TextField;


   public class FightButtonFancyRenderer extends FightListItemRenderer
   {
          
      public function FightButtonFancyRenderer() {
         super();
         scaleX = scaleY = 1;
         this.newIndicator.visible = false;
         this.newIndicator.mouseChildren = false;
         this.hitArea = this.hitAreaA;
         this._originalTitleY = textField.y;
         this._originalDescrY = this.descr.y;
         if(this.descr.text)
         {
            this.descrTextColor = this.descr.textColor;
         }
      }

      public static const DESCR_ACTIVE_TEXT_COLOR:uint = 16748339;

      private static const IS_UNIT_OPENED:String = "isUnitOpened";

      private static const UPDATE_SHOW:String = "openedUnitWindow";

      private static const VIEW_RECT:Rectangle;

      public var newIndicator:MovieClip;

      public var hitAreaA:MovieClip;

      public var icon:MovieClip;

      public var descr:TextField;

      private var isActive:Boolean = false;

      private var descrTextColor:uint = 8092009;

      private var _originalTitleY:Number;

      private var _originalDescrY:Number;

      private var isShow:Boolean = false;

      override protected function setup() : void {
         super.setup();
         if((data.hasOwnProperty(IS_UNIT_OPENED)) && (this.newIndicator))
         {
            this.newIndicator.visible = !data.isUnitOpened;
            invalidate(UPDATE_SHOW);
         }
         this.icon.gotoAndStop(data.icon);
         if(enabled)
         {
            this.descr.textColor = data.active?DESCR_ACTIVE_TEXT_COLOR:this.descrTextColor;
         }
         this.descr.text = data.description;
         if(this.descr.numLines == 1)
         {
            textField.y = this._originalTitleY + 6;
            this.descr.y = this._originalDescrY + 6;
         }
         else
         {
            textField.y = this._originalTitleY;
            this.descr.y = this._originalDescrY;
         }
      }

      override protected function draw() : void {
         super.draw();
         scaleX = scaleY = 1;
         width = VIEW_RECT.width;
         height = VIEW_RECT.height;
         if((isInvalid(UPDATE_SHOW)) && (data.hasOwnProperty(IS_UNIT_OPENED)) && this.isShow == false)
         {
            this.isShow = true;
            App.utils.scheduler.envokeInNextFrame(this.updateLabels);
         }
      }

      private function updateLabels() : void {
         if(data.hasOwnProperty(IS_UNIT_OPENED))
         {
            if(enabled)
            {
               this.newIndicator.gotoAndPlay("shine");
            }
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         App.utils.scheduler.cancelTask(this.updateLabels);
      }
   }

}