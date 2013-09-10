package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    import net.wg.gui.lobby.hangar.maintenance.events.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;
    
    public class EquipmentListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function EquipmentListItemRenderer()
        {
            super();
            soundType = "artefactRenderer";
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=App.utils.events;
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            loc1.addEvent(this, flash.events.MouseEvent.CLICK, this.onClick);
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (data) 
                {
                    visible = true;
                    if (this.module.target == 1 && !(this.module.status == "")) 
                    {
                        var loc1:*;
                        this.descField.text = loc1 = "";
                        this.titleField.text = loc1;
                    }
                    else 
                    {
                        this.titleField.text = this.module.name;
                        this.descField.text = this.module.desc;
                    }
                    this.icon.source = this.module.icon;
                    this.priceMC.visible = false;
                    if (this.module.target != 3) 
                        if (this.module.target != 2) 
                            if (this.module.target == 1) 
                            {
                                this.targetMC.gotoAndPlay("vehicle");
                                this.targetMC.textField.text = this.module.status != "" ? MENU.FITTINGLISTITEMRENDERER_REPLACE : "";
                            }
                        else if (this.module.status != "") 
                            if (!(this.module.status == MENU.MODULEFITS_CREDIT_ERROR) && this.module.status == MENU.MODULEFITS_GOLD_ERROR) 
                                this.targetMC.gotoAndPlay("hangarCantInstall");
                        else 
                            this.targetMC.gotoAndPlay("hangar");
                    else 
                    {
                        this.priceMC.visible = true;
                        if (this.module.currency != net.wg.data.constants.Currencies.GOLD) 
                        {
                            this.priceMC.text = App.utils.locale.integer(this.module.price);
                            this.priceMC.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.CREDITS];
                        }
                        else 
                        {
                            this.priceMC.text = App.utils.locale.gold(this.module.price);
                            this.priceMC.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.GOLD];
                        }
                        if (this.module.status == MENU.MODULEFITS_CREDIT_ERROR || this.module.status == MENU.MODULEFITS_GOLD_ERROR) 
                            this.priceMC.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.ERROR];
                        else if (this.module.status != "") 
                            this.priceMC.textColor = 6710886;
                        this.priceMC.icon = this.module.currency;
                        this.priceMC.validateNow();
                        this.targetMC.gotoAndStop("shop");
                    }
                    this.errorField.text = this.module.status;
                    enabled = !(this.module.status == MENU.MODULEFITS_UNLOCK_ERROR) && !(this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT);
                    mouseEnabled = true;
                }
                else 
                    visible = false;
            super.draw();
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent):void
        {
            owner.dispatchEvent(new net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver(net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.module.id, this.module.prices, this.module.inventoryCount, this.module.vehicleCount, this.module.slotIndex));
            return;
        }

        internal function onRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
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
                    dispatchEvent(new net.wg.gui.events.ModuleInfoEvent(net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.module.id));
            }
            return;
        }

        internal function get module():net.wg.gui.lobby.hangar.maintenance.data.ModuleVO
        {
            return data as net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var titleField:flash.text.TextField;

        public var descField:flash.text.TextField;

        public var errorField:flash.text.TextField;

        public var priceMC:net.wg.gui.components.controls.IconText;

        public var targetMC:flash.display.MovieClip;
    }
}
