package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.data.ListData;
   import flash.events.MouseEvent;
   import net.wg.gui.events.FinalStatisticEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextFormat;


   public class EfficiencyRenderer extends UIComponent implements IListItemRenderer
   {
          
      public function EfficiencyRenderer() {
         super();
      }

      private var _dataDirty:Boolean = false;

      private var icons:Array;

      public var fakeBg:MovieClip;

      protected var data:Object;

      protected var _owner:UIComponent = null;

      public var playerName:TextField;

      public var vehicleIcon:UILoaderAlt;

      public var vehicleName:TextField;

      public var killIcon:EfficiencyIconRenderer;

      public var damageIcon:EfficiencyIconRenderer;

      public var critsIcon:EfficiencyIconRenderer;

      public var evilIcon:EfficiencyIconRenderer;

      public var spottedIcon:EfficiencyIconRenderer;

      public var deadBg:MovieClip;

      protected var _index:uint = 0;

      protected var _selectable:Boolean = false;

      protected var _selected:Boolean = false;

      public function setListData(param1:ListData) : void {
         this.index = param1.index;
         this.selected = param1.selected;
      }

      public function setData(param1:Object) : void {
         this.data = param1;
         if(param1)
         {
            if(param1.hoveredKind)
            {
               param1.hoveredKind = null;
            }
         }
         this._dataDirty = true;
         invalidate();
      }

      public function getData() : Object {
         return this.data;
      }

      override protected function configUI() : void {
         var _loc2_:EfficiencyIconRenderer = null;
         super.configUI();
         focusTarget = this.owner;
         _focusable = tabEnabled = tabChildren = false;
         mouseChildren = true;
         this.icons = [this.killIcon,this.damageIcon,this.critsIcon,this.evilIcon,this.spottedIcon];
         var _loc1_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.icons[_loc1_];
            if(_loc2_)
            {
               _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.handleIconRoll);
               _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.handleIconRoll);
            }
            _loc1_++;
         }
      }

      private function handleIconRoll(param1:MouseEvent) : void {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.data.isDisabled = !param1.target.enabled;
            this.data.hoveredKind = param1.target.kind;
            dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER,this.data));
         }
         else
         {
            dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT));
         }
      }

      private function getDimmFilter() : ColorMatrixFilter {
         var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
         var _loc2_:Array = [0.4,0,0,0,0];
         var _loc3_:Array = [0,0.4,0,0,0];
         var _loc4_:Array = [0,0,0.4,0,0];
         var _loc5_:Array = [0,0,0,1,0];
         var _loc6_:Array = new Array();
         _loc6_ = _loc6_.concat(_loc2_);
         _loc6_ = _loc6_.concat(_loc3_);
         _loc6_ = _loc6_.concat(_loc4_);
         _loc6_ = _loc6_.concat(_loc5_);
         _loc1_.matrix = _loc6_;
         return _loc1_;
      }

      override protected function draw() : void {
         var _loc1_:TextFormat = null;
         super.draw();
         if(this._dataDirty)
         {
            if(this.data != null)
            {
               this.playerName.textColor = 13224374;
               this.vehicleName.textColor = 13224374;
               this.vehicleIcon.visible = !this.data.isFake;
               this.deadBg.visible = false;
               this.fakeBg.visible = this.data.isFake;
               this.vehicleName.visible = !this.data.isFake;
               this.killIcon.visible = !this.data.isFake;
               this.damageIcon.visible = !this.data.isFake && !this.data.isAlly;
               this.critsIcon.visible = !this.data.isFake && !this.data.isAlly;
               this.evilIcon.visible = !this.data.isFake && !this.data.isAlly;
               this.spottedIcon.visible = !this.data.isFake && !this.data.isAlly;
               App.utils.commons.formatPlayerName(this.playerName,App.utils.commons.getUserProps(this.data.playerName,this.data.playerClan,this.data.playerRegion));
               _loc1_ = this.playerName.getTextFormat();
               if(this.data.isFake)
               {
                  _loc1_.align = "left";
                  _loc1_.leftMargin = 15;
                  this.playerName.setTextFormat(_loc1_);
               }
               else
               {
                  _loc1_.align = "right";
                  _loc1_.leftMargin = 0;
                  this.playerName.setTextFormat(_loc1_);
                  this.vehicleIcon.source = this.data.tankIcon;
                  this.vehicleName.text = this.data.vehicleName;
                  this.damageIcon.enabled = false;
                  this.critsIcon.enabled = false;
                  this.evilIcon.enabled = false;
                  this.spottedIcon.enabled = false;
                  this.killIcon.enabled = false;
                  this.killIcon.kind = this.data.isAlly?EfficiencyIconRenderer.TEAMKILL:EfficiencyIconRenderer.KILL;
                  if(this.data.deathReason > -1)
                  {
                     this.killIcon.enabled = true;
                  }
                  if(this.data.killed)
                  {
                     this.playerName.textColor = 6381391;
                     this.vehicleName.textColor = 6381391;
                     this.deadBg.visible = true;
                     this.vehicleIcon.filters = [this.getDimmFilter()];
                  }
                  else
                  {
                     this.vehicleIcon.filters = [];
                  }
                  if(this.data.damageDealt > 0)
                  {
                     this.damageIcon.enabled = true;
                     this.damageIcon.value = this.data.pierced;
                  }
                  if(this.data.critsCount > 0)
                  {
                     this.critsIcon.enabled = true;
                     this.critsIcon.value = this.data.critsCount;
                  }
                  if(this.data.damageAssisted > 0)
                  {
                     this.evilIcon.enabled = true;
                  }
                  if(this.data.spotted > 0)
                  {
                     this.spottedIcon.enabled = true;
                  }
               }
            }
            else
            {
               this.visible = false;
            }
            this._dataDirty = false;
         }
      }

      public function get index() : uint {
         return this._index;
      }

      public function set index(param1:uint) : void {
         this._index = param1;
      }

      public function get owner() : UIComponent {
         return this._owner;
      }

      public function set owner(param1:UIComponent) : void {
         this._owner = param1;
      }

      public function get selectable() : Boolean {
         return this._selectable;
      }

      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
      }

      public function get selected() : Boolean {
         return this._selected;
      }

      public function set selected(param1:Boolean) : void {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
      }
   }

}