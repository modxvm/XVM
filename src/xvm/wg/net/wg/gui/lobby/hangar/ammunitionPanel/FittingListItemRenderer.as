package net.wg.gui.lobby.hangar.ammunitionPanel 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class FittingListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function FittingListItemRenderer()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidateData();
            this.onRollOut();
            return;
        }

        public function onRemoveButtonClick(arg1:Object):void
        {
            var loc1:*=arg1.target == this.removeButton && !data.removable;
            dispatchEvent(new net.wg.gui.events.DeviceEvent(net.wg.gui.events.DeviceEvent.DEVICE_REMOVE, data, data, loc1));
            return;
        }

        public function processRemove(arg1:Boolean):void
        {
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=App.utils.events;
            if (this.destroyButton) 
            {
                this.destroyButton.focusTarget = this;
                loc1.addEvent(this.destroyButton, scaleform.clik.events.ButtonEvent.CLICK, this.onRemoveButtonClick);
            }
            if (this.removeButton) 
            {
                this.removeButton.focusTarget = this;
                loc1.addEvent(this.removeButton, scaleform.clik.events.ButtonEvent.CLICK, this.onRemoveButtonClick);
            }
            if (this.locked) 
            {
                this.locked.visible = false;
                var loc2:*;
                this.locked.mouseChildren = loc2 = false;
                this.locked.mouseEnabled = loc2;
            }
            if (this.icon) 
            {
                this.icon.mouseChildren = loc2 = false;
                this.icon.mouseEnabled = loc2;
            }
            if (this.priceMC) 
            {
                this.priceMC.mouseChildren = loc2 = false;
                this.priceMC.mouseEnabled = loc2;
                this.priceMC.textFieldYOffset = 2;
            }
            if (this.targetMC) 
            {
                this.targetMC.mouseChildren = loc2 = false;
                this.targetMC.mouseEnabled = loc2;
            }
            if (this.titleField) 
            {
                this.titleField.mouseEnabled = false;
            }
            if (this.descField) 
            {
                this.descField.mouseEnabled = false;
            }
            if (this.errorField) 
            {
                this.errorField.mouseEnabled = false;
            }
            loc1.addEvent(this, flash.events.MouseEvent.CLICK, this.onClick);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.setup();
            }
            super.draw();
            return;
        }

        protected function createExtraIcon():void
        {
            this.extraIcon = new net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon();
            App.utils.events.addEvent(this.extraIcon, net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.onExtraIconLoaded, false, 0, true);
            this.extraIcon.mouseChildren = false;
            this.extraIcon.mouseEnabled = false;
            addChild(this.extraIcon);
            return;
        }

        internal function setup():void
        {
            if (!data) 
            {
                return;
            }
            this.titleField.text = data.name;
            if (this.descField) 
            {
                this.descField.text = data.desc;
            }
            if (net.wg.data.constants.FittingTypes.MANDATORY_SLOTS.indexOf(data.type) > -1) 
            {
                (this.icon as flash.display.MovieClip).gotoAndStop(data.icon);
            }
            else 
            {
                (this.icon as net.wg.gui.components.controls.UILoaderAlt).source = data.icon;
            }
            if (data.hasOwnProperty(net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon.EXTRA_ICON_PROP_NAME)) 
            {
                if (!this.extraIcon) 
                {
                    this.createExtraIcon();
                }
                this.extraIcon.setSource(data[net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon.EXTRA_ICON_PROP_NAME]);
            }
            else if (this.extraIcon) 
            {
                this.extraIcon.clear();
            }
            if (this.priceMC) 
            {
                this.targetMC.visible = true;
                this.priceMC.visible = false;
                if (data.target != 3) 
                {
                    if (data.target != 2) 
                    {
                        if (data.target == 1) 
                        {
                            this.targetMC.gotoAndPlay(VEHICLE_STATE);
                        }
                    }
                    else if (data.status != "") 
                    {
                        if (data.status != MENU.MODULEFITS_CREDIT_ERROR) 
                        {
                            this.targetMC.gotoAndPlay(HANGAR_CANT_INSTALL_STATE);
                        }
                    }
                    else 
                    {
                        this.targetMC.gotoAndPlay(HANGAR_STATE);
                    }
                }
                else 
                {
                    this.priceMC.icon = data.currency;
                    if (data.currency != net.wg.data.constants.Currencies.GOLD) 
                    {
                        this.priceMC.text = App.utils.locale.integer(data.price);
                    }
                    else 
                    {
                        this.priceMC.text = App.utils.locale.gold(data.price);
                    }
                    if (data.status != MENU.MODULEFITS_CREDIT_ERROR) 
                    {
                        if (data.status == "") 
                        {
                            this.priceMC.textColor = 13556185;
                        }
                        else 
                        {
                            this.priceMC.textColor = 6710886;
                        }
                    }
                    else 
                    {
                        this.priceMC.textColor = 10158594;
                    }
                    this.targetMC.gotoAndPlay(SHOP_STATE);
                    this.priceMC.visible = true;
                    this.targetMC.visible = false;
                    this.priceMC.validateNow();
                }
            }
            else 
            {
                this.targetMC.visible = false;
            }
            if (this.locked) 
            {
                this.locked.visible = !data.removable;
            }
            this.errorField.text = data.status;
            this.enabled = !(data.status == MENU.MODULEFITS_CREDIT_ERROR || data.status == MENU.MODULEFITS_UNLOCK_ERROR || data.status == MENU.MODULEFITS_WRONG_SLOT);
            if (this.destroyButton) 
            {
                this.destroyButton.label = MENU.MODULEFITS_DESTROYNAME;
                this.destroyButton.icon = DESTROY_IMG;
                this.destroyButton.visible = !data.removable && data.isSelected;
                this.destroyButton.validateNow();
            }
            if (this.removeButton) 
            {
                this.removeButton.label = MENU.MODULEFITS_REMOVENAME;
                this.removeButton.icon = data.removable ? REMOVE_IMG : REMOVE_GOLD_IMG;
                this.removeButton.visible = data.isSelected;
                this.descField.visible = !data.isSelected;
                this.removeButton.validateNow();
            }
            this.errorField.visible = !data.isSelected;
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            mouseEnabled = true;
            mouseChildren = true;
            buttonMode = enabled;
            return;
        }

        internal function onClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            App.toolTipMgr.hide();
            if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                if (loc1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                {
                    dispatchEvent(new net.wg.gui.events.ModuleInfoEvent(net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, data.id));
                }
            }
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent=null):void
        {
            var loc1:*=[0, 0];
            loc1[data.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0] = data.price;
            var loc2:*=new net.wg.data.managers.impl.TooltipProps("", stage.mouseX, stage.mouseY);
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.HANGAR_MODULE, null, data.id, loc1, data.inventoryCount, data.vehicleCount, data.slotIndex ? data.slotIndex : 0);
            return;
        }

        internal function onRollOut(arg1:flash.events.MouseEvent=null):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onExtraIconLoaded(arg1:flash.events.Event):void
        {
            this.extraIcon.x = Math.round(this.icon.x + 3);
            this.extraIcon.y = Math.round(this.icon.y + this.icon.height + 7);
            return;
        }

        internal static const DESTROY_IMG:String="destroy.png";

        internal static const REMOVE_IMG:String="remove.png";

        internal static const REMOVE_GOLD_IMG:String="removeGold.png";

        internal static const SHOP_STATE:String="shop";

        internal static const HANGAR_STATE:String="hangar";

        internal static const HANGAR_CANT_INSTALL_STATE:String="hangarCantInstall";

        internal static const VEHICLE_STATE:String="vehicle";

        public var removeButton:net.wg.gui.components.controls.IconTextButton;

        public var destroyButton:net.wg.gui.components.controls.IconTextButton;

        public var locked:flash.display.MovieClip;

        public var icon:*;

        public var titleField:flash.text.TextField;

        public var descField:flash.text.TextField;

        public var errorField:flash.text.TextField;

        public var priceMC:net.wg.gui.components.controls.IconText;

        public var targetMC:flash.display.MovieClip;

        public var clickArea:flash.display.MovieClip;

        internal var extraIcon:net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;
    }
}
