package net.wg.gui.lobby.store
{
    import net.wg.gui.components.controls.ActionPrice;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.utils.Constraints;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.VO.StoreTableData;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.FittingTypes;
    
    public class StoreListItemRenderer extends ComplexListItemRenderer
    {
        
        public function StoreListItemRenderer() {
            super();
        }
        
        public var credits:ModuleRendererCredits = null;
        
        public var actionPrice:ActionPrice = null;
        
        public var errorField:TextField = null;
        
        public var hitMc:Sprite;
        
        override protected function onDispose() : void {
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.credits.dispose();
            this.credits = null;
            super.onDispose();
        }
        
        override protected function configUI() : void {
            super.configUI();
            TextFieldEx.setVerticalAlign(this.errorField,TextFieldEx.VALIGN_CENTER);
            constraints.addElement(textField.name,textField,Constraints.ALL);
            constraints.addElement(descField.name,descField,Constraints.ALL);
            constraints.addElement(this.credits.name,this.credits,Constraints.RIGHT);
            constraints.addElement(this.errorField.name,this.errorField,Constraints.ALL);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseClickHandler);
            hitArea = this.hitMc;
        }
        
        override protected function draw() : void {
            var _loc1_:Point = null;
            if(isInvalid(InvalidationType.DATA))
            {
                this.update();
                if(enabled)
                {
                    _loc1_ = new Point(mouseX,mouseY);
                    _loc1_ = this.localToGlobal(_loc1_);
                    if(this.hitTestPoint(_loc1_.x,_loc1_.y,true))
                    {
                        setState("over");
                        dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                    }
                }
            }
            super.draw();
            if(this.actionPrice)
            {
                this.actionPrice.setup(this);
            }
        }
        
        protected function update() : void {
            var _loc1_:StoreTableData = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:String = null;
            var _loc7_:* = 0;
            var _loc8_:String = null;
            if(data)
            {
                if(App.instance)
                {
                    _loc6_ = "data in shopTableItemRenderer must extends StoreTableData class!";
                    App.utils.asserter.assert(data is StoreTableData,_loc6_);
                }
                _loc1_ = StoreTableData(data);
                _loc2_ = 0;
                _loc3_ = 1;
                _loc4_ = _loc1_.price[_loc2_];
                _loc5_ = _loc1_.price[_loc3_];
                visible = true;
                this.onPricesCalculated(_loc5_,_loc4_,_loc1_);
                textField.text = _loc1_.name;
                descField.text = data.desc;
                if(descField.getLineLength(2) != -1)
                {
                    _loc7_ = 0;
                    _loc8_ = data.desc.substr(descField.getLineLength(0) + descField.getLineLength(1) - 1,1);
                    if(_loc8_ == "\n")
                    {
                        _loc7_ = -1;
                    }
                    else
                    {
                        _loc7_ = -3;
                    }
                    descField.text = descField.text.substr(0,descField.getLineLength(0) + descField.getLineLength(1) + _loc7_) + "...";
                }
                this.updateTexts(_loc1_,_loc5_,_loc4_);
                if(hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
                {
                    this.shopTooltip();
                }
            }
            else
            {
                visible = false;
            }
        }
        
        protected function onPricesCalculated(param1:Number, param2:Number, param3:StoreTableData) : void {
        }
        
        protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number) : void {
        }
        
        protected function getTooltipMapping() : StoreTooltipMapVO {
            throw new AbstractException("InventoryListItemRenderer::getTooltipMapping" + Errors.ABSTRACT_INVOKE);
        }
        
        protected final function infoItem() : void {
            dispatchEvent(new StoreEvent(StoreEvent.INFO,StoreTableData(data)));
        }
        
        protected final function getHelper() : StoreHelper {
            return StoreHelper.getInstance();
        }
        
        protected function onLeftButtonClick() : void {
        }
        
        protected function onRightButtonClick() : void {
            this.infoItem();
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void {
            if(App.instance)
            {
                App.toolTipMgr.hide();
            }
            if(enabled)
            {
                if(!_focused && !_displayFocus || !(focusIndicator == null))
                {
                    setState("out");
                }
            }
        }
        
        override protected function handleMousePress(param1:MouseEvent) : void {
            if(App.instance)
            {
                App.toolTipMgr.hide();
            }
            super.handleMousePress(param1);
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void {
            super.handleMouseRollOver(param1);
            this.shopTooltip();
        }
        
        private function shopTooltip() : void {
            var _loc1_:ITooltipMgr = null;
            var _loc2_:StoreTableData = null;
            var _loc3_:String = null;
            var _loc4_:* = NaN;
            if(App.instance)
            {
                _loc1_ = App.toolTipMgr;
                _loc2_ = StoreTableData(data);
                switch(_loc2_.itemTypeName)
                {
                    case FittingTypes.VEHICLE:
                        _loc1_.showSpecial(this.getTooltipMapping().vehId,null,_loc2_.id);
                        break;
                    case FittingTypes.SHELL:
                        _loc1_.showSpecial(this.getTooltipMapping().shellId,null,_loc2_.id,_loc2_.inventoryCount);
                        break;
                    default:
                        _loc3_ = this.getTooltipMapping().defaultId;
                        if(_loc3_ == Tooltips.INVENTORY_MODULE)
                        {
                            _loc4_ = _loc2_.currency == Currencies.GOLD?_loc2_.gold:_loc2_.credits;
                            _loc1_.showSpecial(_loc3_,null,_loc2_.id,_loc4_,_loc2_.currency,_loc2_.inventoryCount,_loc2_.vehicleCount);
                        }
                        else
                        {
                            _loc1_.showSpecial(_loc3_,null,_loc2_.id,_loc2_.inventoryCount,_loc2_.vehicleCount);
                        }
                }
            }
        }
        
        private function onMouseClickHandler(param1:MouseEvent) : void {
            if(App.utils.commons.isRightButton(param1))
            {
                this.onRightButtonClick();
            }
            else if((App.utils.commons.isLeftButton(param1)) && (enabled))
            {
                this.onLeftButtonClick();
            }
            
        }
    }
}
