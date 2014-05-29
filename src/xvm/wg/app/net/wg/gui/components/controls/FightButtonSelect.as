package net.wg.gui.components.controls
{
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IOpenPopoverCallback;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import net.wg.gui.events.FightButtonEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.Aliases;
   import flash.display.DisplayObject;


   public class FightButtonSelect extends SoundButtonEx implements IPopOverCaller, IClosePopoverCallback, IOpenPopoverCallback
   {
          
      public function FightButtonSelect() {
         super();
      }

      public static function showTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.HEADER_FIGHT_BUTTON_DROPDOWN);
      }

      public static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var iconText:IconText;

      public var hit_mc:MovieClip;

      protected var _fightBtnlabel:String;

      public function get fightBtnlabel() : String {
         return _label;
      }

      public function set fightBtnlabel(param1:String) : void {
         if(this._fightBtnlabel == param1)
         {
            return;
         }
         this._fightBtnlabel = param1;
         invalidateData();
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         dispatchEvent(new FightButtonEvent(FightButtonEvent.SELECT_TOGGLE));
      }

      override protected function updateText() : void {
         if(!(this._fightBtnlabel == null) && !(this.iconText == null))
         {
            this.iconText.text = this._fightBtnlabel;
            this.iconText.validateNow();
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.hitArea = this.hit_mc;
         this.iconText.icon = "arrowDown";
         this.iconText.textColor = 14008503;
         this.iconText.validateNow();
         addEventListener(MouseEvent.ROLL_OVER,showTooltip,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,hideTooltip,false,0,true);
         addEventListener(ButtonEvent.CLICK,this.showPopoverHandler,false,0,true);
      }

      private function showPopoverHandler(param1:ButtonEvent) : void {
         App.popoverMgr.show(this,Aliases.BATTLE_TYPE_SELECT_POPOVER,0,0,null,this,this);
      }

      public function onPopoverOpen() : void {
         this.iconText.icon = "arrowUp";
         this.iconText.validateNow();
      }

      public function onPopoverClose() : void {
         this.iconText.icon = "arrowDown";
         this.iconText.validateNow();
      }

      override protected function onDispose() : void {
         removeEventListener(ButtonEvent.CLICK,this.showPopoverHandler);
         removeEventListener(MouseEvent.ROLL_OVER,showTooltip,false);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip,false);
         removeEventListener(MouseEvent.MOUSE_DOWN,hideTooltip,false);
         this.iconText.dispose();
         super.onDispose();
      }

      public function getTargetButton() : DisplayObject {
         return this.hit_mc;
      }

      public function getHitArea() : DisplayObject {
         return this;
      }
   }

}