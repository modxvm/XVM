package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.utils.ITweenAnimator;
    import net.wg.utils.IScheduler;
    import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import net.wg.gui.lobby.fortifications.data.FunctionalStates;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.lobby.fortifications.events.FortBuildingAnimationEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingsContainer;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import net.wg.gui.lobby.fortifications.cmp.build.IArrowWithNut;
    import net.wg.data.constants.Cursors;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    import net.wg.gui.lobby.fortifications.utils.IBuildingsCIGenerator;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.gui.lobby.fortifications.utils.impl.BuildingsCIGenerator;
    import flash.events.Event;
    
    public class FortBuilding extends FortBuildingUIBase implements IFortBuilding
    {
        
        public function FortBuilding()
        {
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
        
        private static var ALPHA_DISABLED:Number = 0.25;
        
        private static var ALPHA_ENABLED:Number = 1;
        
        private static var HALF_TURN_SCHEDULER_TIME:int = 2000;
        
        private static var hitAreas:Array = [new Rectangle(15,50,140,82),new Rectangle(6,54,160,91),new Rectangle(49,58,83,65),new Rectangle(15,51,134,81),new Rectangle(10,49,145,85),new Rectangle(13,51,137,82),new Rectangle(28,52,118,82),new Rectangle(34,57,82,56),new Rectangle(12,52,135,82),new Rectangle(25,52,95,65)];
        
        protected static function showToolTip(param1:String, param2:String, param3:String = "") : void
        {
            var _loc4_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).addNote(param3,false).make();
            if(_loc4_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc4_);
            }
        }
        
        private static function getTweenAnimator() : ITweenAnimator
        {
            return App.utils.tweenAnimator;
        }
        
        private static function getScheduler() : IScheduler
        {
            return App.utils.scheduler;
        }
        
        private static function getRequiredBuildingState(param1:Number) : String
        {
            return FortBuildingConstants.BUILD_CODE_TO_NAME_MAP[param1];
        }
        
        private var model:BuildingVO = null;
        
        private var _userCanAddBuilding:Boolean = false;
        
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
        
        private var latestUID:String = null;
        
        private var latestLevel:int = -1;
        
        private var forceResetAnimation:Boolean = false;
        
        public function getCustomHitArea() : InteractiveObject
        {
            return hitAreaControl;
        }
        
        public function setData(param1:BuildingVO) : void
        {
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
            hitAreaControl.enabled = visible;
            if(visible)
            {
                if(_loc2_ != param1.cooldown)
                {
                    if(!this.isInNormalMode() && !this.inDirectionMode)
                    {
                        this.showCooldown(this.isInCooldown());
                    }
                }
                this.isDisableCursor = (this.isTrowelState()) && (!this._userCanAddBuilding || (this.model.isFortFrozen) || (this.model.isBaseBuildingDamaged));
                App.utils.asserter.assertNotNull(this.model,"model" + Errors.CANT_NULL);
                this.model.validate();
                this._uid = this.model.uid;
                this.buildingCtxMenu();
                this.setState(this.model.progress);
                indicators.applyVOData(this.model);
                hitAreaControl.soundType = this.model.uid;
                if((this.isInExporting) && !this.model.isExportAvailable || (this.isInImporting) && !this.model.isImportAvailable)
                {
                    this.removeTransportingListeners();
                }
                this.updateEnabling();
            }
        }
        
        public function updateCommonMode(param1:FortModeVO) : void
        {
            this.isTutorial = param1.isTutorial;
        }
        
        public function updateTransportMode(param1:FortModeVO) : void
        {
            DebugUtils.LOG_DEBUG("building: " + name + " uid:" + this.uid + " inited:" + initialized);
            switch(FortCommonUtils.instance.getFunctionalState(param1))
            {
                case FunctionalStates.ENTER:
                    this.isInExporting = true;
                    this.isInImporting = false;
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
            if(param1.isEntering)
            {
                this.addTransportingTooltipListener();
            }
            else
            {
                this.removeTransportingTooltipListener();
                this.removeTransportingListeners();
            }
            this.checkAnimationState();
        }
        
        public function updateDirectionsMode(param1:FortModeVO) : void
        {
            this.inDirectionMode = param1.isEntering;
            this.updateEnabling();
            this.checkAnimationState();
        }
        
        public function nextTransportingStep(param1:Boolean) : void
        {
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
        
        public function isAvailable() : Boolean
        {
            return !(this.model == null);
        }
        
        public function isExportAvailable() : Boolean
        {
            return (this.isAvailable()) && (this.model.isExportAvailable);
        }
        
        public function isImportAvailable() : Boolean
        {
            return (this.isAvailable()) && (this.model.isImportAvailable);
        }
        
        public function onPopoverClose() : void
        {
            this.requestOpenPopOver = false;
            if(!this.mouseOverTrigger)
            {
                this.forceSelected = false;
            }
        }
        
        public function onPopoverOpen() : void
        {
        }
        
        public function onComplete() : void
        {
        }
        
        public function getTargetButton() : DisplayObject
        {
            return buildingMc.getBuildingShape();
        }
        
        public function getHitArea() : DisplayObject
        {
            return hitAreaControl;
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
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
        
        public function set forceSelected(param1:Boolean) : void
        {
            if(this._selected == param1)
            {
                return;
            }
            this.frameCount = 0;
            this.actionType = 0;
            this.selected = param1;
        }
        
        public function set userCanAddBuilding(param1:Boolean) : void
        {
            this._userCanAddBuilding = param1;
            if(this.model != null)
            {
                this.setState(this.model.progress);
            }
        }
        
        public function get uid() : String
        {
            return this._uid;
        }
        
        public function set uid(param1:String) : void
        {
            this._uid = param1;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                buildingMc.mouseEnabled = buildingMc.mouseChildren = false;
                indicators.mouseEnabled = indicators.mouseChildren = false;
                trowel.mouseEnabled = trowel.mouseChildren = false;
            }
        }
        
        override protected function onDispose() : void
        {
            this.removeAllListeners();
            getTweenAnimator().removeAnims(DisplayObject(cooldownIcon));
            getTweenAnimator().removeAnims(DisplayObject(indicators));
            getTweenAnimator().removeAnims(orderProcess.hourglasses);
            getTweenAnimator().removeAnims(indicators.labels);
            getScheduler().cancelTask(this.doHalfTurnHourglasses);
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
            animationController.removeEventListener(FortBuildingAnimationEvent.END_ANIMATION,this.animationControllerEndAnimation);
            animationController.dispose();
            animationController = null;
            super.onDispose();
        }
        
        private function isInNormalMode() : Boolean
        {
            return !this.isInExporting && !this.isInImporting && !this.inDirectionMode;
        }
        
        private function checkAnimationState() : void
        {
            if((this.model) && (!this.isInNormalMode()) && (animationController.isPlayingAnimation))
            {
                animationController.resetAnimationType();
                this.updateBuildingState();
            }
        }
        
        private function updateEnabling() : void
        {
            var _loc2_:* = false;
            var _loc1_:* = true;
            if((this.model) && (this.model.isDefenceHour) && (this.isInNormalMode()))
            {
                this.disableDefenceHour();
            }
            else if(this.isInNormalMode())
            {
                this.enableForAll();
            }
            else if(this.inDirectionMode)
            {
                this.disableForDirectionMode();
            }
            else if(this.isNotInCooldown())
            {
                _loc2_ = ((this.isExportAvailable()) && (this.isInExporting) || (this.isImportAvailable()) && (this.isInImporting)) && (this.isNotTrowelState());
                if(_loc2_)
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
                _loc1_ = false;
            }
            
            
            
            this.updateOrderTime();
            if(_loc1_)
            {
                this.updateBlinkingBtn();
            }
        }
        
        private function isInCooldown() : Boolean
        {
            return !(this.model == null) && !(this.model.cooldown == null);
        }
        
        private function isNotInCooldown() : Boolean
        {
            return !this.isInCooldown();
        }
        
        private function isTrowelState() : Boolean
        {
            return (this.model) && this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL;
        }
        
        private function isNotTrowelState() : Boolean
        {
            return !this.isTrowelState();
        }
        
        private function disableDefenceHour() : void
        {
            trowel.alpha = 0;
            ground.alpha = ALPHA_ENABLED;
            this.updateInteractionEnabling(false);
            indicators.visible = this.isNotTrowelState();
            this.removeCommonBuildingListeners();
        }
        
        private function enableForAll() : void
        {
            buildingMc.building.alpha = ALPHA_ENABLED;
            buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
            trowel.alpha = ALPHA_ENABLED;
            ground.alpha = ALPHA_ENABLED;
            this.updateInteractionEnabling(true);
            indicators.visible = this.isNotTrowelState();
            this.addCommonBuildingListeners();
        }
        
        private function disableForDirectionMode() : void
        {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.updateInteractionEnabling(false);
            indicators.visible = false;
            this.removeCommonBuildingListeners();
        }
        
        private function enableForTransporting() : void
        {
            buildingMc.building.alpha = ALPHA_ENABLED;
            buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.updateInteractionEnabling(true);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function disableForTransporting() : void
        {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            ground.alpha = ALPHA_DISABLED;
            this.updateInteractionEnabling(false);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function disableForCooldown() : void
        {
            buildingMc.building.alpha = ALPHA_DISABLED;
            buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
            trowel.alpha = 0;
            this.updateInteractionEnabling(false);
            this.updateIndicatorsVisibility();
            this.removeCommonBuildingListeners();
        }
        
        private function showCooldown(param1:Boolean) : void
        {
            if(cooldownIcon.visible != param1)
            {
                getTweenAnimator().removeAnims(DisplayObject(cooldownIcon));
                if(param1)
                {
                    cooldownIcon.timeTextField.text = String(this.model.cooldown);
                    getTweenAnimator().addFadeInAnim(DisplayObject(cooldownIcon),null);
                }
                else
                {
                    getTweenAnimator().addFadeOutAnim(DisplayObject(cooldownIcon),null);
                }
            }
        }
        
        private function updateInteractionEnabling(param1:Boolean) : void
        {
            hitAreaControl.buttonMode = param1;
            hitAreaControl.useHandCursor = param1;
            buildingMc.mouseEnabled = param1;
            buildingMc.mouseChildren = param1;
            buildingMc.buttonMode = param1;
            buildingMc.useHandCursor = param1;
        }
        
        private function setOutState() : void
        {
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
        
        private function setOverState() : void
        {
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
        
        private function updateSelectedState(param1:Boolean) : void
        {
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
        
        private function showIndicators(param1:Boolean) : void
        {
            getTweenAnimator().removeAnims(indicators.labels);
            if(param1)
            {
                if((!indicators.labels.visible || indicators.labels.alpha < 1) && (indicators.visible))
                {
                    getTweenAnimator().addFadeInAnim(indicators.labels,this);
                }
            }
            else if((indicators.labels.visible) && (indicators.labels.stage))
            {
                getTweenAnimator().addFadeOutAnim(indicators.labels,this);
            }
            
        }
        
        private function updateIndicatorsVisibility() : void
        {
            indicators.visible = this.isNotTrowelState();
            if(indicators.labels.visible != this.isNotTrowelState())
            {
                this.showIndicators(indicators.visible);
            }
        }
        
        private function addCommonBuildingListeners() : void
        {
            hitAreaControl.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHitAreaHandler);
            hitAreaControl.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHitAreaHandler);
            hitAreaControl.addEventListener(MouseEvent.CLICK,this.onDownHitAreaHandler);
        }
        
        private function removeCommonBuildingListeners() : void
        {
            hitAreaControl.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHitAreaHandler);
            hitAreaControl.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHitAreaHandler);
            hitAreaControl.removeEventListener(MouseEvent.CLICK,this.onDownHitAreaHandler);
        }
        
        private function addTransportingListeners() : void
        {
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportMouseOutOverHandler);
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OUT,this.onTransportMouseOutOverHandler);
        }
        
        private function removeTransportingListeners() : void
        {
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OVER,this.onTransportMouseOutOverHandler);
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OUT,this.onTransportMouseOutOverHandler);
        }
        
        private function addTransportingTooltipListener() : void
        {
            hitAreaControl.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportTooltipMouseOutOverHandler);
        }
        
        private function removeTransportingTooltipListener() : void
        {
            hitAreaControl.removeEventListener(MouseEvent.MOUSE_OVER,this.onTransportTooltipMouseOutOverHandler);
        }
        
        private function removeAllListeners() : void
        {
            this.removeCommonBuildingListeners();
            this.removeTransportingListeners();
            this.removeTransportingTooltipListener();
        }
        
        private function buildingCtxMenu() : void
        {
            this.isShowCtxMenu = this.model.progress >= FORTIFICATION_ALIASES.STATE_TROWEL && (this.model.isOpenCtxMenu);
        }
        
        private function updateOrderTime() : void
        {
            var _loc1_:Boolean = this.canShowOrderTime();
            var _loc2_:Boolean = orderProcess.visible;
            var _loc3_:String = orderProcess.currentLabel;
            orderProcess.visible = _loc1_;
            if(_loc1_)
            {
                if((this.model) && (this.model.productionInPause))
                {
                    getScheduler().cancelTask(this.doHalfTurnHourglasses);
                    orderProcess.rotation = 0;
                    getTweenAnimator().removeAnims(orderProcess.hourglasses);
                    orderProcess.gotoAndStop("pause");
                }
                else
                {
                    if(_loc3_ != "normal")
                    {
                        orderProcess.gotoAndStop("normal");
                    }
                    if(orderProcess.rotation == 0)
                    {
                        this.doHalfTurnHourglasses();
                    }
                }
            }
            else if(!_loc1_)
            {
                getTweenAnimator().removeAnims(orderProcess.hourglasses);
            }
            
        }
        
        private function doHalfTurnHourglasses() : void
        {
            if(orderProcess != null)
            {
                if(orderProcess.visible)
                {
                    getScheduler().scheduleTask(this.doHalfTurnHourglasses,HALF_TURN_SCHEDULER_TIME);
                }
                getTweenAnimator().removeAnims(orderProcess.hourglasses);
                orderProcess.hourglasses.rotation = 0;
                getTweenAnimator().addHalfTurnAnim(orderProcess.hourglasses);
            }
        }
        
        private function canShowOrderTime() : Boolean
        {
            return (this.model && this.model.orderTime) && !(this.model.orderTime == Values.EMPTY_STR) && (this.isInNormalMode());
        }
        
        private function setAdvancedTooltipData() : void
        {
            this.updateOrderTime();
            var _loc1_:Array = this.getBuildingTooltipData(this.model.uid);
            var _loc2_:String = FORTIFICATIONS.buildings_buildingname(_loc1_[0].toString());
            this.toolTipHeader = App.utils.locale.makeString(_loc2_);
            this.toolTipBody = _loc1_[1].toString();
        }
        
        private function getBuildingTooltipData(param1:String) : Array
        {
            return IFortBuildingsContainer(parent).getBuildingTooltipData(param1);
        }
        
        private function createSimpleTooltipData() : void
        {
            var _loc1_:String = null;
            var _loc2_:String = null;
            if(this._userCanAddBuilding)
            {
                _loc1_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_HEADER;
                if((this.model.isFortFrozen) || (this.model.isBaseBuildingDamaged))
                {
                    _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_NOTAVAILABLE_BODY;
                }
                else
                {
                    _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_BODY;
                }
            }
            else
            {
                _loc1_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_HEADER;
                _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_BODY;
            }
            this.toolTipHeader = App.utils.locale.makeString(_loc1_);
            this.toolTipBody = App.utils.locale.makeString(_loc2_);
        }
        
        private function setState(param1:Number) : void
        {
            var _loc2_:String = null;
            App.utils.asserter.assert(!(FORTIFICATION_ALIASES.STATES.indexOf(param1) == -1),"Unknown build state:" + param1,InfrastructureException);
            if(!this.isInNormalMode())
            {
                this.updateBuildingState();
                return;
            }
            this.forceResetAnimation = false;
            if(animationController.isPlayingAnimation)
            {
                if(this.model.uid == FORTIFICATION_ALIASES.FORT_UNKNOWN && !(this.latestUID == null))
                {
                    this.forceResetAnimation = true;
                    this.latestUID = null;
                }
                if(!(this.model.uid == FORTIFICATION_ALIASES.FORT_UNKNOWN) && this.latestUID == null)
                {
                    this.latestUID = this.model.uid;
                    this.forceResetAnimation = true;
                }
                if(this.model.buildingLevel > this.latestLevel && this.model.buildingLevel >= 2)
                {
                    this.forceResetAnimation = true;
                    this.latestLevel = this.model.buildingLevel;
                }
                if(this.forceResetAnimation)
                {
                    this._lastState = -1;
                    animationController.resetAnimationType();
                }
                else
                {
                    this.model.animationType = FORTIFICATION_ALIASES.WITHOUT_ANIMATION;
                    return;
                }
            }
            if(this.model.uid != FORTIFICATION_ALIASES.FORT_UNKNOWN)
            {
                this.latestUID = this.model.uid;
            }
            else
            {
                this.latestUID = null;
            }
            if(this._lastState != param1)
            {
                if(this.model.animationType > FORTIFICATION_ALIASES.WITHOUT_ANIMATION)
                {
                    animationController.addEventListener(FortBuildingAnimationEvent.END_ANIMATION,this.animationControllerEndAnimation);
                    if(this.model.animationType == FORTIFICATION_ALIASES.BUILD_FOUNDATION_ANIMATION)
                    {
                        animationController.setAnimationType(this.model.animationType,FORTIFICATION_ALIASES.FORT_FOUNDATION);
                        this.updateBuildingState();
                        return;
                    }
                    if(this.model.animationType == FORTIFICATION_ALIASES.DEMOUNT_BUILDING_ANIMATION)
                    {
                        this.gotoBuildingState(this.model.progress,this.model.uid);
                        trowel.visible = false;
                        _loc2_ = this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF?FORTIFICATION_ALIASES.FORT_FOUNDATION:buildingMc.currentState();
                        animationController.setAnimationType(this.model.animationType,_loc2_);
                        return;
                    }
                }
            }
            if(this.model.animationType == FORTIFICATION_ALIASES.UPGRADE_BUILDING_ANIMATION)
            {
                animationController.addEventListener(FortBuildingAnimationEvent.END_ANIMATION,this.animationControllerEndAnimation);
                animationController.setAnimationType(this.model.animationType,null);
                this.model.animationType = FORTIFICATION_ALIASES.WITHOUT_ANIMATION;
            }
            this.updateBuildingState();
        }
        
        public function gotoBuildingState(param1:Number, param2:String) : void
        {
            var _loc3_:Array = [FORTIFICATION_ALIASES.FORT_FOUNDATION,FORTIFICATION_ALIASES.FORT_BASE_BUILDING,FORTIFICATION_ALIASES.FORT_WAR_SCHOOL_BUILDING,FORTIFICATION_ALIASES.FORT_TROPHY_BUILDING,FORTIFICATION_ALIASES.FORT_TRAINING_BUILDING,FORTIFICATION_ALIASES.FORT_TANKODROM_BUILDING,FORTIFICATION_ALIASES.FORT_INTENDANCY_BUILDING,FORTIFICATION_ALIASES.FORT_FINANCE_BUILDING,FORTIFICATION_ALIASES.FORT_CAR_BUILDING,FORTIFICATION_ALIASES.FORT_OFFICE_BUILDING];
            gotoAndPlay(getRequiredBuildingState(this.model.progress));
            if(param1 == FORTIFICATION_ALIASES.STATE_BUILDING)
            {
                hitAreaControl.x = hitAreas[_loc3_.indexOf(param2)].x;
                hitAreaControl.y = hitAreas[_loc3_.indexOf(param2)].y;
                hitAreaControl.width = hitAreas[_loc3_.indexOf(param2)].width;
                hitAreaControl.height = hitAreas[_loc3_.indexOf(param2)].height;
            }
            else if(this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this.model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION)
            {
                hitAreaControl.x = hitAreas[0].x;
                hitAreaControl.y = hitAreas[0].y;
                hitAreaControl.width = hitAreas[0].width;
                hitAreaControl.height = hitAreas[0].height;
            }
            else if(this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL)
            {
                hitAreaControl.x = trowel.x;
                hitAreaControl.y = trowel.y;
                hitAreaControl.width = 64;
                hitAreaControl.height = 64;
            }
            
            
        }
        
        private function updateBuildingState() : void
        {
            var _loc1_:String = null;
            if(this._lastState != this.model.progress)
            {
                this.gotoBuildingState(this.model.progress,this.model.uid);
            }
            this._lastState = this.model.progress;
            trowel.visible = (this._userCanAddBuilding) && (this.isTrowelState()) && !this.model.isFortFrozen && !this.model.isBaseBuildingDamaged;
            ground.visible = false;
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL)
            {
                if(!this.model.isFortFrozen && !this.model.isBaseBuildingDamaged)
                {
                    trowel.label = FORTIFICATIONS.BUILDINGS_TROWELLABEL;
                }
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
                _loc1_ = this.model.uid;
                if((this.model.isFortFrozen) && !(FortBuildingConstants.CRASHABLE_BUILDINGS.indexOf(this.model.uid) == -1))
                {
                    _loc1_ = _loc1_ + FortBuildingConstants.CRASH_POSTFIX;
                }
                buildingMc.setCurrentState(_loc1_);
                if(!this.selected)
                {
                    this.updateBlinkingBtn();
                }
            }
            this.latestLevel = this.model.buildingLevel;
        }
        
        private function animationControllerEndAnimation(param1:FortBuildingAnimationEvent) : void
        {
            animationController.resetAnimationType();
            animationController.removeEventListener(FortBuildingAnimationEvent.END_ANIMATION,this.animationControllerEndAnimation);
            this.updateBuildingState();
        }
        
        private function updateBlinkingBtn() : void
        {
            buildingMc.setLevelUpState(this.canBlinking());
        }
        
        private function canBlinking() : Boolean
        {
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
        
        private function callPopOver() : void
        {
            if(!this.model || this.model.uid == FortBuildingConstants.FORT_UNKNOWN)
            {
                return;
            }
            var _loc1_:Object = {"uid":this.model.uid};
            if(App.popoverMgr.popoverCaller != this)
            {
                App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_BUILDING_CARD_POPOVER_EVENT,_loc1_,this);
            }
            else
            {
                App.popoverMgr.hide();
            }
        }
        
        private function updateExternalRequest(param1:Boolean) : void
        {
            this.requestOpenCtxMenu = param1;
            this.requestOpenPopOver = !param1;
        }
        
        private function onTransportMouseOutOverHandler(param1:MouseEvent) : void
        {
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
        
        private function onTransportTooltipMouseOutOverHandler(param1:MouseEvent) : void
        {
            if(param1.type == MouseEvent.MOUSE_OUT)
            {
                App.toolTipMgr.hide();
            }
            else if(param1.type == MouseEvent.MOUSE_OVER)
            {
                if(this.model.transportTooltipData != null)
                {
                    showToolTip(this.model.transportTooltipData[0],this.model.transportTooltipData[1]);
                }
                else
                {
                    showToolTip(this.toolTipHeader,this.toolTipBody);
                }
            }
            
        }
        
        private function onRollOutHitAreaHandler(param1:MouseEvent) : void
        {
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
        
        private function onRollOverHitAreaHandler(param1:MouseEvent) : void
        {
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
            showToolTip(this.toolTipHeader,this.toolTipBody);
        }
        
        private function onDownHitAreaHandler(param1:MouseEvent) : void
        {
            var _loc3_:FortBuildingEvent = null;
            var _loc4_:IBuildingsCIGenerator = null;
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            if(!this._userCanAddBuilding && (this.commons.isLeftButton(MouseEventEx(param1))) && (this.isTrowelState()))
            {
                return;
            }
            if(!this.model.isOpenCtxMenu && (this.commons.isRightButton(MouseEventEx(param1))))
            {
                return;
            }
            if(this.model.progress == FORTIFICATION_ALIASES.STATE_TROWEL && (this._userCanAddBuilding) && !this.model.isFortFrozen && !this.model.isBaseBuildingDamaged && (this.commons.isLeftButton(_loc2_)))
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
        
        private function enterFrameHandlerA(param1:Event) : void
        {
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
        
        private function closeEventHandler(param1:ContextMenuEvent) : void
        {
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
