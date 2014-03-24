package net.wg.gui.components.advanced
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.data.constants.Tooltips;
   import net.wg.data.constants.SoundTypes;


   public class ShellButton extends AmmunitionButton
   {
          
      public function ShellButton() {
         super();
         soundType = SoundTypes.FITTING_BUTTON;
         soundId = "tankShell";
         this.count = "";
      }

      private static const INV_AMMUN_ICON:String = "invAmmunIcon";

      private static const INV_COUNTER:String = "invCounter";

      private static const INV_LEVEL:String = "invLevel";

      private static const INV_COUNTER_INDICATOR:String = "invCounterIndicator";

      private static function onOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private var _id:String;

      private var _historicalBattleID:int = -1;

      private var _ammunitionType:String;

      private var _ammunitionIcon:String = "";

      private var _count:String;

      private var _inventoryCount:String;

      private var _level:int = -1;

      private var _tooltipType:String = "hangarShell";

      private var _tooltip:String = "";

      public var count_txt:TextField;

      public var countBg:MovieClip;

      public var iconLoader:UILoaderAlt;

      public var levelMc:MovieClip;

      public var counterIndicator:MovieClip;

      private var _showCounterIndicator:Boolean = false;

      private var _isDischarging:Boolean = false;

      private var _isReloading:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         mouseEnabled = enabled;
         if(hitMc != null)
         {
            this.hitArea = hitMc;
         }
         this.levelMc.visible = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         addEventListener(MouseEvent.MOUSE_OUT,onOut);
         addEventListener(MouseEvent.CLICK,onOut);
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         removeEventListener(MouseEvent.MOUSE_OUT,onOut);
         removeEventListener(MouseEvent.CLICK,onOut);
         this.count_txt = null;
         this.countBg = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INV_AMMUN_ICON))
         {
            if(this.iconLoader)
            {
               this.iconLoader.visible = !(this.ammunitionIcon == "");
               if(this.ammunitionIcon != "")
               {
                  this.iconLoader.source = this.ammunitionIcon;
               }
            }
         }
         if(isInvalid(INV_COUNTER))
         {
            if(this.count_txt)
            {
               this.count_txt.text = this._count;
               this.countBg.visible = !(this._count == "");
            }
         }
         if(isInvalid(INV_LEVEL))
         {
            if(this.levelMc)
            {
               if(this._level > 0 && this._level <= 10)
               {
                  this.levelMc.visible = true;
                  this.levelMc.gotoAndStop(this._level);
               }
               else
               {
                  this.levelMc.visible = false;
               }
            }
         }
         if(isInvalid(INV_COUNTER_INDICATOR))
         {
            if(this.counterIndicator)
            {
               if(this._showCounterIndicator)
               {
                  this.counterIndicator.visible = true;
                  this.counterIndicator.gotoAndPlay("showAnim");
               }
               else
               {
                  this.counterIndicator.visible = false;
               }
            }
         }
      }

      public function highlightCounter(param1:Boolean) : void {
         if(this._showCounterIndicator != param1)
         {
            this._showCounterIndicator = param1;
            invalidate(INV_COUNTER_INDICATOR);
         }
      }

      public function get ammunitionIcon() : String {
         return this._ammunitionIcon;
      }

      public function set ammunitionIcon(param1:String) : void {
         this._ammunitionIcon = param1;
         invalidate(INV_AMMUN_ICON);
      }

      public function get ammunitionType() : String {
         return this._ammunitionType;
      }

      public function set ammunitionType(param1:String) : void {
         this._ammunitionType = param1;
      }

      public function get inventoryCount() : String {
         return this._inventoryCount;
      }

      public function set inventoryCount(param1:String) : void {
         this._inventoryCount = param1;
      }

      public function get count() : String {
         return this._count;
      }

      public function set count(param1:String) : void {
         this._count = param1;
         invalidate(INV_COUNTER);
      }

      public function clear() : void {
         this.id = null;
         this.count = "";
         this.ammunitionIcon = "";
         label = "";
         this.level = -1;
         this._showCounterIndicator = false;
      }

      private function onOver(param1:MouseEvent) : void {
         switch(this.tooltipType)
         {
            case Tooltips.HANGAR_SHELL:
               App.toolTipMgr.showSpecial(Tooltips.HANGAR_SHELL,null,this.id,this.historicalBattleID);
               break;
            case Tooltips.SIMPLE:
               if(this._tooltip)
               {
                  App.toolTipMgr.show(this._tooltip);
               }
               break;
            case Tooltips.COMPLEX:
               if(this._tooltip)
               {
                  App.toolTipMgr.showComplex(this._tooltip);
               }
               break;
         }
      }

      public function get level() : int {
         return this._level;
      }

      public function set level(param1:int) : void {
         this._level = param1;
         invalidate(INV_LEVEL);
      }

      public function get tooltipType() : String {
         return this._tooltipType;
      }

      public function set tooltipType(param1:String) : void {
         this._tooltipType = param1;
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }

      public function get historicalBattleID() : int {
         return this._historicalBattleID;
      }

      public function set historicalBattleID(param1:int) : void {
         this._historicalBattleID = param1;
      }

      public function get tooltip() : String {
         return this._tooltip;
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
      }

      override public function set enabled(param1:Boolean) : void {
         if(param1 == enabled)
         {
            return;
         }
         if((this.focusable) && (this.focused) && !param1)
         {
            this.focused = 0;
         }
         super.enabled = param1;
         buttonMode = enabled;
         mouseEnabled = enabled;
      }
   }

}