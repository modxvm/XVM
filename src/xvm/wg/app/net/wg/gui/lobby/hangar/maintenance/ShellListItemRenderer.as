package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;
    
    public class ShellListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function ShellListItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.SHELL_ITEM_RENDERER;
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
            this.desc.text = MENU.SHELLLISTITEMRENDERER_REPLACE;
            var loc1:*=App.utils.events;
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            loc1.addEvent(this, flash.events.MouseEvent.CLICK, this.onClick);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (data) 
                {
                    visible = true;
                    this.icon.visible = true;
                    this.icon.source = data.icon;
                    this.title.text = data.ammoName;
                    this.price.icon = data.currency;
                    this.price.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[data.currency];
                    loc1 = App.utils.locale;
                    this.price.text = data.currency != net.wg.data.constants.Currencies.CREDITS ? loc1.gold(data.prices[1]) : loc1.integer(data.prices[0]);
                    this.price.validateNow();
                }
                else 
                {
                    visible = false;
                }
            }
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TECH_MAIN_SHELL, null, data.id, data.prices, data.inventoryCount, data.count);
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
                {
                    dispatchEvent(new net.wg.gui.events.ModuleInfoEvent(net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, net.wg.gui.lobby.hangar.maintenance.data.ShellVO(data).id));
                }
            }
            return;
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var title:flash.text.TextField;

        public var desc:flash.text.TextField;

        public var price:net.wg.gui.components.controls.IconText;
    }
}
