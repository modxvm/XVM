package net.wg.gui.lobby.hangar.quests
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.hangar.interfaces.IQuestsButtonsContainer;
    import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;
    import scaleform.clik.motion.Tween;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import net.wg.utils.IScheduler;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.hangar.interfaces.IQuestInformerButton;
    import net.wg.data.Aliases;
    import fl.motion.easing.Quadratic;
    import fl.motion.easing.Quartic;

    public class HeaderQuestsFlags extends UIComponentEx implements IQuestsButtonsContainer
    {

        private static const DISABLE_TWEEN_DURATION:int = 120;

        private static const TWEEN_DURATION:int = 400;

        private static const TWEEN_DELTA_DURATION_ONE_STEP:int = -10;

        private static const TWEEN_DX_STEPS:Array = [6,-4,2,0];

        private static const COLLAPSE_ANIM_DELAY:int = 100;

        private static const QUESTS_GROUP_OFFSET:int = 34;

        private static const RIGHT_SIDE_GROUP_X_OFFSET:int = -11;

        public var questsHitArea:Sprite = null;

        private var _questsGroupsData:Vector.<HeaderQuestGroupVO> = null;

        private var _questsGroupsContainers:Vector.<IHeaderQuestsContainer> = null;

        private var _containersMap:Dictionary = null;

        private var _disableItemStartX:int = 0;

        private var _disableItem:DisplayObject = null;

        private var _isMoveContainerInProgress:Boolean = false;

        private var _isDisableTweenInProgress:Boolean = false;

        private var _disableItemsTweens:Vector.<Tween> = null;

        private var _containerTweens:Vector.<Tween> = null;

        private var _needCollapseAnim:Boolean = false;

        private var _scheduler:IScheduler = null;

        private var _battlePassEntryPoint:BattlePassEntryPoint = null;

        public function HeaderQuestsFlags()
        {
            super();
            this._scheduler = App.utils.scheduler;
        }

        private static function findGroupDataByID(param1:Vector.<HeaderQuestGroupVO>, param2:String) : HeaderQuestGroupVO
        {
            var _loc3_:HeaderQuestGroupVO = null;
            for each(_loc3_ in param1)
            {
                if(_loc3_.groupID == param2)
                {
                    return _loc3_;
                }
            }
            return null;
        }

        private static function clearTweens(param1:Vector.<Tween>) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(param1)
            {
                _loc2_ = param1.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    param1[_loc3_].paused = true;
                    param1[_loc3_].dispose();
                    param1[_loc3_] = null;
                    _loc3_++;
                }
                param1.splice(0,_loc2_);
                var param1:Vector.<Tween> = null;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.addEventListener(MouseEvent.ROLL_OUT,this.onThisRollOutHandler);
            this.addEventListener(MouseEvent.ROLL_OVER,this.onThisRollOverHandler);
            App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._questsGroupsData)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.doUpdateData();
                    invalidateSize();
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    if(this._battlePassEntryPoint)
                    {
                        if(App.stage.stageWidth >= StageSizeBoundaries.WIDTH_1600 && App.stage.stageHeight >= StageSizeBoundaries.HEIGHT_900)
                        {
                            this._battlePassEntryPoint.setIsSmallSize(false);
                        }
                        else
                        {
                            this._battlePassEntryPoint.setIsSmallSize(true);
                        }
                        this._battlePassEntryPoint.validateNow();
                        this._battlePassEntryPoint.x = -(this._battlePassEntryPoint.width >> 1);
                    }
                    this.layoutQuestContainers();
                    this.updateHitArea();
                }
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onThisRollOutHandler);
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onThisRollOverHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
            this._scheduler.cancelTask(this.showCollapseAnim);
            this._scheduler = null;
            this.disposeQuestContainers();
            this.questsHitArea = null;
            this._questsGroupsData = null;
            if(this._battlePassEntryPoint != null && this._battlePassEntryPoint.parent == this)
            {
                removeChild(this._battlePassEntryPoint);
                this._battlePassEntryPoint = null;
            }
            super.onDispose();
        }

        public function getHitRect() : Rectangle
        {
            return new Rectangle(this.questsHitArea.x,this.questsHitArea.y,this.questsHitArea.width,this.questsHitArea.height);
        }

        public function getQuestBtnByType(param1:String) : IQuestInformerButton
        {
            var _loc3_:IHeaderQuestsContainer = null;
            var _loc2_:IQuestInformerButton = null;
            if(this._questsGroupsContainers)
            {
                for each(_loc3_ in this._questsGroupsContainers)
                {
                    _loc2_ = _loc3_.getQuestBtnByType(param1);
                    if(_loc2_)
                    {
                        break;
                    }
                }
            }
            return _loc2_;
        }

        public function getQuestGroupByID(param1:String) : IHeaderQuestsContainer
        {
            var _loc2_:IHeaderQuestsContainer = null;
            if(this._questsGroupsContainers)
            {
                for each(_loc2_ in this._questsGroupsContainers)
                {
                    if(_loc2_.groupID == param1)
                    {
                        return _loc2_;
                    }
                }
            }
            return null;
        }

        public function setBattlePassEntryPoint(param1:BattlePassEntryPoint) : void
        {
            if(param1 == null)
            {
                if(this._battlePassEntryPoint && this._battlePassEntryPoint.parent == this)
                {
                    removeChild(this._battlePassEntryPoint);
                }
            }
            else
            {
                addChildAt(param1,1);
            }
            this._battlePassEntryPoint = param1;
            invalidateSize();
        }

        public function setData(param1:Vector.<HeaderQuestGroupVO>) : void
        {
            if(param1 != null && this._questsGroupsData != param1)
            {
                this._questsGroupsData = param1;
                invalidateData();
            }
        }

        private function doUpdateData() : void
        {
            var _loc2_:IHeaderQuestsContainer = null;
            var _loc1_:HeaderQuestGroupVO = null;
            var _loc3_:int = this._questsGroupsData?this._questsGroupsData.length:0;
            var _loc4_:int = this._questsGroupsContainers?this._questsGroupsContainers.length:0;
            var _loc5_:* = _loc3_ != _loc4_;
            if(!_loc5_)
            {
                if(_loc4_ > 0)
                {
                    for each(_loc2_ in this._questsGroupsContainers)
                    {
                        _loc1_ = findGroupDataByID(this._questsGroupsData,_loc2_.groupID);
                        if(!_loc2_.hasInformersEqualNewData(_loc1_))
                        {
                            _loc5_ = true;
                            break;
                        }
                    }
                }
                else
                {
                    _loc5_ = true;
                }
            }
            if(_loc5_)
            {
                App.toolTipMgr.hide();
                this.disposeQuestContainers();
                this.createQuestContainers();
            }
            else
            {
                this.updateQuestContainers();
            }
        }

        private function updateQuestContainers() : void
        {
            var _loc1_:IHeaderQuestsContainer = null;
            var _loc2_:HeaderQuestGroupVO = null;
            if(this._questsGroupsData)
            {
                for each(_loc2_ in this._questsGroupsData)
                {
                    _loc1_ = this.getContainerByID(_loc2_.groupID);
                    if(_loc1_)
                    {
                        _loc1_.setData(_loc2_);
                    }
                }
            }
        }

        private function getContainerByID(param1:String) : IHeaderQuestsContainer
        {
            return param1 in this._containersMap?this._containersMap[param1]:null;
        }

        private function createQuestContainers() : void
        {
            var _loc2_:IHeaderQuestsContainer = null;
            var _loc3_:HeaderQuestGroupVO = null;
            var _loc4_:* = 0;
            this._containersMap = new Dictionary();
            var _loc1_:int = this._questsGroupsData.length;
            if(_loc1_ > 0)
            {
                this._questsGroupsContainers = new Vector.<IHeaderQuestsContainer>();
                _loc2_ = null;
                _loc3_ = null;
                _loc4_ = 0;
                while(_loc4_ < _loc1_)
                {
                    _loc2_ = App.utils.classFactory.getComponent(Aliases.HEADER_QUEST_GROUP_CONTAINER,HeaderQuestsContainer);
                    this.addListenersToQuestsContainer(_loc2_);
                    _loc3_ = this._questsGroupsData[_loc4_];
                    _loc2_.setData(_loc3_);
                    _loc2_.name = _loc3_.groupID;
                    this._containersMap[_loc3_.groupID] = _loc2_;
                    this.addChild(DisplayObject(_loc2_));
                    this._questsGroupsContainers.push(_loc2_);
                    _loc4_++;
                }
            }
        }

        private function layoutQuestContainers() : void
        {
            var _loc2_:IHeaderQuestsContainer = null;
            var _loc3_:HeaderQuestGroupVO = null;
            var _loc1_:int = this._questsGroupsData.length;
            var _loc4_:int = this.getInitialRightSideX();
            var _loc5_:* = -1;
            var _loc6_:* = 0;
            while(_loc6_ < _loc1_)
            {
                _loc3_ = this._questsGroupsData[_loc6_];
                _loc2_ = this._containersMap[_loc3_.groupID];
                if(_loc3_.isRightSide)
                {
                    _loc2_.x = _loc4_;
                    _loc4_ = _loc4_ + _loc2_.cmptWidth;
                }
                else
                {
                    if(_loc5_ == -1)
                    {
                        _loc5_ = this.getInitialLeftSideX(_loc2_.cmptWidth);
                    }
                    _loc2_.x = _loc5_;
                    _loc5_ = _loc5_ - _loc2_.cmptWidth;
                }
                _loc6_++;
            }
        }

        private function clearQuestContainers() : void
        {
            var _loc1_:IHeaderQuestsContainer = null;
            if(this._questsGroupsContainers)
            {
                for each(_loc1_ in this._questsGroupsContainers)
                {
                    this.removeListenersFromQuestsContainer(_loc1_);
                    _loc1_.dispose();
                    this.removeChild(DisplayObject(_loc1_));
                }
                this._questsGroupsContainers.splice(0,this._questsGroupsContainers.length);
            }
            this._questsGroupsContainers = null;
        }

        private function disposeQuestContainers() : void
        {
            this.clearDisableTween();
            clearTweens(this._containerTweens);
            this._containerTweens = null;
            App.utils.data.cleanupDynamicObject(this._containersMap);
            this._containersMap = null;
            this.clearQuestContainers();
            this._questsGroupsContainers = null;
        }

        private function updateHitArea() : void
        {
            var _loc3_:IHeaderQuestsContainer = null;
            var _loc1_:int = this.battlePassEntryPointWidth + 2 * QUESTS_GROUP_OFFSET;
            var _loc2_:* = 0;
            for each(_loc3_ in this._questsGroupsContainers)
            {
                if(_loc3_.x < _loc2_)
                {
                    _loc2_ = _loc3_.x;
                }
                _loc1_ = _loc1_ + _loc3_.cmptWidth;
            }
            this.questsHitArea.x = _loc2_;
            this.questsHitArea.width = _loc1_;
        }

        private function addListenersToQuestsContainer(param1:IHeaderQuestsContainer) : void
        {
            param1.addEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            param1.addEventListener(HeaderQuestsEvent.HEADER_QUEST_OVER,this.onBtnHeaderQuestOverHandler);
            param1.addEventListener(HeaderQuestsEvent.ANIM_START,this.onPMItemsAnimStartHandler);
        }

        private function removeListenersFromQuestsContainer(param1:IHeaderQuestsContainer) : void
        {
            param1.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            param1.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_OVER,this.onBtnHeaderQuestOverHandler);
            param1.removeEventListener(HeaderQuestsEvent.ANIM_START,this.onPMItemsAnimStartHandler);
        }

        private function onDisableTweenComplete() : void
        {
            this.clearDisableTween();
            this._isDisableTweenInProgress = false;
        }

        private function clearDisableTween() : void
        {
            this._disableItem = null;
            clearTweens(this._disableItemsTweens);
            this._disableItemsTweens = null;
        }

        private function startDisabledItemTween(param1:Object) : void
        {
            var _loc2_:* = 0;
            var _loc3_:Tween = null;
            var _loc4_:* = 0;
            var _loc5_:Function = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            if(!this._isDisableTweenInProgress && !this._isMoveContainerInProgress)
            {
                this._isDisableTweenInProgress = true;
                this._disableItemsTweens = new Vector.<Tween>();
                _loc2_ = TWEEN_DX_STEPS.length;
                _loc3_ = null;
                _loc4_ = 0;
                _loc5_ = null;
                _loc6_ = 0;
                _loc7_ = _loc2_ - 1;
                this._disableItemStartX = param1.x;
                this._disableItem = DisplayObject(param1);
                _loc8_ = 0;
                while(_loc8_ < _loc2_)
                {
                    _loc4_ = this._disableItemStartX + TWEEN_DX_STEPS[_loc8_];
                    _loc5_ = _loc8_ == _loc7_?this.onDisableTweenComplete:null;
                    _loc6_ = DISABLE_TWEEN_DURATION + _loc8_ * TWEEN_DELTA_DURATION_ONE_STEP;
                    _loc3_ = new Tween(_loc6_,param1,{"x":_loc4_},{
                        "paused":false,
                        "ease":Quadratic.easeInOut,
                        "delay":DISABLE_TWEEN_DURATION * _loc8_,
                        "fastTransform":false,
                        "onComplete":_loc5_
                    });
                    this._disableItemsTweens.push(_loc3_);
                    _loc8_++;
                }
            }
        }

        private function animContainers(param1:IHeaderQuestsContainer) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:IHeaderQuestsContainer = null;
            var _loc6_:* = 0;
            var _loc7_:* = false;
            var _loc8_:* = 0;
            if(this._questsGroupsContainers)
            {
                if(this._disableItemsTweens)
                {
                    this._disableItem.x = this._disableItemStartX;
                    this.onDisableTweenComplete();
                }
                clearTweens(this._containerTweens);
                this._isMoveContainerInProgress = true;
                this._containerTweens = new Vector.<Tween>();
                _loc2_ = this.getInitialRightSideX();
                _loc3_ = -1;
                _loc4_ = this._questsGroupsContainers.length;
                _loc5_ = null;
                _loc6_ = _loc4_ - 1;
                _loc7_ = false;
                _loc8_ = 0;
                while(_loc8_ < _loc4_)
                {
                    _loc5_ = this._questsGroupsContainers[_loc8_];
                    if(param1 == _loc5_)
                    {
                        _loc5_.animExpand();
                    }
                    else if(!param1)
                    {
                        _loc5_.animCollapse();
                    }
                    if(_loc5_.isRightSide)
                    {
                        if(_loc5_.x != _loc2_)
                        {
                            _loc7_ = true;
                            this.moveContainerToX(_loc5_,_loc2_,_loc6_ == _loc8_);
                        }
                        _loc2_ = _loc2_ + _loc5_.cmptWidth;
                    }
                    else
                    {
                        if(_loc3_ == -1)
                        {
                            _loc3_ = this.getInitialLeftSideX(_loc5_.cmptWidth);
                        }
                        if(_loc5_.x != _loc3_)
                        {
                            _loc7_ = true;
                            this.moveContainerToX(_loc5_,_loc3_,_loc6_ == _loc8_);
                        }
                        _loc3_ = _loc3_ - _loc5_.cmptWidth;
                    }
                    _loc8_++;
                }
                if(!_loc7_)
                {
                    this._isMoveContainerInProgress = false;
                }
            }
        }

        private function moveContainerToX(param1:IHeaderQuestsContainer, param2:int, param3:Boolean) : void
        {
            var _loc4_:Function = param3?this.onMoveContainerCompleted:null;
            var _loc5_:Tween = new Tween(TWEEN_DURATION,param1,{"x":param2},{
                "paused":false,
                "ease":Quartic.easeOut,
                "delay":0,
                "fastTransform":false,
                "onComplete":_loc4_
            });
            this._containerTweens.push(_loc5_);
        }

        private function showCollapseAnim() : void
        {
            this._scheduler.cancelTask(this.showCollapseAnim);
            this._needCollapseAnim = false;
            this.animContainers(null);
        }

        private function getInitialRightSideX() : int
        {
            return this.battlePassEntryPointX + this.battlePassEntryPointWidth + QUESTS_GROUP_OFFSET - this.battlePassEntryPointmMrginX + RIGHT_SIDE_GROUP_X_OFFSET;
        }

        private function getInitialLeftSideX(param1:int) : int
        {
            return this.battlePassEntryPointX - (param1 >> 1) - QUESTS_GROUP_OFFSET + this.battlePassEntryPointmMrginX;
        }

        private function onMoveContainerCompleted() : void
        {
            this._isMoveContainerInProgress = false;
        }

        private function get battlePassEntryPointWidth() : int
        {
            return this._battlePassEntryPoint?this._battlePassEntryPoint.width:0;
        }

        private function get battlePassEntryPointmMrginX() : int
        {
            return this._battlePassEntryPoint?this._battlePassEntryPoint.marginX:0;
        }

        private function get battlePassEntryPointX() : int
        {
            return this._battlePassEntryPoint?this._battlePassEntryPoint.x:0;
        }

        private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
        {
            dispatchEvent(param1);
        }

        private function onBtnHeaderQuestOverHandler(param1:HeaderQuestsEvent) : void
        {
            if(!param1.isEnable)
            {
                this.startDisabledItemTween(param1.target);
                return;
            }
            if(param1.isSingle)
            {
                return;
            }
            var _loc2_:IHeaderQuestsContainer = IHeaderQuestsContainer(param1.target);
            this.animContainers(_loc2_);
        }

        private function onThisRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            this._needCollapseAnim = true;
            this._scheduler.scheduleTask(this.showCollapseAnim,COLLAPSE_ANIM_DELAY);
        }

        private function onThisRollOverHandler(param1:MouseEvent) : void
        {
            if(this._needCollapseAnim)
            {
                this._scheduler.cancelTask(this.showCollapseAnim);
            }
        }

        private function onPMItemsAnimStartHandler(param1:HeaderQuestsEvent) : void
        {
            this.updateHitArea();
        }

        private function onStageResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }
    }
}
