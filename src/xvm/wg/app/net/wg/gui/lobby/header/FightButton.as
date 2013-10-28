package net.wg.gui.lobby.header
{
   import net.wg.infrastructure.base.meta.impl.FightButtonMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import net.wg.infrastructure.base.meta.IFightButtonMeta;
   import flash.events.Event;
   import net.wg.gui.components.controls.FightButtonSelect;
   import net.wg.gui.components.controls.SoundButton;
   import flash.display.DisplayObject;
   import net.wg.utils.IHelpLayout;
   import net.wg.data.constants.Directions;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.events.FightButtonEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.managers.impl.TooltipProps;


   public class FightButton extends FightButtonMeta implements IHelpLayoutComponent, IFightButtonMeta
   {
          
      public function FightButton() {
         super();
      }

      private static function hideTooltip(param1:Event) : void {
         App.toolTipMgr.hide();
      }

      public var buttondropdown:FightButtonSelect;

      public var button:SoundButton;

      public var demonstrationButton:SoundButton;

      private var _buttonHelpLayout:DisplayObject;

      private var _dropDownHelpLayout:DisplayObject;

      private var toolTip:String;

      private var mainButtonLabel:String;

      private var dropDownButtonLabel:String;

      private var items:Array;

      private var isDataInvalid:Boolean;

      private var isMainButtonLabelInvalid:Boolean;

      private var _actualEnabledVal:Boolean;

      public function as_disableFightButton(param1:Boolean, param2:String) : void {
         this._actualEnabledVal = this.button.enabled = !param1;
         this.button.validateNow();
         this.toolTip = param2;
         this.buttondropdown.validateNow();
         this.demonstrationButton.enabled = !param1;
         this.demonstrationButton.validateNow();
         App.toolTipMgr.hide();
      }

      public function as_setFightButton(param1:String, param2:String, param3:Array, param4:Boolean) : void {
         this.mainButtonLabel = param1;
         this.dropDownButtonLabel = param2?param2:MENU.HEADERBUTTONS_BATTLE;
         this.items = param3;
         this.isDataInvalid = true;
         this.isMainButtonLabelInvalid = true;
         this.buttondropdown.enabled = !param4;
         invalidate();
      }

      public function as_setDemonstratorButton(param1:Boolean) : void {
         this.demonstrationButton.visible = param1;
         this.demonstrationButton.enabled = this.button.enabled;
      }

      public function showHelpLayout() : void {
         this.buttondropdown.close();
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         var _loc2_:Object = _loc1_.getProps(152,37,Directions.LEFT,LOBBY_HELP.HEADER_FIGHT_BUTTON,0,0);
         this._buttonHelpLayout = _loc1_.create(root,_loc2_,this.button);
         _loc2_ = _loc1_.getProps(152,22,Directions.LEFT,LOBBY_HELP.HEADER_FIGHT_DROPDOWN,25,22);
         this._dropDownHelpLayout = _loc1_.create(root,_loc2_,this.buttondropdown);
      }

      public function closeHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         _loc1_.destroy(this._buttonHelpLayout);
         _loc1_.destroy(this._dropDownHelpLayout);
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.button)
         {
            this.button.removeEventListener(ButtonEvent.CLICK,this.onClick);
            removeEventListener(MouseEvent.CLICK,hideTooltip);
            removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         }
         if(this.buttondropdown)
         {
            this.buttondropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onFightSelect);
            this.buttondropdown.removeEventListener(FightButtonEvent.SELECT_TOGGLE,this.onSelectToggle);
         }
         this.buttondropdown.dispose();
         this.buttondropdown = null;
         this.button.dispose();
         this.button = null;
         this.demonstrationButton.removeEventListener(ButtonEvent.CLICK,this.onDemoClick);
         this.demonstrationButton.dispose();
         this.demonstrationButton = null;
         this._buttonHelpLayout = null;
         this._dropDownHelpLayout = null;
         this.items.splice(0,this.items.length);
         this.items = null;
      }

      override protected function configUI() : void {
         if(this.button)
         {
            this.button.label = MENU.HEADERBUTTONS_BATTLE;
            this.button.addEventListener(ButtonEvent.CLICK,this.onClick,false,0,true);
            addEventListener(MouseEvent.CLICK,hideTooltip,false,0,true);
            addEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,hideTooltip,false,0,true);
         }
         if(this.buttondropdown)
         {
            this.buttondropdown.visible = false;
            this.buttondropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onFightSelect,false,0,true);
            this.buttondropdown.addEventListener(FightButtonEvent.SELECT_TOGGLE,this.onSelectToggle,false,0,true);
         }
         this.demonstrationButton.addEventListener(ButtonEvent.CLICK,this.onDemoClick);
      }

      override protected function draw() : void {
         super.draw();
         if(this.isMainButtonLabelInvalid)
         {
            this.isMainButtonLabelInvalid = false;
            this.button.label = this.mainButtonLabel;
         }
         if(this.isDataInvalid)
         {
            this.isDataInvalid = false;
            this.buttondropdown.fightBtnlabel = this.dropDownButtonLabel;
            this.buttondropdown.menuRowCount = this.items.length;
            this.buttondropdown.dataProvider = new DataProvider(this.items);
            this.buttondropdown.selectedIndex = -1;
            this.buttondropdown.validateNow();
            this.buttondropdown.visible = true;
         }
      }

      private function onDemoClick(param1:ButtonEvent) : void {
         demoClickS();
      }

      private function onClick(param1:ButtonEvent) : void {
         fightClickS(0,"");
      }

      private function showTooltip(param1:Event) : void {
         if((this.button) && (this.toolTip))
         {
            App.toolTipMgr.showComplex(this.toolTip,TooltipProps.WARNING);
         }
      }

      private function onFightSelect(param1:ListEvent) : void {
         if((this.buttondropdown.enabled) && !(param1.index == -1))
         {
            fightSelectClickS(param1.itemData.data);
            this.buttondropdown.selectedIndex = -1;
         }
      }

      private function onSelectToggle(param1:FightButtonEvent) : void {
         if(param1.target.selected)
         {
            this._actualEnabledVal = this.button.enabled;
            this.button.enabled = false;
         }
         else
         {
            this.button.enabled = this._actualEnabledVal;
         }
      }
   }

}