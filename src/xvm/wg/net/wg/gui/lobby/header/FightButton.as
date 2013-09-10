package net.wg.gui.lobby.header 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class FightButton extends net.wg.infrastructure.base.meta.impl.FightButtonMeta implements net.wg.infrastructure.interfaces.IHelpLayoutComponent, net.wg.infrastructure.base.meta.IFightButtonMeta
    {
        public function FightButton()
        {
            super();
            return;
        }

        public function as_disableFightButton(arg1:Boolean, arg2:String):void
        {
            this.button.enabled = !arg1;
            this.button.validateNow();
            this.toolTip = arg2;
            this.buttondropdown.enabled = !arg1;
            this.buttondropdown.validateNow();
            this.demonstrationButton.enabled = !arg1;
            this.buttondropdown.validateNow();
            App.toolTipMgr.hide();
            return;
        }

        public function as_setFightButton(arg1:String, arg2:String, arg3:Array):void
        {
            this.mainButtonLabel = arg1;
            this.dropDownButtonLabel = arg2 ? arg2 : MENU.HEADERBUTTONS_BATTLE;
            this.items = arg3;
            this.isDataInvalid = true;
            this.isMainButtonLabelInvalid = true;
            invalidate();
            return;
        }

        public function as_setDemonstratorButton(arg1:Boolean):void
        {
            this.demonstrationButton.visible = arg1;
            this.demonstrationButton.enabled = this.button.enabled;
            return;
        }

        public function showHelpLayout():void
        {
            this.buttondropdown.close();
            var loc1:*=App.utils.helpLayout;
            var loc2:*=loc1.getProps(152, 37, net.wg.data.constants.Directions.LEFT, LOBBY_HELP.HEADER_FIGHT_BUTTON, 0, 0);
            this._buttonHelpLayout = loc1.create(root, loc2, this.button);
            loc2 = loc1.getProps(152, 22, net.wg.data.constants.Directions.LEFT, LOBBY_HELP.HEADER_FIGHT_DROPDOWN, 25, 22);
            this._dropDownHelpLayout = loc1.create(root, loc2, this.buttondropdown);
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._buttonHelpLayout);
            loc1.destroy(this._dropDownHelpLayout);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.button) 
            {
                this.button.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClick);
                removeEventListener(flash.events.MouseEvent.CLICK, hideTooltip);
                removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
                removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            }
            if (this.buttondropdown) 
                this.buttondropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onFightSelect);
            this.demonstrationButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDemoClick);
            return;
        }

        protected override function configUI():void
        {
            if (this.button) 
            {
                this.button.label = MENU.HEADERBUTTONS_BATTLE;
                this.button.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClick, false, 0, true);
                addEventListener(flash.events.MouseEvent.CLICK, hideTooltip, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip, false, 0, true);
            }
            if (this.buttondropdown) 
            {
                this.buttondropdown.visible = false;
                this.buttondropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onFightSelect, false, 0, true);
            }
            this.demonstrationButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDemoClick);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isMainButtonLabelInvalid) 
            {
                this.isMainButtonLabelInvalid = false;
                this.button.label = this.mainButtonLabel;
            }
            if (this.isDataInvalid) 
            {
                this.isDataInvalid = false;
                this.buttondropdown.fightBtnlabel = this.dropDownButtonLabel;
                this.buttondropdown.menuRowCount = this.items.length;
                this.buttondropdown.dataProvider = new scaleform.clik.data.DataProvider(this.items);
                this.buttondropdown.selectedIndex = -1;
                this.buttondropdown.validateNow();
                this.buttondropdown.visible = true;
            }
            return;
        }

        internal function onDemoClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            demoClickS();
            return;
        }

        internal function onClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            fightClickS(0, "");
            return;
        }

        internal function showTooltip(arg1:flash.events.Event):void
        {
            if (this.button && this.toolTip) 
                App.toolTipMgr.showComplex(this.toolTip, net.wg.data.managers.impl.TooltipProps.WARNING);
            return;
        }

        internal function onFightSelect(arg1:scaleform.clik.events.ListEvent):void
        {
            if (this.buttondropdown.enabled && !(arg1.index == -1)) 
            {
                fightSelectClickS(arg1.itemData.data);
                this.buttondropdown.selectedIndex = -1;
            }
            return;
        }

        internal static function hideTooltip(arg1:flash.events.Event):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var buttondropdown:net.wg.gui.components.controls.FightButtonSelect;

        public var button:net.wg.gui.components.controls.SoundButton;

        public var demonstrationButton:net.wg.gui.components.controls.SoundButton;

        internal var _buttonHelpLayout:flash.display.DisplayObject;

        internal var _dropDownHelpLayout:flash.display.DisplayObject;

        internal var toolTip:String;

        internal var mainButtonLabel:String;

        internal var dropDownButtonLabel:String;

        internal var items:Array;

        internal var isDataInvalid:Boolean;

        internal var isMainButtonLabelInvalid:Boolean;
    }
}
