package net.wg.gui.lobby.customization.renderers
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.IconText;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import flash.events.Event;
   import net.wg.data.constants.SoundTypes;


   public class CustomizationItemRenderer extends SoundListItemRenderer
   {
          
      public function CustomizationItemRenderer() {
         super();
         soundType = SoundTypes.CUSTOMIZATION_ITEM_RENDERER;
      }

      public static const DEMO_OFF:String = "off";

      public static const DEMO_NEW:String = "new";

      public static const DEMO_CURRENT:String = "current";

      public var newMarker:MovieClip;

      public var uiLoader:UILoaderAlt;

      public var actionPrice:ActionPrice;

      public var costField:IconText;

      public var costFrame:MovieClip;

      public var border:RendererBorder;

      public var hitMc:Sprite;

      public var targetIcon:MovieClip;

      public var freeTF:TextField;

      protected var isNew:Boolean = false;

      protected var isGold:Boolean = false;

      protected var costVal:String = "";

      protected var priceVal:Number = 0;

      protected var defPriceVal:Number = 0;

      protected var actionPrc:Number = 0;

      private var costVisible:Boolean = false;

      private var texturePath:String;

      private var _current:Boolean = false;

      private var _isMouseOver:Boolean = false;

      private var _demoMode:String = "off";

      private var _useHandCursorForse:Boolean = false;

      public function get current() : Boolean {
         return this._current;
      }

      public function set current(param1:Boolean) : void {
         if(this._current == param1)
         {
            return;
         }
         this._current = param1;
         setState(state);
      }

      public function get demoMode() : String {
         return this._demoMode;
      }

      public function set demoMode(param1:String) : void {
         var _loc2_:* = false;
         if(this._demoMode == param1)
         {
            return;
         }
         this._demoMode = param1;
         _loc2_ = (this._useHandCursorForse) || this._demoMode == DEMO_OFF;
         super.enabled = _loc2_;
         useHandCursor = _loc2_;
         setState(state);
      }

      public function get useHandCursorForse() : Boolean {
         return this._useHandCursorForse;
      }

      public function set useHandCursorForse(param1:Boolean) : void {
         this._useHandCursorForse = param1;
      }

      override public function setData(param1:Object) : void {
         var _loc2_:Boolean = this.isNew;
         data = param1;
         if(data)
         {
            if(data.current != this.current)
            {
               this.current = data.current;
            }
            this.costVisible = this.demoMode == CustomizationItemRenderer.DEMO_NEW && data.id > 0 && !data.isInHangar || this.demoMode == CustomizationItemRenderer.DEMO_OFF && !((data.current) || (data.isInHangar));
            if(data.price)
            {
               this.costVal = data.price.isGold?App.utils.locale.gold(data.price.cost):App.utils.locale.integer(data.price.cost);
               this.priceVal = data.price.cost;
               this.defPriceVal = data.defPrice.cost;
               this.isGold = data.price.isGold;
            }
            if(data.actionPrc != undefined)
            {
               this.actionPrc = data.actionPrc;
            }
            _loc2_ = data.isNew;
            if(this.uiLoader)
            {
               this.loadTexture(data.texturePath);
            }
         }
         if(_loc2_ != this.isNew)
         {
            this.showIsNew(_loc2_);
         }
         invalidateData();
      }

      override public function dispose() : void {
         super.dispose();
         removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress);
         removeEventListener(MouseEvent.CLICK,handleMouseRelease);
         removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         removeEventListener(InputEvent.INPUT,handleInput);
         this.uiLoader.dispose();
         this.uiLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoadComplete);
         if((this.newMarker) && (contains(this.newMarker)))
         {
            removeChild(this.newMarker);
         }
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
         }
         data = null;
      }

      override protected function configUI() : void {
         super.configUI();
         var _loc1_:Boolean = (this._useHandCursorForse) || this._demoMode == DEMO_OFF;
         super.enabled = _loc1_;
         useHandCursor = _loc1_;
         this.uiLoader.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoadComplete);
         addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         if(data)
         {
            this.loadTexture(data.texturePath);
         }
         if(this.freeTF)
         {
            this.freeTF.text = VEHICLE_CUSTOMIZATION.IGR_FREE_FULL;
         }
         if(this.hitMc)
         {
            this.hitArea = this.hitMc;
         }
         if(this.actionPrice)
         {
            this.actionPrice.setup(this);
         }
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseChildren = true;
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.visible = !(this.data == null);
            this.costFrame.visible = this.costVisible;
            _loc1_ = ((((this.freeTF) && (data)) && (data.id > 0) && data.price) && (data.price.cost == 0)) && !data.current && !data.isInHangar;
            if(this.actionPrice)
            {
               if(this.costVisible)
               {
                  this.actionPrice.setData(this.actionPrc,this.priceVal,this.defPriceVal,this.isGold?IconText.GOLD:IconText.CREDITS);
                  this.costField.visible = !this.actionPrice.visible && !_loc1_;
               }
               else
               {
                  this.actionPrice.visible = false;
                  this.costField.visible = false;
               }
            }
            else
            {
               this.costField.visible = (this.costVisible) && !_loc1_;
            }
            if(_loc1_)
            {
               this.freeTF.visible = true;
               if(this.actionPrice)
               {
                  this.actionPrice.visible = false;
               }
            }
            else
            {
               if(this.freeTF)
               {
                  this.freeTF.visible = false;
               }
               this.costField.text = this.costVal;
               this.costField.icon = this.isGold?IconText.GOLD:IconText.CREDITS;
            }
            if(this.targetIcon)
            {
               this.targetIcon.visible = !(this.demoMode == DEMO_CURRENT) && (data) && ((data.current) || (data.isInHangar));
               if(this.targetIcon.visible)
               {
                  this.targetIcon.gotoAndStop(data.current?"current":"hangar");
               }
            }
            this.checkTooltip();
         }
      }

      protected function checkTooltip() : void {
         if(this.demoMode == DEMO_NEW || this.demoMode == DEMO_CURRENT)
         {
            return;
         }
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = this.localToGlobal(_loc1_);
         if((this.hitTestPoint(_loc1_.x,_loc1_.y,true)) && (this._isMouseOver))
         {
            this.showTooltip();
         }
      }

      protected var prefixesVector:Vector.<String> = null;

      override protected function getStatePrefixes() : Vector.<String> {
         if(this.prefixesVector)
         {
            this.prefixesVector.splice(0,this.prefixesVector.length);
         }
         else
         {
            this.prefixesVector = new Vector.<String>();
         }
         if((enabled) && (this._current))
         {
            this.prefixesVector.push("current_");
         }
         else
         {
            if((enabled) && (_selected))
            {
               this.prefixesVector.push("selected_");
            }
            else
            {
               this.prefixesVector.push("");
            }
         }
         return this.prefixesVector;
      }

      protected function showIsNew(param1:Boolean) : void {
         this.isNew = param1;
         if(param1)
         {
            if(!this.newMarker)
            {
               this.newMarker = App.utils.classFactory.getObject("NewMarker") as MovieClip;
               this.newMarker.x = this.newMarker.y = 2;
               addChild(this.newMarker);
            }
            this.newMarker.visible = param1;
         }
         else
         {
            if(this.newMarker)
            {
               this.newMarker.visible = param1;
            }
         }
      }

      protected function onImageLoadComplete(param1:Event) : void {
         invalidateSize();
         validateNow();
      }

      private function loadTexture(param1:String) : void {
         this.texturePath = param1;
         if(!(this.texturePath == null) && !(this.texturePath.length == 0))
         {
            this.uiLoader.source = param1;
         }
         else
         {
            this.uiLoader.unload();
         }
      }

      private function showTooltip(param1:MouseEvent=null) : void {
         this._isMouseOver = true;
         if((data) && data.description.length > 0)
         {
            App.toolTipMgr.showComplex(data.description);
         }
      }

      private function hideTooltip(param1:MouseEvent=null) : void {
         this._isMouseOver = false;
         App.toolTipMgr.hide();
      }
   }

}