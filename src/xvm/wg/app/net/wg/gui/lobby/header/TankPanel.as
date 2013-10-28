package net.wg.gui.lobby.header
{
   import scaleform.clik.core.UIComponent;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ClanEmblem;
   import flash.text.TextFormat;


   public class TankPanel extends UIComponent
   {
          
      public function TankPanel() {
         super();
      }

      private static const INVALIDATE_CLAN_EMBLEM:String = "ClanEmblem";

      private static const INVALIDATE_TANK_ELITE:String = "TankElite";

      private static function showTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.HEADER_ELITEICON);
      }

      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var elite:MovieClip;

      public var tank_name:TextField;

      public var tank_type:TextField;

      public var account_name:TextField;

      public var clan_name:TextField;

      public var clanEmblem:ClanEmblem;

      private var _eliteVisible:Boolean = false;

      private var _clanEmblemVisible:Boolean = false;

      override protected function configUI() : void {
         this.elite.visible = false;
         this.tank_name.mouseEnabled = false;
         this.tank_type.mouseEnabled = false;
         this.account_name.mouseEnabled = false;
         this.clan_name.mouseEnabled = false;
         this.elite.useHandCursor = false;
         this.elite.addEventListener(MouseEvent.ROLL_OVER,showTooltip);
         this.elite.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
      }

      override public function dispose() : void {
         this.elite.removeEventListener(MouseEvent.ROLL_OVER,showTooltip);
         this.elite.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.elite = null;
         this.tank_name = null;
         this.tank_type = null;
         this.account_name = null;
         this.clan_name = null;
         this.clanEmblem.dispose();
         this.clanEmblem = null;
         super.dispose();
      }

      public function setClanEmblem(param1:String) : void {
         this.clanEmblem.setImage(param1);
         this.clanEmblem.visible = true;
      }

      public function setTankName(param1:String) : void {
         var _loc2_:String = null;
         if(param1.length != 0)
         {
            _loc2_ = App.utils.locale.makeString(param1,{});
            this.tank_name.text = _loc2_;
         }
         else
         {
            this.tank_name.text = "";
         }
      }

      public function setAccountName(param1:String, param2:Boolean, param3:Boolean) : void {
         this.account_name.text = param1;
         var _loc4_:TextFormat = this.account_name.getTextFormat();
         if(param2)
         {
            _loc4_.color = 60159;
            this.account_name.setTextFormat(_loc4_);
         }
         this._clanEmblemVisible = param3;
         invalidate(INVALIDATE_CLAN_EMBLEM);
      }

      public function setTankType(param1:String) : void {
         var _loc2_:String = null;
         if(param1.length != 0)
         {
            _loc2_ = App.utils.locale.makeString(MENU.tankmen(param1),{});
            this.tank_type.text = _loc2_.toUpperCase();
         }
         else
         {
            this.tank_type.text = "";
         }
      }

      public function setTankElite(param1:Boolean) : void {
         if(this._eliteVisible == param1)
         {
            return;
         }
         this._eliteVisible = param1;
         invalidate(INVALIDATE_TANK_ELITE);
      }

      override protected function draw() : void {
         if(isInvalid(INVALIDATE_TANK_ELITE))
         {
            this.elite.visible = this._eliteVisible;
         }
         if(isInvalid(INVALIDATE_CLAN_EMBLEM))
         {
            this.clanEmblem.visible = this._clanEmblemVisible;
         }
      }
   }

}