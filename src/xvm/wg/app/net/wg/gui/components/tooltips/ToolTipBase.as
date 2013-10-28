package net.wg.gui.components.tooltips
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IToolTip;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import __AS3__.vec.Vector;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.motion.Tween;
   import flash.text.TextField;
   import net.wg.data.managers.ITooltipProps;
   import fl.transitions.easing.*;
   import flash.utils.setTimeout;
   import flash.utils.clearTimeout;


   public class ToolTipBase extends UIComponent implements IToolTip
   {
          
      public function ToolTipBase() {
         this.contentMargin = new Padding(12,17,12,17);
         this.bgShadowMargin = new Padding(3,5,7,5);
         super();
         visible = false;
         alpha = 0;
         this.x = -1000;
         this.y = -1000;
      }

      public static var COMPONENT_SHOP:String = "shop";

      public static var COMPONENT_INVENTORY:String = "inventory";

      public static var COMPONENT_CAROUSEL:String = "carousel";

      public static var COMPONENT_PROFILE_VEHICLE:String = "profileVehicle";

      protected var _data:Object = null;

      protected var _type:String = "";

      protected var _component:String = "";

      public var background:Sprite = null;

      public var content:MovieClip = null;

      public var contentWidth:Number = 0;

      protected var separators:Vector.<Separator> = null;

      protected var contentMargin:Padding;

      protected var bgShadowMargin:Padding;

      private const CURSOR_OFFSET:Number = 10;

      private const BORDER_OFFSET:Number = 15;

      private var tween:Tween = null;

      protected var headerList:Array = null;

      protected var centerList:Array = null;

      protected var leftList:Vector.<TextField> = null;

      protected var rightList:Array = null;

      protected var hasIconList:Array = null;

      protected var hasIcon:Boolean = false;

      protected var leftPartMaxW:Number = 0;

      protected var res:Object = null;

      protected var isRedrawed:Boolean = false;

      protected var topPosition:Number = 0;

      protected var _props:ITooltipProps = null;

      private const SHOW_DELAY:Number = 400;

      private var showDelayIntervalID:Number = 0;

      override protected function configUI() : void {
         super.configUI();
         if((this._data) && !this.isRedrawed)
         {
            this.redraw();
         }
      }

      public function build(param1:Object, param2:ITooltipProps) : void {
         this._type = param1.type;
         this._component = param1.component;
         this._data = param1.data;
         this._props = param2;
         this.topPosition = this.bgShadowMargin.top + this.contentMargin.top;
         this.leftPartMaxW = 0;
         if((this.stage) && !this.isRedrawed)
         {
            this.redraw();
         }
      }

      protected function redraw() : void {
         this.isRedrawed = true;
         this.updateSize();
         this.clearDelayIntervalID();
         var _loc1_:Number = (this._props) && !(this._props.drawDelay == -1)?this._props.drawDelay:this.SHOW_DELAY;
         this.showDelayIntervalID = setTimeout(this.startShow,_loc1_,this);
      }

      private function startShow(... rest) : void {
         this.clearDelayIntervalID();
         this.fadeIn();
      }

      private function fadeIn() : void {
         var _loc1_:Number = App.appWidth;
         var _loc2_:Number = App.appHeight;
         var _loc3_:Number = this._props.x != 0?this._props.x:App.stage.mouseX;
         var _loc4_:Number = this._props.y != 0?this._props.y:App.stage.mouseY;
         _loc3_ = _loc3_ + this.CURSOR_OFFSET;
         _loc4_ = _loc4_ + this.CURSOR_OFFSET;
         if(_loc4_ + this.actualHeight > _loc2_)
         {
            _loc4_ = _loc4_ - this.actualHeight - this.CURSOR_OFFSET * 2;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = this.BORDER_OFFSET;
         }
         if(_loc3_ + this.actualWidth > _loc1_)
         {
            _loc3_ = _loc3_ - this.actualWidth - this.CURSOR_OFFSET * 2;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = this.BORDER_OFFSET;
         }
         this.x = _loc3_ | 0;
         this.y = _loc4_ | 0;
         this.visible = true;
         this.tryClearTween();
         this.tween = new Tween(300,this,{"alpha":1},
            {
               "paused":false,
               "onComplete":this.onTweenComplete,
               "ease":Strong.easeInOut
            }
         );
      }

      private function onTweenComplete(param1:Tween) : void {
         this.tryClearTween();
      }

      private function tryClearTween() : void {
         if(this.tween)
         {
            this.tween.paused = true;
            this.tween = null;
         }
      }

      override public function dispose() : void {
         var _loc1_:Separator = null;
         if(this.separators)
         {
            while(this.separators.length > 0)
            {
               _loc1_ = this.separators.pop();
               this.content.removeChild(_loc1_);
               _loc1_ = null;
            }
            this.separators = null;
         }
         super.dispose();
         this.clearDelayIntervalID();
         this.tryClearTween();
      }

      private function clearDelayIntervalID() : void {
         if(this.showDelayIntervalID != 0)
         {
            clearTimeout(this.showDelayIntervalID);
            this.showDelayIntervalID = 0;
         }
      }

      protected function updateSize() : void {
         if(this.contentWidth == 0)
         {
            this.contentWidth = this.content.width;
         }
         this.background.width = this.content.width + this.contentMargin.horizontal + this.bgShadowMargin.horizontal | 0;
         this.background.height = this.content.height + this.contentMargin.vertical + this.bgShadowMargin.vertical | 0;
      }

      override public function toString() : String {
         return "[WG ToolTipBase " + name + "]";
      }
   }

}