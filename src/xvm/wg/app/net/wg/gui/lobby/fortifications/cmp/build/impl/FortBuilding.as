package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import net.wg.gui.lobby.fortifications.data.FunctionalStates;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.utils.ITweenAnimator;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.lobby.fortifications.utils.impl.TweenAnimator;
    import net.wg.utils.IScheduler;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingsContainer;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;
    import flash.geom.Point;
    import net.wg.gui.lobby.fortifications.cmp.build.IArrowWithNut;
    import net.wg.data.constants.Cursors;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    import net.wg.gui.lobby.fortifications.utils.IBuildingsCIGenerator;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.gui.lobby.fortifications.utils.impl.BuildingsCIGenerator;
    
    public class FortBuilding extends FortBuildingUIBase implements IFortBuilding
    {
        
        public function FortBuilding() {
            super();
            this.updateInteractionEnabling(false);
            indicators.mouseEnabled = indicators.mouseChildren = false;
            trowel.mouseEnabled = trowel.mouseChildren = false;
            this.updateOrderTime();
            cooldownIcon.visible = false;
            this.commons = App.utils.commons;
            hitAreaControl.alpha = 0;
            this.addCommonBuildingListeners();
        }
        
        private static var ALPHA_DISABLED:Number = 0.33;
        
        private static var ALPHA_ENABLED:Number = 1;
        
        private static var SATURATION_DISABLED:Number = 100;
        
        private static var SATURATION_ENABLED:Number = 0;
        
        private static var HALF_TURN_SCHEDULER_TIME:int = 2000;
        
        private var model:BuildingVO = null;
        
        private var _isCommander:Boolean = false;
        
        private var _uid:String = "";
        
        private var isShowCtxMenu:Boolean = false;
        
        private var _selected:Boolean = false;
        
        private var mouseOverTrigger:Boolean = true;
        
        private var requestOpenPopOver:Boolean = false;
        
        private var requestOpenCtxMenu:Boolean = false;
        
        private var commons:ICommons = null;
        
        private var isInExporting:Boolean = false;
        
        private var isInImporting:Boolean = false;
        
        private var inDirectionMode:Boolean = false;
        
        private var toolTipHeader:String;
        
        private var toolTipBody:String;
        
        private var isDisableCursor:Boolean = false;
        
        private var _lastState:Number = -1;
        
        private var isTutorial:Boolean = false;
        
        private var data:Vector.<IContextItem>;
        
        private var frameCount:int = 0;
        
        private var actionType:int = 0;
        
        private var _contextMenu:IContextMenu = null;
        
        public function getCustomHitArea() : InteractiveObject {
            return hitAreaControl;
        }
        
        public function setData(param1:BuildingVO) : void {
            var _loc2_:String = null;
            if(this.model != null)
            {
                _loc2_ = this.model.cooldown;
            }
            if((this.model) && (this.requestOpenCtxMenu) && param1.uid == FORTIFICATION_ALIASES.FORT_UNKNOWN)
            {
                this.requestOpenCtxMenu = false;
                App.contextMenuMgr.hide();
            }
            this.model = param1;
            visible = !(this.model == null);
            if(visible)
            {
                if(_loc2_ != param1.cooldown)
                {
                    if(!this.isInNormalMode() && !this.inDirectionMode)
                    {
                        this.showCooldown(this.isInCooldown());
                    }
                }
                this.isDisableCursor = !this._isCommander && (this.isTrowelState());
                App.utils.asserter.assertNotNull(this.model,"model" + Errors.CANT_NULL);
                this.model.validate();
                this._uid = buildingMc.uid = this.model.uid;
                this.buildingCtxMenu();
                this.setState(this.model.progress);
                indicators.applyVOData(this.model);
                hitAreaControl.soundType = this.model.uid;
                hitAreaControl.setData(this.model.uid,this.model.progress,this._isCommander);
                if((this.isInExporting) && !this.model.isExportAvailable || (this.isInImporting) && !this.model.isImportAvailable)
                {
                    this.removeTransportingListeners();
                }
                this.updateEnabling();
            }
        }
        
        public function updateCommonMode(param1:Boolean, param2:Boolean) : void {
            this.isTutorial = param2;
        }
        
        public function updateTransportMode(param1:Boolean, param2:Boolean) : void {
            switch(FortCommonUtils.instance.getFunctionalState(param1,param2))
            {
                case FunctionalStates.ENTER:
                    this.isInExporting = true;
                    cooldownIcon.visible = false;
                    this.showCooldown(this.isInCooldown());
                    if(this.isExportAvailable())
                    {
                        this.addTransportingListeners();
                    }
                    this.showIndicators(true);
                    this.updateEnabling();
                    break;
                case FunctionalStates.LEAVE:
                    this.isInExporting = false;
                    this.isInImporting = false;
                    this.showIndicators(false);
                    cooldownIcon.visible = this.isInCooldown();
                    this.showCooldown(false);
                    if(exportArrow.isShowed)
                    {
                        exportArrow.hide();
                    }
                    if(importArrow.isShowed)
                    {
                        importArrow.hide();
                    }
                    this.updateEnabling();
                    break;
            }
            if(param1)
            {
                this.addTransportingTooltipListener();
            }
            else
            {
                this.removeTransportingTooltipListener();
                this.removeTransportingListeners();
            }
        }
        
        public function updateDirectionsMode(param1:Boolean, param2:Boolean) : void {
            this.inDirectionMode = param1;
            this.updateEnabling();
        }
        
        public function nextTransportingStep(param1:Boolean) : void {
            this.isInExporting = false;
            this.isInImporting = true;
            if((this.isImportAvailable()) && !param1)
            {
                this.addTransportingListeners();
            }
            else
            {
                this.removeTransportingListeners();
            }
            this.updateEnabling();
        }
        
        public function isAvailable() : Boolean {
            return !(this.model == null);
        }
        
        public function isExportAvailable() : Boolean {
            return (this.isAvailable()) && (this.model.isExportAvailable);
        }
        
        public function isImportAvailable() : Boolean {
            return (this.isAvailable()) && (this.model.isImportAvailable);
        }
        
        public function onPopoverClose() : void {
            this.requestOpenPopOver = false;
            if(!this.mouseOverTrigger)
            {
                this.forceSelected = false;
            }
        }
        
        public function onComplete() : void {
        }
        
        public function getTargetButton() : DisplayObject {
            return buildingMc.getBuildingShape();
        }
        
        public function getHitArea() : DisplayObject {
            return hitAreaControl;
        }
        
        public function get selected() : Boolean {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void {
            if(this._selected == param1)
            {
                return;
            }
            if(this.requestOpenPopOver)
            {
                this.callPopOver();
            }
            this._selected = param1;
            if(!param1 && (this.mouseOverTrigger))
            {
                if((this.requestOpenPopOver) || (this.requestOpenCtxMenu))
                {
                    this._selected = param1 = true;
                    this.updateSelectedState(param1);
                }
                else
                {
                    this.setOverState();
                }
            }
            else
            {
                this.updateSelectedState(param1);
            }
            this.updateBlinkingBtn();
        }
        
        public function set forceSelected(param1:Boolean) : void {
            if(this._selected == param1)
            {
                return;
            }
            this.frameCount = 0;
            this.actionType = 0;
            this.selected = param1;
        }
        
        public function set isCommander(param1:Boolean) : void {
            this._isCommander = param1;
            if(this.model != null)
            {
                this.setState(this.model.progress);
            }
        }
        
        public function get uid() : String {
            return this._uid;
        }
        
        public function set uid(param1:String) : void {
            this._uid = param1;
        }
        
        public function set levelUpState(param1:Boolean) : void {
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                buildingMc.mouseEnabled = buildingMc.mouseChildren = false;
                indicators.mouseEnabled = indicators.mouseChildren = false;
                trowel.mouseEnabled = trowel.mouseChildren = false;
            }
        }
        
        override protected function onDispose() : void {
            this.removeAllListeners();
            App.stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandlerA);
            var _loc1_:ITweenAnimator = this.getTweenAnimator();
            _loc1_.removeAnims(DisplayObject(cooldownIcon));
            _loc1_.removeAnims(DisplayObject(indicators));
            _loc1_.removeAnims(orderProcess.hourglasses);
            this.getScheduler().cancelTask(this.doHalfTurnHourglasses);
            this._uid = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            this.commons = null;
            if(this._contextMenu != null)
            {
                DisplayObject(this._contextMenu).removeEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.closeEventHandler);
                DisplayObject(this._contextMenu).removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.closeEventHandler);
                this._contextMenu = null;
            }
            super.onDispose();
        }
        
        protected function showToolTip(param1:String, param2:String) : void {
            var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).addNote("",false).make();
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
        
        private function getTweenAnimator() : ITweenAnimator {
            return TweenAnimator.instance;
        }
        
        private function getScheduler() : IScheduler {
            return App.utils.scheduler;
        }
        
        private function isInNormalMode() : Boolean {
            return !this.isInExporting && !this.isInImporting && !this.inDirectionMode;
        }
        
        private function updateEnabling() : void {
            var _loc1_:* = false;
            if(this.isInNormalMode())
            {
                this.enableForAll();
            }
            else if(this.inDirectionMode)
            {
                this.disableForDirectionMode();
            }
            else if(this.isNotInCooldown())
            {
                _loc1_ = ((this.isExportAvailable()) && (this.isInExporting) || (this.isImportAvailable()) && (this.isInImporting)) && (this.isNotTrowelState());
                if(_loc1_)
                {
                    this.enableForTransporting();
                }
                else
                {
                    this.disableForTransporting();
                }
            }
            else
            {
                cooldownIcon.timeTextField.text = String(this.model.cooldown);
                this.disableForCooldown();
            }
            
            
            this.updateOrderTime();
            this.updateBlinkingBtn();
        }
        
        private function isInCooldown() : Boolean {
            return !(this.model == null) && !(this.model.cooldown == null);
        }
        
        private function isNotInCooldown() : Boolean {
            return !this.isInCooldown();
        }
        
        private function isTrowelState() : Boolean {
            return (this.model) && this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL;
        }
        
        private function isNotTrowelState() : Boolean {
            return !this.isTrowelState();
        }
        
        private function enableForAll() : void {
            buildingMc.building.alpha = ALPHA_ENABLED;
            buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
            trowel.alpha = ALPHA_ENABLED;
            ground.alpha = ALPHA_ENABLED;
            this.applySaturationForBuilding(false);
            this.updateInteractionEnabling(true);
            indicators.visible = this.isNotTrowelState();
            this.addCommonBuildingListeners();
        }
        
        private function disableForDirectionMode() : void {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.applySaturationForBuilding(true);
            this.updateInteractionEnabling(false);
            indicators.visible = false;
            this.removeCommonBuildingListeners();
        }
        
        private function enableForTransporting() : void {
            buildingMc.building.alpha = ALPHA_ENABLED;
            buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.applySaturationForBuilding(false);
            this.updateInteractionEnabling(true);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function disableForTransporting() : void {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.applySaturationForBuilding(true);
            this.updateInteractionEnabling(false);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function disableForCooldown() : void {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            this.applySaturationForBuilding(true);
            this.updateInteractionEnabling(false);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function showCooldown(param1:Boolean) : void {
            var _loc2_:ITweenAnimator = null;
            if(cooldownIcon.visible != param1)
            {
                _loc2_ = this.getTweenAnimator();
                _loc2_.removeAnims(DisplayObject(cooldownIcon));
                if(param1)
                {
                    cooldownIcon.timeTextField.text = String(this.model.cooldown);
                    _loc2_.addFadeInAnim(DisplayObject(cooldownIcon),null);
                }
                else
                {
                    _loc2_.addFadeOutAnim(DisplayObject(cooldownIcon),null);
                }
            }
        }
        
        private function applySaturationForBuilding(param1:Boolean) : void {
            var _loc2_:Number = param1?SATURATION_ENABLED:SATURATION_DISABLED;
            App.utils.commons.setSaturation(Sprite(buildingMc.building),_loc2_);
            App.utils.commons.setSaturation(trowel,_loc2_);
        }
        
        private function updateInteractionEnabling(param1:Boolean) : void {
            hitAreaControl.buttonMode = param1;
            hitAreaControl.useHandCursor = param1;
            hitAreaControl.enabled = param1;
            buildingMc.mouseEnabled = param1;
            buildingMc.mouseChildren = param1;
            buildingMc.buttonMode = param1;
            buildingMc.useHandCursor = param1;
        }
        
        private function setOutState() : void {
            if(!this._selected)
            {
                buildingMc.updateRollOutState();
                if(trowel.visible)
                {
                    trowel.updateRollOutState();
                }
                if(this.isNotTrowelState())
                {
                    this.showIndicators(false);
                }
            }
        }
        
        private function setOverState() : void {
            if(!this._selected)
            {
                buildingMc.updateRollOverState();
                if(trowel.visible)
                {
                    trowel.updateRollOverState();
                }
                if(this.isNotTrowelState())
                {
                    this.showIndicators(true);
                }
            }
        }
        
        private function updateSelectedState(param1:Boolean) : void {
            this.showIndicators(param1);
            if(buildingMc.selected != param1)
            {
                buildingMc.updatePressState = param1;
            }
            if((trowel.visible) && !(trowel.selected == param1))
            {
                trowel.updatePressState = param1;
            }
        }
        
        private function showIndicators(param1:Boolean) : void {
            if(!(indicators == null) && !(this.getTweenAnimator() == null))
            {
                this.getTweenAnimator().removeAnims(DisplayObject(indicators.labels));
                if(param1)
                {
                    this.getTweenAnimator().addFadeInAnim(DisplayObject(indicators.labels),this);
                }
                else if(indicators.labels.visible)
                {
                    this.getTweenAnimator().addFadeOutAnim(DisplayObject(indicators.labels),this);
                }
                
            }
        }
        
        private function updateIndicatorsVisibility() : void {
            indicators.visible = this.isNotTrowelState();
            if(indicators.labels.visible != this.isNotTrowelState())
            {
                this.showIndicators(indicators.visible);
            }
        }
        
        private function addCommonBuildingListeners() : void {
            hitAreaControl.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHitAreaHandler);
            hitAreaControl.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHitAreaHandler);
            hitAreaControl.addEventListener(MouseEvent.CLICK,this.onDownHitAreaHandler);
        }
        
        private function removeCommonBuildingListeners() : void {
            hitAreaControl.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHitAreaHandler);
            hitAreaControl.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHitAreaHandler);
            hitAreaControl.removeEventListener(MouseEvent.CLICK,this.onDownHitAreaHandler);
        }
        
        private function addTransportingListeners() : void {
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportMouseOutOverHandler);
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OUT,this.onTransportMouseOutOverHandler);
        }
        
        private function removeTransportingListeners() : void {
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OVER,this.onTransportMouseOutOverHandler);
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OUT,this.onTransportMouseOutOverHandler);
        }
        
        private function addTransportingTooltipListener() : void {
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportTooltipMouseOutOverHandler);
        }
        
        private function removeTransportingTooltipListener() : void {
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OVER,this.onTransportTooltipMouseOutOverHandler);
        }
        
        private function removeAllListeners() : void {
            this.removeCommonBuildingListeners();
            this.removeTransportingListeners();
            this.removeTransportingTooltipListener();
        }
        
        private function buildingCtxMenu() : void {
            this.isShowCtxMenu = this.model.progress >= FORTIFICATION_ALIASES.STATE_TROWEL && (this.model.isOpenCtxMenu);
        }
        
        private function updateOrderTime() : void {
            var _loc1_:Boolean = this.canShowOrderTime();
            var _loc2_:Boolean = orderProcess.visible;
            orderProcess.visible = _loc1_;
            var _loc3_:ITweenAnimator = this.getTweenAnimator();
            if(!(_loc1_ == _loc2_) && (_loc1_))
            {
                orderProcess.rotation = 0;
                this.doHalfTurnHourglasses();
            }
            else if(!_loc1_)
            {
                _loc3_.removeAnims(orderProcess.hourglasses);
            }
            
        }
        
        private function doHalfTurnHourglasses() : void {
            var _loc1_:ITweenAnimator = null;
            if(orderProcess != null)
            {
                _loc1_ = this.getTweenAnimator();
                if(orderProcess.visible)
                {
                    this.getScheduler().scheduleTask(this.doHalfTurnHourglasses,HALF_TURN_SCHEDULER_TIME);
                }
                _loc1_.removeAnims(orderProcess.hourglasses);
                orderProcess.hourglasses.rotation = 0;
                this.getTweenAnimator().addHalfTurnAnim(orderProcess.hourglasses);
            }
        }
        
        private function canShowOrderTime() : Boolean {
            return (this.model && this.model.orderTime) && !(this.model.orderTime == Values.EMPTY_STR) && (this.isInNormalMode());
        }
        
        private function setAdvancedTooltipData() : void {
            this.updateOrderTime();
            var _loc1_:Array = this.getBuildingTooltipData(this.model.uid);
            var _loc2_:String = FORTIFICATIONS.buildings_buildingname(_loc1_[0].toString());
            this.toolTipHeader = App.utils.locale.makeString(_loc2_);
            this.toolTipBody = _loc1_[1].toString();
        }
        
        private function getBuildingTooltipData(param1:String) : Array {
            return IFortBuildingsContainer(parent).getBuildingTooltipData(param1);
        }
        
        private function createSimpleTooltipData() : void {
            var _loc1_:String = null;
            var _loc2_:String = null;
            if(this._isCommander)
            {
                _loc1_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_HEADER;
                _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_BODY;
            }
            else
            {
                _loc1_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_HEADER;
                _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_BODY;
            }
            this.toolTipHeader = App.utils.locale.makeString(_loc1_);
            this.toolTipBody = App.utils.locale.makeString(_loc2_);
        }
        
        private function setState(param1:Number) : void {
            App.utils.asserter.assert(!(FORTIFICATION_ALIASES.STATES.indexOf(param1) == -1),"Unknown build state:" + param1,InfrastructureException);
            if(this._lastState != param1)
            {
                gotoAndPlay(this.getRequiredBuildingState(param1));
            }
            this._lastState = param1;
            trowel.visible = (this._isCommander) && (this.isTrowelState());
            ground.visible = false;
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL)
            {
                trowel.label = FORTIFICATIONS.BUILDINGS_TROWELLABEL;
                ground.visible = true;
                this.createSimpleTooltipData();
            }
            else if(this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION)
            {
                this.setAdvancedTooltipData();
            }
            else if(this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this.model.progress == FORTIFICATION_ALIASES.STATE_BUILDING)
            {
                this.setAdvancedTooltipData();
            }
            
            
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION)
            {
                buildingMc.setCurrentState(FORTIFICATION_ALIASES.FORT_FOUNDATION);
            }
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_BUILDING)
            {
                buildingMc.setCurrentState(this.model.uid);
                if(!this.selected)
                {
                    this.updateBlinkingBtn();
                }
            }
        }
        
        private function updateBlinkingBtn() : void {
            buildingMc.setLevelUpState(this.canBlinking());
        }
        
        private function canBlinking() : Boolean {
            var _loc1_:* = false;
            if(this.model != null)
            {
                if((this.isInExporting) || (this.isInImporting))
                {
                    _loc1_ = (this.isInExporting) && (this.model.isExportAvailable);
                    _loc1_ = (_loc1_) || (this.isInImporting) && (this.model.isImportAvailable) && !exportArrow.isShowed;
                    return !this.selected && (_loc1_);
                }
                return !this.selected && (this.model.isLevelUp);
            }
            return false;
        }
        
        private function getRequiredBuildingState(param1:Number) : String {
            return FortBuildingConstants.BUILD_CODE_TO_NAME_MAP[param1];
        }
        
        private function callPopOver() : void {
            if(!this.model || this.model.uid == FortBuildingConstants.FORT_UNKNOWN)
            {
                return;
            }
            var _loc1_:Object = {"uid":this.model.uid};
            var _loc2_:Point = hitAreaControl.absPosition;
            App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_BUILDING_CARD_POPOVER_EVENT,_loc2_.x,_loc2_.y,_loc1_,this);
        }
        
        private function updateExternalRequest(param1:Boolean) : void {
            this.requestOpenCtxMenu = param1;
            this.requestOpenPopOver = !param1;
        }
        
        private function onTransportMouseOutOverHandler(param1:MouseEvent) : void {
            var _loc2_:* = "onTransportMouseOutOverHandler can be invoked in transporting mode only!";
            App.utils.asserter.assert((this.isInImporting) || (this.isInExporting),_loc2_,InfrastructureException);
            var _loc3_:IArrowWithNut = null;
            if(this.isInImporting)
            {
                _loc3_ = importArrow;
            }
            else if(this.isInExporting)
            {
                _loc3_ = exportArrow;
            }
            
            if(param1.type == MouseEvent.MOUSE_OUT)
            {
                _loc3_.hide();
            }
            else if(param1.type == MouseEvent.MOUSE_OVER)
            {
                _loc3_.show();
            }
            else
            {
                throw new InfrastructureException("onTransportMouseOutOverHandler can not be handle \"" + param1.type + "\" event.");
            }
            
        }
        
        private function onTransportTooltipMouseOutOverHandler(param1:MouseEvent) : void {
            if(param1.type == MouseEvent.MOUSE_OUT)
            {
                App.toolTipMgr.hide();
            }
            else if(param1.type == MouseEvent.MOUSE_OVER)
            {
                if(this.model.transportTooltipData != null)
                {
                    this.showToolTip(this.model.transportTooltipData[0],this.model.transportTooltipData[1]);
                }
                else
                {
                    this.showToolTip(this.toolTipHeader,this.toolTipBody);
                }
            }
            
        }
        
        private function onRollOutHitAreaHandler(param1:MouseEvent) : void {
            this.mouseOverTrigger = false;
            App.toolTipMgr.hide();
            if((this.selected) && !this.requestOpenPopOver && !this.requestOpenCtxMenu)
            {
                this.selected = false;
            }
            if(!this.selected)
            {
                this.setOutState();
            }
        }
        
        private function onRollOverHitAreaHandler(param1:MouseEvent) : void {
            if(this.isDisableCursor)
            {
                App.cursor.setCursor(Cursors.ARROW);
            }
            this.mouseOverTrigger = true;
            if(!this.selected)
            {
                this.setOverState();
            }
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this.model.progress == FORTIFICATION_ALIASES.STATE_BUILDING || this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION)
            {
                this.setAdvancedTooltipData();
            }
            else
            {
                this.createSimpleTooltipData();
            }
            this.showToolTip(this.toolTipHeader,this.toolTipBody);
        }
        
        private function onDownHitAreaHandler(param1:MouseEvent) : void {
            var _loc3_:FortBuildingEvent = null;
            var _loc4_:IBuildingsCIGenerator = null;
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            if(!this.model.isOpenCtxMenu && ((this.isTrowelState()) || (this.commons.isRightButton(MouseEventEx(param1)))))
            {
                return;
            }
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL && (this._isCommander) && (this.commons.isLeftButton(_loc2_)))
            {
                _loc3_ = new FortBuildingEvent(FortBuildingEvent.BUY_BUILDINGS);
                _loc3_.position = this.model.position;
                _loc3_.direction = this.model.direction;
                dispatchEvent(_loc3_);
                return;
            }
            if((this.commons.isRightButton(_loc2_)) && (this.isShowCtxMenu) && (this.model.ctxMenuData))
            {
                App.eventLogManager.logSubSystem(EVENT_LOG_CONSTANTS.SST_CONTEXT_MENU,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_OPEN,0,0);
                if(this.isTutorial)
                {
                    return;
                }
                _loc4_ = new BuildingsCIGenerator();
                this.data = _loc4_.generateGeneralCtxItems(this.model.ctxMenuData);
                this.actionType = 1;
                App.stage.addEventListener(Event.ENTER_FRAME,this.enterFrameHandlerA);
            }
            else if(this.commons.isLeftButton(_loc2_))
            {
                this.actionType = 2;
                App.stage.addEventListener(Event.ENTER_FRAME,this.enterFrameHandlerA);
            }
            
        }
        
        private function enterFrameHandlerA(param1:Event) : void {
            var _loc2_:FortBuildingEvent = null;
            if(this.frameCount >= 2)
            {
                if(this.actionType == 1)
                {
                    if(this.requestOpenCtxMenu)
                    {
                        this.actionType = 0;
                        this.frameCount = 0;
                        App.stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandlerA);
                        return;
                    }
                    this.updateExternalRequest(true);
                    App.popoverMgr.hide();
                    this._contextMenu = App.contextMenuMgr.showFortificationCtxMenu(buildingMc,this.data,this.model.uid);
                    DisplayObject(this._contextMenu).addEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.closeEventHandler);
                    DisplayObject(this._contextMenu).addEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.closeEventHandler);
                }
                else if(this.actionType == 2)
                {
                    this.updateExternalRequest(false);
                    App.contextMenuMgr.hide();
                }
                
                if(this.actionType > 0)
                {
                    this.actionType = 0;
                }
                _loc2_ = new FortBuildingEvent(FortBuildingEvent.BUILDING_SELECTED);
                _loc2_.uid = this.uid;
                _loc2_.isOpenedCtxMenu = this.requestOpenCtxMenu;
                dispatchEvent(_loc2_);
                App.stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandlerA);
            }
            this.frameCount = this.frameCount + 1;
        }
        
        private function closeEventHandler(param1:ContextMenuEvent) : void {
            this.requestOpenCtxMenu = false;
            if(!this.mouseOverTrigger)
            {
                this.forceSelected = false;
            }
            DisplayObject(this._contextMenu).removeEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.closeEventHandler);
            DisplayObject(this._contextMenu).removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.closeEventHandler);
            this._contextMenu = null;
        }
    }
}
