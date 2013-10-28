package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.IEventCollector;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ListEvent;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.constants.Currencies;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.events.DeviceEvent;
   import net.wg.gui.events.ParamsEvent;
   import scaleform.gfx.MouseEventEx;


   public class DeviceSlot extends UIComponent
   {
          
      public function DeviceSlot() {
         this.dataValues = [];
         super();
         if(this.emptyFocusIndicator)
         {
            this.select.focusIndicator = this.emptyFocusIndicator;
         }
      }

      public var select:FittingSelect;

      public var levelMC:MovieClip;

      public var locked:MovieClip;

      public var id:String;

      public var emptyFocusIndicator:MovieClip;

      private var extraIcon:ExtraIcon;

      private var selectedIndex:Number = -1;

      private var dataValues:Array;

      private var _type:String;

      private var _slotIndex:Number = 0;

      private var _iconType:int = 0;

      private var _tooltip:String;

      public function selectItem(param1:Object) : void {
         this.select.selectedIndex = this.dataValues.indexOf(param1);
      }

      public function setValues(param1:Array) : void {
         this.dataValues = param1;
         invalidate(InvalidationType.DATA);
      }

      public function updateStage(param1:Number, param2:Number) : void {
         this.select.updateAvailableSize(param1,param2 - _originalHeight);
         if(this.select.selected)
         {
            this.select.close();
            this.select.open();
            App.toolTipMgr.hide();
         }
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.select.enabled = param1;
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
      }

      public function get slotIndex() : Number {
         return this._slotIndex;
      }

      public function set slotIndex(param1:Number) : void {
         this._slotIndex = param1;
      }

      public function get iconType() : int {
         return this._iconType;
      }

      public function set iconType(param1:int) : void {
         this._iconType = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         buttonMode = true;
         if(this.levelMC)
         {
            this.levelMC.mouseEnabled = this.levelMC.mouseChildren = false;
         }
         if(this.locked)
         {
            this.locked.mouseEnabled = this.locked.mouseChildren = false;
         }
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.addEvent(this.select,MouseEvent.ROLL_OVER,this.onOver,false,0,true);
         _loc1_.addEvent(this.select,MouseEvent.ROLL_OUT,this.onOut,false,0,true);
         _loc1_.addEvent(this.select,MouseEvent.CLICK,this.onOut,false,0,true);
         _loc1_.addEvent(this.select,ListEvent.INDEX_CHANGE,this.onChange,false,0,true);
         _loc1_.addEvent(this.select,Event.SELECT,this.highlightParams,false,0,true);
         _loc1_.addEvent(this,MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
      }

      override public function dispose() : void {
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.removeEvent(this.select,MouseEvent.ROLL_OVER,this.onOver);
         _loc1_.removeEvent(this.select,MouseEvent.ROLL_OUT,this.onOut);
         _loc1_.removeEvent(this.select,MouseEvent.CLICK,this.onOut);
         _loc1_.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onChange);
         _loc1_.removeEvent(this.select,Event.SELECT,this.highlightParams);
         _loc1_.removeEvent(this,MouseEvent.MOUSE_DOWN,this.onMouseDown);
         if(this.extraIcon)
         {
            _loc1_.removeEvent(this.extraIcon,SimpleLoader.LOADED,this.onExtraIconLoaded);
            this.extraIcon.dispose();
            removeChild(this.extraIcon);
         }
         this.select.dataProvider = null;
         this.select.dispose();
         this.dataValues.splice(0);
         this.dataValues = null;
         super.dispose();
      }

      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = false;
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.selectedIndex = -1;
            this.id = null;
            _loc1_ = 0;
            _loc2_ = this.dataValues.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc5_ = this.dataValues[_loc1_];
               if(_loc5_.isSelected)
               {
                  this.selectedIndex = _loc1_;
                  this.id = _loc5_.id;
                  break;
               }
               _loc1_++;
            }
            _loc3_ = this.select.enabled;
            this.select.enabled = false;
            this.select.dataProvider = new DataProvider(this.dataValues);
            this.select.selectedIndex = this.selectedIndex;
            if(this.selectedIndex >= 0)
            {
               _loc4_ = this.dataValues[this.selectedIndex];
               if(_loc4_.hasOwnProperty(ExtraIcon.EXTRA_ICON_PROP_NAME))
               {
                  if(!this.extraIcon)
                  {
                     this.createExtraIcon();
                  }
                  this.extraIcon.setSource(_loc4_[ExtraIcon.EXTRA_ICON_PROP_NAME]);
               }
               else
               {
                  if(this.extraIcon)
                  {
                     this.extraIcon.clear();
                  }
               }
            }
            else
            {
               if(this.extraIcon)
               {
                  this.extraIcon.clear();
               }
            }
            this.applyIconData(_loc4_);
            this.select.enabled = _loc3_;
         }
      }

      protected function applyIconData(param1:*) : void {
          
      }

      protected function createExtraIcon() : void {
         this.extraIcon = new ExtraIcon();
         App.utils.events.addEvent(this.extraIcon,SimpleLoader.LOADED,this.onExtraIconLoaded,false,0,true);
         this.extraIcon.mouseChildren = false;
         this.extraIcon.mouseEnabled = false;
         addChild(this.extraIcon);
      }

      private function onExtraIconLoaded(param1:Event) : void {
         var _loc2_:uint = 0;
         _loc2_ = 2;
         this.extraIcon.x = width - this.extraIcon.width - _loc2_;
         this.extraIcon.y = height - this.extraIcon.height - _loc2_;
      }

      private function onOver(param1:MouseEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:ITooltipProps = null;
         if(this.selectedIndex > -1)
         {
            _loc2_ = this.dataValues[this.selectedIndex];
            _loc3_ = [0,0];
            _loc3_[_loc2_.currency == Currencies.CREDITS?0:1] = _loc2_.price;
            _loc4_ = new TooltipProps("",stage.mouseX,stage.mouseY);
            App.toolTipMgr.showSpecial(Tooltips.HANGAR_MODULE,null,_loc2_.id,_loc3_,_loc2_.inventoryCount,_loc2_.vehicleCount,_loc2_.slotIndex?_loc2_.slotIndex:0);
         }
         else
         {
            App.toolTipMgr.showComplex(this.tooltip);
         }
      }

      private function onOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onChange(param1:ListEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if((this.select.enabled) && !(this.selectedIndex == this.select.selectedIndex))
         {
            _loc2_ = null;
            _loc3_ = null;
            if(this.selectedIndex > -1)
            {
               _loc2_ = this.dataValues[this.selectedIndex];
            }
            if(this.select.selectedIndex > -1)
            {
               _loc3_ = this.dataValues[this.select.selectedIndex];
            }
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_CHANGE,_loc3_,_loc2_));
            this.select.selectedIndex = this.selectedIndex;
         }
      }

      private function highlightParams(param1:Event) : void {
         dispatchEvent(new ParamsEvent(ParamsEvent.HIGHLIGHT_PARAMS,this.select.selected?this.type:"empty"));
      }

      private function onMouseDown(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = null;
         if(param1  is  MouseEventEx)
         {
            _loc2_ = param1 as MouseEventEx;
            if(_loc2_.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
               this.select.close();
            }
         }
      }

      public function get tooltip() : String {
         return this._tooltip;
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
      }
   }

}