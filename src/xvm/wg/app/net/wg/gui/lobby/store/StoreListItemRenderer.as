package net.wg.gui.lobby.store 
{
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.managers.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.utils.*;
    
    public class StoreListItemRenderer extends net.wg.gui.lobby.store.ComplexListItemRenderer
    {
        public function StoreListItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(textField.name, textField, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(descField.name, descField, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.credits.name, this.credits, scaleform.clik.utils.Constraints.RIGHT);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onMouseClickHandler);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.update();
                if (enabled) 
                {
                    loc1 = new flash.geom.Point(mouseX, mouseY);
                    loc1 = this.localToGlobal(loc1);
                    if (this.hitTestPoint(loc1.x, loc1.y, true)) 
                    {
                        setState("over");
                        dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.ROLL_OVER));
                    }
                }
            }
            super.draw();
            return;
        }

        protected function update():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=null;
            if (data) 
            {
                if (App.instance) 
                {
                    loc6 = "data in shopTableItemRenderer must extends StoreTableData class!";
                    App.utils.asserter.assert(data is net.wg.data.VO.StoreTableData, loc6);
                }
                loc1 = net.wg.data.VO.StoreTableData(data);
                loc2 = 0;
                loc3 = 1;
                loc4 = loc1.price[loc2];
                loc5 = loc1.price[loc3];
                visible = true;
                this.onPricesCalculated(loc5, loc4, loc1);
                textField.text = loc1.name;
                descField.text = loc1.desc;
                this.updateTexts(loc1, loc5, loc4);
                if (hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) 
                {
                    this.shopTooltip();
                }
            }
            else 
            {
                visible = false;
            }
            return;
        }

        protected function onPricesCalculated(arg1:Number, arg2:Number, arg3:net.wg.data.VO.StoreTableData):void
        {
            return;
        }

        protected function updateTexts(arg1:net.wg.data.VO.StoreTableData, arg2:Number, arg3:Number):void
        {
            return;
        }

        protected function getTooltipMapping():net.wg.gui.lobby.store.StoreTooltipMapVO
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("InventoryListItemRenderer::getTooltipMapping" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected final function infoItem():void
        {
            dispatchEvent(new net.wg.gui.lobby.store.StoreEvent(net.wg.gui.lobby.store.StoreEvent.INFO, net.wg.data.VO.StoreTableData(data)));
            return;
        }

        protected final function getHelper():net.wg.gui.lobby.store.StoreHelper
        {
            return net.wg.gui.lobby.store.StoreHelper.getInstance();
        }

        protected function onLeftButtonClick():void
        {
            return;
        }

        protected function onRightButtonClick():void
        {
            this.infoItem();
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            if (App.instance) 
            {
                App.toolTipMgr.hide();
            }
            if (enabled) 
            {
                if (!_focused && !_displayFocus || !(focusIndicator == null)) 
                {
                    setState("out");
                }
            }
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            if (App.instance) 
            {
                App.toolTipMgr.hide();
            }
            if (enabled) 
            {
                setState("down");
                if (!autoRepeat) 
                {
                };
            }
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            this.shopTooltip();
            return;
        }

        internal function shopTooltip():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            if (App.instance) 
            {
                loc1 = App.toolTipMgr;
                loc2 = net.wg.data.VO.StoreTableData(data);
                var loc5:*=loc2.itemTypeName;
                switch (loc5) 
                {
                    case net.wg.data.constants.FittingTypes.VEHICLE:
                    {
                        loc1.showSpecial(this.getTooltipMapping().vehId, null, loc2.id);
                        break;
                    }
                    case net.wg.data.constants.FittingTypes.SHELL:
                    {
                        loc1.showSpecial(this.getTooltipMapping().shellId, null, loc2.id, loc2.inventoryCount);
                        break;
                    }
                    default:
                    {
                        loc3 = this.getTooltipMapping().defaultId;
                        if (loc3 != net.wg.data.constants.Tooltips.INVENTORY_MODULE) 
                        {
                            loc1.showSpecial(loc3, null, loc2.id, loc2.inventoryCount, loc2.vehicleCount);
                        }
                        else 
                        {
                            loc4 = loc2.currency != net.wg.data.constants.Currencies.GOLD ? loc2.credits : loc2.gold;
                            loc1.showSpecial(loc3, null, loc2.id, loc4, loc2.currency, loc2.inventoryCount, loc2.vehicleCount);
                        }
                        break;
                    }
                }
            }
            return;
        }

        internal function onMouseClickHandler(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isRightButton(arg1)) 
            {
                this.onRightButtonClick();
            }
            else if (App.utils.commons.isLeftButton(arg1) && enabled) 
            {
                this.onLeftButtonClick();
            }
            return;
        }

        public var credits:net.wg.gui.lobby.store.ModuleRendererCredits=null;

        public var errorField:flash.text.TextField=null;
    }
}
