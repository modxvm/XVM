package net.wg.gui.components.carousels 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.motion.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class CarouselBase extends scaleform.clik.controls.CoreList
    {
        public function CarouselBase()
        {
            this._padding = new scaleform.clik.utils.Padding(0);
            super();
            this.visible = false;
            return;
        }

        protected function getDefContainerPos():Number
        {
            if (this.leftArrow && this.leftArrow.visible) 
                return this.leftArrow.x + this.leftArrow.width ^ 0;
            return 0;
        }

        protected function updateArrowsState():void
        {
            var loc1:*=this.calculateRendererTotal(0, 0);
            if (loc1 <= this.countVisibleSlots) 
            {
                this.enableLeftArrow(false);
                this.enableRightArrow(false);
                this.skippCall = false;
                this.allowDrag = false;
            }
            else if (this.currentFirstRenederer != 0) 
                if (this.currentFirstRenederer >= loc1 - this.countVisibleSlots) 
                {
                    this.enableLeftArrow(true);
                    this.enableRightArrow(false);
                    this.skippCall = false;
                    this.allowDrag = true;
                }
                else 
                {
                    this.enableLeftArrow(true);
                    this.enableRightArrow(true);
                    this.allowDrag = true;
                }
            else 
            {
                this.enableLeftArrow(false);
                this.enableRightArrow(true);
                this.skippCall = false;
                this.allowDrag = true;
            }
            return;
        }

        protected function enableLeftArrow(arg1:Boolean=false):void
        {
            if (this.leftArrow.enabled != arg1) 
            {
                this.leftArrow.enabled = arg1;
                this.leftArrow.validateNow();
            }
            return;
        }

        protected function enableRightArrow(arg1:Boolean=false):void
        {
            if (this.rightArrow.enabled != arg1) 
            {
                this.rightArrow.enabled = arg1;
                this.rightArrow.validateNow();
            }
            return;
        }

        protected function get currentFirstRenederer():uint
        {
            return this._currentFirstRenederer;
        }

        protected function set currentFirstRenederer(arg1:uint):void
        {
            if (arg1 == this._currentFirstRenederer) 
                return;
            this._currentFirstRenederer = arg1;
            this.updateArrowsState();
            return;
        }

        protected override function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            if (_renderers.length > this.countVisibleSlots) 
            {
                this.startSlideByArrow(arg1.delta > 0 ? "left" : "right", false);
                this.stopSlideByArrow(arg1.delta > 0 ? "left" : "right");
            }
            return;
        }

        internal function renderersMouseEnabled(arg1:Boolean=false):void
        {
            var loc1:*=_renderers.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (_renderers[loc2] is net.wg.infrastructure.interfaces.IPersonalCaseItemRenderer) 
                    net.wg.infrastructure.interfaces.IPersonalCaseItemRenderer(_renderers[loc2]).canSelected = arg1;
                else 
                    return;
                ++loc2;
            }
            return;
        }

        internal function updateDrugPosition(arg1:flash.display.DisplayObject, arg2:Object):void
        {
            var loc1:*=NaN;
            if (this.isDragging) 
            {
                loc1 = arg2.scopeStartX + (arg1.mouseX - arg2.startMouseX);
                if (loc1 > arg2.scopeDefPosition + MAX_DRAG_ODDSET) 
                    loc1 = arg2.scopeDefPosition + MAX_DRAG_ODDSET;
                else if (loc1 < arg2.scopeDefPosition - arg2.allowDragDistance - MAX_DRAG_ODDSET) 
                    loc1 = arg2.scopeDefPosition - arg2.allowDragDistance - MAX_DRAG_ODDSET;
                container.x = container.x + (loc1 - container.x) / DRAG_ACCELERATOR;
                container.x = container.x ^ 0;
                this.lastDx = container.x - this.lastContenerXPos;
                this.lastContenerXPos = container.x;
            }
            return;
        }

        internal function slidingFn(arg1:Object):void
        {
            var loc1:*=container.x + this.lastDx;
            this.lastDx = this.lastDx + (-this.lastDx) / this.slideSelfAcceleratorDynamic;
            this.currentFirstRenederer = this.getCurrentFirstRendererOnAnim();
            if (loc1 > arg1.scopeDefPosition) 
            {
                container.x = container.x + (arg1.scopeDefPosition - container.x + this.lastDx) / SLIDE_TO_POS_ACCELERATOR;
                this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
                if (container.x - arg1.scopeDefPosition + this.lastDx < 1 && Math.abs(this.lastDx) < 1) 
                {
                    container.x = arg1.scopeDefPosition;
                    this.clearSlidingIntervalId();
                    this.currentFirstRenederer = 0;
                }
            }
            else if (loc1 < arg1.scopeDefPosition - arg1.allowDragDistance) 
            {
                container.x = container.x + (arg1.scopeDefPosition - arg1.allowDragDistance - container.x + this.lastDx) / SLIDE_TO_POS_ACCELERATOR;
                this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
                if (Math.abs(arg1.scopeDefPosition - arg1.allowDragDistance - container.x + this.lastDx) < 1 && Math.abs(this.lastDx) < 1) 
                {
                    container.x = arg1.scopeDefPosition - arg1.allowDragDistance;
                    this.clearSlidingIntervalId();
                }
            }
            else 
            {
                container.x = loc1;
                if (Math.abs(this.lastDx) < 1) 
                {
                    container.x = container.x ^ 0;
                    this.clearSlidingIntervalId();
                    this.beginSlideToPos();
                }
            }
            return;
        }

        protected function removeCursorListeners():void
        {
            this.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            return;
        }

        internal function beginSlideToPos():void
        {
            var loc1:*=this.getCurrentFirstRendererOnAnim();
            this.slideToRenderer(loc1);
            return;
        }

        internal function slideToRenderer(arg1:Number):void
        {
            this.currentFirstRenederer = arg1;
            var loc1:*=(-arg1) * this.getSlotWidth() + this.getDefContainerPos();
            new scaleform.clik.motion.Tween(300, container, {"x":loc1}, {"paused":false, "onComplete":null});
            return;
        }

        internal function stopSlideByArrow(arg1:String):void
        {
            var loc1:*=(-this.currentFirstRenederer) * this.getSlotWidth() - (container.x - this.getDefContainerPos());
            var loc2:*=this._padding.left + this._padding.right + 10;
            var loc3:*=this.currentFirstRenederer;
            if (arg1 == "right" && loc1 > loc2) 
                loc3 = this.currentFirstRenederer + Math.round(loc1 / this.getSlotWidth()) + 1;
            else if (arg1 == "left" && loc1 < -loc2) 
                loc3 = (this.currentFirstRenederer - Math.floor((-loc1) / this.getSlotWidth()) - 1);
            if (loc3 < 0) 
                loc3 = 0;
            else if (loc3 > _renderers.length - this.countVisibleSlots) 
                loc3 = _renderers.length - this.countVisibleSlots;
            this.currentFirstRenederer = loc3;
            this.courceFactor = 0;
            return;
        }

        internal function startSlideByArrow(arg1:String, arg2:Boolean):void
        {
            this.clearSlidingIntervalId();
            if (this.skippCall) 
                this.skippCall = arg2;
            else 
            {
                this.skippCall = arg2;
                this.currentFirstRenederer = arg1 != "left" ? Math.min(_renderers.length - this.countVisibleSlots, this.currentFirstRenederer + 1) : Math.max(0, (this.currentFirstRenederer - 1));
                if (this.currentFirstRenederer == 0 || this.currentFirstRenederer == _renderers.length - this.countVisibleSlots) 
                    this.courceFactor = 0;
                else 
                    this.courceFactor = arg1 != "left" ? -1 : 1;
                if (this.arrowSlideIntervaId == 0 && container) 
                {
                    this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
                    this.arrowSlideIntervaId = flash.utils.setInterval(this.arrowSlide, 30);
                }
            }
            return;
        }

        internal function arrowSlide():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            this.lastDx = this.lastDx + (MAX_DX * this.courceFactor - this.lastDx) / SLIDE_SELF_ACCELERATOR;
            if (this.courceFactor != 0) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this).countFactor + 1);
                loc3.countFactor = loc4;
                container.x = container.x + this.lastDx;
                if (this.getCurrentFirstRendererOnAnim() == 0 && this.courceFactor == 1) 
                {
                    this.currentFirstRenederer = 0;
                    this.courceFactor = 0;
                }
                else if (this.getCurrentFirstRendererOnAnim() == _renderers.length - this.countVisibleSlots && this.courceFactor == -1) 
                {
                    this.currentFirstRenederer = _renderers.length - this.countVisibleSlots;
                    this.courceFactor = 0;
                }
            }
            else 
            {
                this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
                this.lastDx = this.lastDx + (-this.lastDx) / this.slideSelfAcceleratorDynamic;
                loc1 = this.getDefContainerPos() - this.currentFirstRenederer * this.getSlotWidth();
                loc2 = (loc1 - container.x) / SLIDE_SELF_ACCELERATOR + this.lastDx;
                loc2 = loc2 >= 0 ? Math.min(MAX_DX, loc2) : -Math.min(-loc2, MAX_DX);
                container.x = container.x + loc2;
                if (Math.abs(container.x + this.lastDx - loc1) < 1) 
                {
                    container.x = loc1;
                    this.clearArrowSlide();
                }
            }
            return;
        }

        internal function clearArrowSlide():void
        {
            if (this.arrowSlideIntervaId) 
            {
                flash.utils.clearInterval(this.arrowSlideIntervaId);
                this.arrowSlideIntervaId = 0;
            }
            return;
        }

        internal function getCurrentFirstRendererOnAnim():Number
        {
            var loc1:*=-Math.round((container.x - this.getDefContainerPos()) / this.getSlotWidth());
            if (loc1 < 0) 
                loc1 = 0;
            else if (loc1 > _renderers.length - this.countVisibleSlots) 
                loc1 = _renderers.length - this.countVisibleSlots;
            return loc1;
        }

        internal function clearSlidingIntervalId():void
        {
            if (this.slidingIntervalId) 
            {
                this.renderersMouseEnabled(true);
                flash.utils.clearInterval(this.slidingIntervalId);
                this.slidingIntervalId = 0;
                this.lastDx = 0;
            }
            return;
        }

        internal function disposeRenderers():void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (_renderers == null || _dataProvider == null) 
                return;
            var loc1:*=_renderers.length;
            --loc2;
            while (loc2 >= 0) 
            {
                loc3 = getRendererAt(loc2);
                if (loc3 != null) 
                {
                    cleanUpRenderer(loc3);
                    if (loc4 = loc3 as net.wg.infrastructure.interfaces.entity.IDisposable) 
                        loc4.dispose();
                    loc5 = loc3 as flash.display.DisplayObject;
                    if (container.contains(loc5)) 
                        container.removeChild(loc5);
                }
                _renderers.splice(loc2, 1);
                --loc2;
            }
            _dataProvider = null;
            return;
        }

        internal function carouselMouseMoveHandler(arg1:flash.events.MouseEvent):void
        {
            if (this.isDragging) 
            {
                this.renderersMouseEnabled(false);
                App.cursor.setCursor(net.wg.data.constants.Cursors.MOVE);
            }
            return;
        }

        internal function isMouseOnDragArea(arg1:flash.events.MouseEvent):Boolean
        {
            var loc1:*=this.mouseX > this.dragHitArea.x && this.mouseX < this.dragHitArea.x + this.dragHitArea.width;
            if (arg1.target == this.leftArrow || arg1.target == this.rightArrow || loc1 == false) 
                return false;
            return true;
        }

        internal function arrowRelease(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.stopSlideByArrow(arg1.target != this.leftArrow ? "right" : "left");
            return;
        }

        internal function arrowClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.startSlideByArrow(arg1.target != this.leftArrow ? "right" : "left", false);
            return;
        }

        internal function arrowPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.startSlideByArrow(arg1.target != this.leftArrow ? "right" : "left", true);
            return;
        }

        internal function arrowUp(arg1:flash.events.MouseEvent):void
        {
            arg1.target.dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE));
            return;
        }

        internal function onChangeCursorHandler(arg1:scaleform.gfx.MouseCursorEvent):void
        {
            this.lastCursor = arg1.cursor;
            arg1.stopImmediatePropagation();
            return;
        }

        protected function mouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            if (this.isDragging) 
            {
                App.cursor.setCursor(net.wg.data.constants.Cursors.MOVE);
                App.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.carouselMouseMoveHandler);
            }
            else if (this.isMouseOnDragArea(arg1) && App.cursor) 
                App.cursor.setCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
            else if (App.cursor) 
                App.cursor.setCursor(net.wg.data.constants.Cursors.BUTTON);
            return;
        }

        protected function stopDragging(arg1:flash.events.MouseEvent=null):void
        {
            var loc3:*=null;
            var loc1:*=App.stage;
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.stopDragging);
            loc1.removeEventListener(scaleform.gfx.MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.carouselMouseMoveHandler);
            flash.utils.clearInterval(this.draggingIntervalId);
            this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
            if (this.slidingIntervalId == 0) 
            {
                loc3 = {"scopeDefPosition":this.getDefContainerPos(), "allowDragDistance":this.getScopeWidth() - this.renderersMask.width};
                this.slidingIntervalId = flash.utils.setInterval(this.slidingFn, 30, loc3);
            }
            this.isDragging = false;
            var loc2:*=App.cursor;
            if (this.mouseIn) 
                if (loc2) 
                    if (this.isMouseOnDragArea(arg1)) 
                        loc2.setCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
                    else 
                        loc2.setCursor(net.wg.data.constants.Cursors.BUTTON);
            else 
                loc2.setCursor(this.lastCursor);
            return;
        }

        protected function mouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            this.mouseIn = false;
            if (!this.isDragging && App.cursor) 
                App.cursor.setCursor(net.wg.data.constants.Cursors.ARROW);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.leftArrow.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
            this.rightArrow.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
            this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
            this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
            this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
            this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
            this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
            this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
            _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange);
            this.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.startDragging);
            var loc1:*=App.stage;
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.stopDragging);
            loc1.removeEventListener(scaleform.gfx.MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.carouselMouseMoveHandler);
            this.disposeRenderers();
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (_dataProvider == arg1) 
                return;
            if (_dataProvider != null) 
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
            _dataProvider = arg1;
            if (_dataProvider == null) 
                return;
            _dataProvider.addEventListener(flash.events.Event.CHANGE, handleDataChange, false, 0, true);
            return;
        }

        public function get padding():Object
        {
            return this._padding;
        }

        public function set padding(arg1:Object):void
        {
            if (!arg1) 
                return;
            this._padding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public function get carouselType():String
        {
            return this._carouselType;
        }

        public function set carouselType(arg1:String):void
        {
            this._carouselType = arg1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.SIZE) && this.useShadow) 
                this.setChildIndex(this.shadow, (this.numChildren - 1));
            if (isInvalid(INIT_CAROUSEL) && !(dataProvider == null) && dataProvider.length > 0) 
            {
                this.isUpdated = true;
                this.drawRenderers(dataProvider.length);
                this.drawLayout();
                this.refreshData();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.leftArrow.x = 0;
            this.rightArrow.width = 21;
            this.leftArrow.width = 21;
            this.shadow.visible = false;
            var loc1:*;
            this.shadow.mouseEnabled = loc1 = false;
            this.shadow.mouseChildren = loc1 = loc1;
            this.shadow.tabChildren = loc1 = loc1;
            this.shadow.tabEnabled = loc1;
            if (this.dragHitArea) 
                this.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.startDragging);
            if (this.leftArrow && this.rightArrow) 
            {
                this.leftArrow.autoRepeat = true;
                this.rightArrow.autoRepeat = true;
                this.leftArrow.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
                this.rightArrow.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
                this.leftArrow.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
                this.rightArrow.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
                this.leftArrow.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
                this.rightArrow.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
                this.leftArrow.addEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
                this.rightArrow.addEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
            }
            this.setCursorListeners();
            return;
        }

        protected override function drawRenderers(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (_itemRenderer == null) 
                return;
            loc1 = _renderers.length;
            while (loc1 < arg1) 
            {
                if ((loc3 = createRenderer(loc1)) == null) 
                    break;
                _renderers.push(loc3);
                container.addChild(loc3 as flash.display.DisplayObject);
                ++loc1;
            }
            loc2 = _renderers.length;
            --loc1;
            while (loc1 >= arg1) 
            {
                if ((loc3 = getRendererAt(loc1)) != null) 
                {
                    cleanUpRenderer(loc3);
                    loc4 = loc3 as flash.display.DisplayObject;
                    if (container.contains(loc4)) 
                        container.removeChild(loc4);
                }
                _renderers.splice(loc1, 1);
                --loc1;
            }
            return;
        }

        protected override function refreshData():void
        {
            _dataProvider.requestItemRange(0, _dataProvider.length, this.populateData);
            return;
        }

        protected override function drawLayout():void
        {
            var loc1:*=0;
            var loc2:*=NaN;
            var loc3:*=false;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            if (_renderers) 
            {
                loc1 = _renderers.length;
                loc2 = this._padding.left + this._padding.right;
                loc3 = isInvalid(scaleform.clik.constants.InvalidationType.DATA);
                loc4 = 0;
                loc5 = 0;
                while (loc5 < loc1) 
                {
                    loc6 = getRendererAt(loc5);
                    this.updateRenderPosition(loc6, loc5, loc4, loc2);
                    loc4 = loc6.x;
                    if (loc3) ;
                    ++loc5;
                }
                if (this.isInitSize) 
                {
                    this.updateContainerPosition();
                    if (this.useShadow) 
                        this.shadow.visible = this.leftArrow.visible;
                }
                else 
                    this.initPosition();
            }
            return;
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            return dataProvider.length;
        }

        protected function setCursorListeners():void
        {
            this.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            return;
        }

        internal function startDragging(arg1:flash.events.MouseEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.mouseX > this.dragHitArea.x && this.mouseX < this.dragHitArea.x + this.dragHitArea.width;
            if (arg1.target == this.leftArrow || arg1.target == this.rightArrow || loc1 == false) 
                return;
            if (DRAG_ENABLE && this.allowDrag) 
            {
                this.mouseIn = true;
                if (App.cursor) 
                    App.cursor.setCursor(net.wg.data.constants.Cursors.MOVE);
                loc2 = App.stage;
                loc2.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.stopDragging);
                loc2.addEventListener(scaleform.gfx.MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
                loc2.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.carouselMouseMoveHandler);
                this.clearSlidingIntervalId();
                if (!this.isDragging) 
                {
                    loc3 = {"scopeStartX":container.x, "startMouseX":mouseX, "allowDragDistance":this.getScopeWidth() - this.renderersMask.width, "scopeDefPosition":this.getDefContainerPos()};
                    this.isDragging = true;
                    this.lastContenerXPos = container.x;
                    this.clearArrowSlide();
                    this.draggingIntervalId = flash.utils.setInterval(this.updateDrugPosition, 30, this, loc3);
                }
            }
            return;
        }

        protected function getScopeWidth():Number
        {
            var loc1:*=0;
            if (_renderers) 
            {
                loc1 = _renderers.length * this.getSlotWidth() + this.margin;
                loc1 = loc1 - 3;
            }
            return loc1;
        }

        protected function populateData(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc1:*=arg1.length;
            var loc2:*=_renderers.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = getRendererAt(loc3);
                loc5 = loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 >= loc1 ? false : true;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                loc4.validateNow();
                if (!this.showEmptyItems) 
                    scaleform.clik.core.UIComponent(loc4).visible = !(arg1[loc3] == null);
                ++loc3;
            }
            return;
        }

        protected function updateRenderPosition(arg1:scaleform.clik.interfaces.IListItemRenderer, arg2:uint, arg3:int, arg4:Number):void
        {
            arg1.x = arg2 != 0 ? arg3 + (this.slotImageWidth + arg4) : this._padding.left;
            arg1.y = this._padding.top;
            return;
        }

        protected function updateContainerPosition():void
        {
            var loc1:*=0;
            if (_renderers.length <= this.countVisibleSlots) 
            {
                var loc2:*;
                this.rightArrow.visible = loc2 = false;
                this.leftArrow.visible = loc2;
                loc1 = (this.slotImageWidth + this._padding.left + this._padding.right) * _renderers.length ^ 0;
                container.x = this.renderersMask.x + this.renderersMask.width / 2 - loc1 / 2 ^ 0;
            }
            else 
            {
                this.rightArrow.visible = loc2 = true;
                this.leftArrow.visible = loc2;
            }
            this.updateArrowsState();
            return;
        }

        protected function initPosition():void
        {
            this.isInitSize = true;
            container.x = this.getDefContainerPos();
            var loc1:*;
            this.dragHitArea.x = loc1 = this.leftArrow.x + this.leftArrow.width;
            this.renderersMask.x = loc1;
            this.dragHitArea.y = loc1 = 0;
            this.renderersMask.y = loc1;
            this.dragHitArea.width = loc1 = this.countVisibleSlots * (this.slotImageWidth + this._padding.left + this._padding.right);
            this.renderersMask.width = loc1;
            this.dragHitArea.height = loc1 = this.slotImageHeight + 2;
            this.renderersMask.height = loc1;
            this.shadow.x = this.renderersMask.x;
            this.shadow.width = this.renderersMask.width;
            this.shadow.height = this.leftArrow.height;
            container.mask = null;
            container.mask = this.renderersMask;
            this.leftArrow.height = loc1 = this.renderersMask.height + this.offsetArrowHeight;
            this.rightArrow.height = loc1;
            this.rightArrow.x = container.x + this.renderersMask.width + this.leftArrow.width ^ 0;
            this.leftArrow.y = loc1 = (this.renderersMask.height - this.leftArrow.height) * 0.5 ^ 0;
            this.rightArrow.y = loc1;
            this.visible = true;
            this.updateContainerPosition();
            this.updateArrowsState();
            return;
        }

        protected function getSlotWidth():Number
        {
            return this.slotImageWidth + this._padding.left + this._padding.right;
        }

        internal static const MAX_DX:Number=30;

        public static const INIT_CAROUSEL:String="initCarousel";

        internal static const DRAG_ENABLE:Boolean=true;

        internal static const DRAG_ACCELERATOR:Number=3;

        internal static const SLIDE_SELF_ACCELERATOR:Number=7;

        internal static const SLIDE_TO_POS_ACCELERATOR:Number=7;

        internal static const MAX_DRAG_ODDSET:Number=100;

        public var leftArrow:scaleform.clik.controls.Button;

        public var rightArrow:scaleform.clik.controls.Button;

        public var shadow:flash.display.MovieClip;

        protected var isDragging:Boolean=false;

        protected var allowDrag:Boolean;

        protected var skippCall:Boolean=false;

        protected var _currentFirstRenederer:uint=0;

        protected var isInitSize:Boolean=false;

        internal var _padding:scaleform.clik.utils.Padding;

        internal var _carouselType:String="horizontal";

        internal var mouseIn:Boolean=false;

        public var margin:uint=3;

        internal var countFactor:int=0;

        internal var draggingIntervalId:uint=0;

        internal var slidingIntervalId:uint=0;

        internal var arrowSlideIntervaId:uint=0;

        internal var courceFactor:Number=0;

        internal var slideSelfAcceleratorDynamic:Number=7;

        internal var lastContenerXPos:Number=0;

        internal var lastDx:Number=0;

        internal var isUpdated:Boolean=false;

        internal var showEmptyItems:Boolean=false;

        public var dragHitArea:flash.display.MovieClip;

        public var slotImageWidth:uint=60;

        public var slotImageHeight:uint=60;

        public var countVisibleSlots:uint=5;

        public var offsetArrowHeight:int=0;

        public var useShadow:Boolean=false;

        public var renderersMask:flash.display.MovieClip;

        internal var lastCursor:String="arrow";
    }
}
