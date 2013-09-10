package net.wg.gui.components.controls
{
    import __AS3__.vec.*;
//    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.motion.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;

    public class Carousel extends net.wg.gui.components.controls.CoreListEx
    {
        public function Carousel()
        {
            this._padding = new scaleform.clik.utils.Padding([0, 0, 0, 0]);
            this.slideSelfAcceleratorDynamic = this.slideSelfAccelerator;
            super();
            return;
        }

        protected function set currentFirstRenederer(arg1:uint):void
        {
            if (arg1 == this._currentFirstRenederer)
                return;
            this._currentFirstRenederer = arg1;
            this.updateArrowsState();
            return;
        }

        protected function get currentFirstRenederer():uint
        {
            return this._currentFirstRenederer;
        }

        protected function getDefContainerPos():Number
        {
            if (this.leftArrow && this.leftArrow.visible)
                return this.leftArrow.x + this.leftArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET ^ 0;
            return 0;
        }

        protected function getScopeWidth():Number
        {
            var loc1:*=0;
            if (_renderers)
                loc1 = _renderers.length * this.getSlotWidth() + this.margin * 2;
            return loc1;
        }

        protected function getSlotWidth():Number
        {
            return this.slotImageWidth + this.padding.horizontal;
        }

        protected function updateArrowsState():void
        {
            var loc1:*=this.calculateRendererTotal(0, 0);
            if (loc1 <= this.visibleSlots || !enabled)
            {
                this.allowDrag = false;
                this.leftArrow.enabled = false;
                this.rightArrow.enabled = false;
            }
            else if (this.currentFirstRenederer != 0)
                if (this.currentFirstRenederer >= loc1 - this.visibleSlots)
                {
                    this.leftArrow.enabled = true;
                    this.rightArrow.enabled = false;
                    this.allowDrag = true;
                }
                else
                {
                    this.leftArrow.enabled = true;
                    this.rightArrow.enabled = true;
                    this.allowDrag = true;
                }
            else
            {
                this.leftArrow.enabled = false;
                this.rightArrow.enabled = true;
                this.allowDrag = true;
            }
            return;
        }

        public function updateSize(arg1:int, arg2:int):void
        {
            this._allowW = arg1;
            this._allowH = arg2;
            _originalWidth = arg1;
            _originalHeight = arg2;
            setSize(arg1, arg2);
            return;
        }

        protected function updateLayout():void
        {
            if (initialized && _renderers)
            {
                this.updateArrowsState();
                this.updateUIPosition();
                this.correctContainerPosition();
                this.x = this._allowW - (this.rightArrow.x + contentMargin) >> 1;
            }
            return;
        }

        internal function correctBg():void
        {
            if (this.bg)
            {
                this.bg.width = this._allowW;
                this.bg.height = this.slotImageHeight + contentMargin * 2 ^ 0;
                this.bg.x = -(this._allowW - (this.rightArrow.x + contentMargin) >> 1);
            }
            return;
        }

        protected function correctContainerPosition():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (container)
            {
                loc1 = this.getScopeWidth() - this.renderersMask.width;
                loc2 = this.getDefContainerPos();
                if (container.x < loc2 - loc1)
                {
                    this.currentFirstRenederer = Math.max(_renderers.length - this.visibleSlots, 0);
                    this.goToFirstRenderer();
                }
            }
            return;
        }

        protected function goToFirstRenderer():void
        {
            container.x = this.getDefContainerPos() - this.currentFirstRenederer * this.getSlotWidth() ^ 0;
            return;
        }

        protected function updateUIPosition():void
        {
            if (container && this.rightArrow)
            {
                this.rightArrow.x = this.getDefContainerPos() + this.getSlotWidth() * this.visibleSlots + this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET + this.padding.left + this.padding.right;
                this.renderersMask.width = this.rightArrow.x - this.getDefContainerPos() - this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET;
                this.dragHitArea.width = this.renderersMask.width;
            }
            this.correctBg();
            return;
        }

        protected function removeRenderers():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (_renderers)
            {
                loc2 = _renderers.length;
                --loc1;
                while (loc1 >= 0)
                {
                    loc3 = getRendererAt(loc1);
                    if (loc3 != null)
                    {
                        cleanUpRenderer(loc3);
                        loc4 = loc3 as flash.display.DisplayObject;
                        (loc5 = loc3 as net.wg.infrastructure.interfaces.entity.IDisposable).dispose();
                        if (container.contains(loc4))
                            container.removeChild(loc4);
                        loc3 = null;
                        loc4 = null;
                        loc5 = null;
                    }
                    _renderers.splice(loc1, 1);
                    --loc1;
                }
            }
            _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
            return;
        }

        protected function updateEmptyRenderers():void
        {
            this.clearEmptyRenderers();
            this.createdEmptyRenderers();
            return;
        }

        protected function createdEmptyRenderers():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=0;
            if (_renderers)
            {
                loc3 = this.getEmptySlotsNumForShow();
                loc1 = _renderers.length;
                loc4 = this.padding.left + this.padding.right;
                loc5 = loc1;
                while (loc5 < loc1 + loc3)
                {
                    loc2 = createRenderer(loc5);
//                    if (loc2 != null) ;
                    loc2.x = loc4 + loc5 * (this.slotImageWidth + loc4);
                    loc2.setData(this.getEmptyRendererData());
                    _renderers.push(loc2);
                    container.addChild(loc2 as flash.display.DisplayObject);
                    loc2.validateNow();
                    ++loc5;
                }
            }
            return;
        }

        protected function clearEmptyRenderers():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            if (_renderers)
            {
                loc2 = _renderers.length;
                --loc5;
                while (loc5 >= 0)
                {
                    loc1 = getRendererAt(loc5);
                    if (!(loc1 == null) && "empty" in loc1 && loc1["empty"])
                    {
                        cleanUpRenderer(loc1);
                        (loc4 = loc1 as net.wg.infrastructure.interfaces.entity.IDisposable).dispose();
                        loc3 = loc1 as flash.display.DisplayObject;
                        if (container.contains(loc3))
                            container.removeChild(loc3);
                        _renderers.splice(loc5, 1);
                    }
                    --loc5;
                }
            }
            return;
        }

        protected function getEmptyRendererData():Object
        {
            var loc1:*={"empty":true};
            return loc1;
        }

        internal function startSlideByArrow(arg1:String, arg2:Boolean):void
        {
            this.clearSlidingIntervalId();
            if (this.skippCall)
                this.skippCall = arg2;
            else
            {
                this.skippCall = arg2;
                this.currentFirstRenederer = arg1 != "left" ? Math.min(_renderers.length - this.visibleSlots, this.currentFirstRenederer + 1) : Math.max(0, (this.currentFirstRenederer - 1));
                if (this.currentFirstRenederer == 0 || this.currentFirstRenederer == _renderers.length - this.visibleSlots)
                    this.courseFactor = 0;
                else
                    this.courseFactor = arg1 != "left" ? -1 : 1;
                if (this.arrowSlideIntervalId == 0 && container)
                {
                    this.slideSelfAcceleratorDynamic = this.slideSelfAccelerator;
                    this.tryClearTween();
                    this.arrowSlideIntervalId = flash.utils.setInterval(this.arrowSlide, 30);
                }
            }
            return;
        }

        internal function stopSlideByArrow(arg1:String):void
        {
            var loc1:*=(-this.currentFirstRenederer) * this.getSlotWidth() - (container.x - this.getDefContainerPos());
            var loc2:*=this.padding.left + this.padding.right + 10;
            var loc3:*=this.currentFirstRenederer;
            if (arg1 == "right" && loc1 > loc2)
                loc3 = this.currentFirstRenederer + Math.round(loc1 / this.getSlotWidth()) + 1;
            else if (arg1 == "left" && loc1 < -loc2)
                loc3 = (this.currentFirstRenederer - Math.floor((-loc1) / this.getSlotWidth()) - 1);
            if (loc3 < 0)
                loc3 = 0;
            else if (loc3 > _renderers.length - this.visibleSlots)
                loc3 = _renderers.length - this.visibleSlots;
            this.currentFirstRenederer = loc3;
            this.courseFactor = 0;
            return;
        }

        internal function arrowSlide():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            this.lastDx = this.lastDx + (this.maxDx * this.courseFactor - this.lastDx) / this.slideSelfAccelerator;
            if (this.courseFactor != 0)
            {
                container.x = container.x + this.lastDx;
                if (this.getCurrentFirstRendererOnAnim() == 0 && this.courseFactor == 1)
                {
                    this.currentFirstRenederer = 0;
                    this.courseFactor = 0;
                }
                else if (this.getCurrentFirstRendererOnAnim() == _renderers.length - this.visibleSlots && this.courseFactor == -1)
                {
                    this.currentFirstRenederer = _renderers.length - this.visibleSlots;
                    this.courseFactor = 0;
                }
            }
            else
            {
                this.slideSelfAcceleratorDynamic = this.slideToPosAccelerator;
                this.lastDx = this.lastDx + (-this.lastDx) / this.slideSelfAcceleratorDynamic;
                loc1 = this.getDefContainerPos() - this.currentFirstRenederer * this.getSlotWidth();
                loc2 = (loc1 - container.x) / this.slideSelfAccelerator + this.lastDx;
                loc2 = loc2 >= 0 ? Math.min(this.maxDx, loc2) : -Math.min(-loc2, this.maxDx);
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
            if (this.arrowSlideIntervalId)
            {
                flash.utils.clearInterval(this.arrowSlideIntervalId);
                this.arrowSlideIntervalId = 0;
            }
            return;
        }

        protected override function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            if (!enabled)
                return;
            App.contextMenuMgr.hide();
            this.startSlideByArrow(arg1.delta > 0 ? this.SLIDE_COURSE_LEFT : this.SLIDE_COURSE_RIGHT, false);
            this.stopSlideByArrow(arg1.delta > 0 ? this.SLIDE_COURSE_LEFT : this.SLIDE_COURSE_RIGHT);
            return;
        }

        protected function startDragging():void
        {
            var loc1:*=null;
            this.needCanceledClick = false;
            if (this._dragEnabled && this.allowDrag)
            {
                this.clearSlidingIntervalId();
                if (!this.isDragging)
                {
                    loc1 = {"scopeStartX":container.x, "startMouseX":mouseX, "allowDragDistance":this.getScopeWidth() - this.renderersMask.width, "scopeDefPosition":this.getDefContainerPos()};
                    this.isDragging = true;
                    this.lastContainerXPos = container.x;
                    this.clearArrowSlide();
                    this.tryClearTween();
                    this.draggingIntervalId = flash.utils.setInterval(this.updateDrugPosition, 30, this, loc1);
                }
            }
            return;
        }

        internal function updateDrugPosition(arg1:net.wg.gui.components.controls.Carousel, arg2:Object):void
        {
            var loc1:*=NaN;
            if (this.isDragging)
            {
                loc1 = arg2.scopeStartX + (arg1.mouseX - arg2.startMouseX);
                if (!this.needCanceledClick && Math.abs(arg1.mouseX - arg2.startMouseX) > this.distanceOfDragDelay)
                    this.needCanceledClick = true;
                if (this.needCanceledClick)
                {
                    if (loc1 > arg2.scopeDefPosition + this.maxDragOffset)
                        loc1 = arg2.scopeDefPosition + this.maxDragOffset;
                    else if (loc1 < arg2.scopeDefPosition - arg2.allowDragDistance - this.maxDragOffset)
                        loc1 = arg2.scopeDefPosition - arg2.allowDragDistance - this.maxDragOffset;
                    container.x = container.x + (loc1 - container.x) / this.dragAccelerator;
                    container.x = container.x ^ 0;
                    this.lastDx = container.x - this.lastContainerXPos;
                    this.lastContainerXPos = container.x;
                }
            }
            return;
        }

        internal function clearDraggingIntervalId():void
        {
            if (this.draggingIntervalId)
            {
                flash.utils.clearInterval(this.draggingIntervalId);
                this.draggingIntervalId = 0;
            }
            return;
        }

        internal function clearSlidingIntervalId():void
        {
            if (this.slidingIntervalId)
            {
                flash.utils.clearInterval(this.slidingIntervalId);
                this.slidingIntervalId = 0;
                this.lastDx = 0;
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
                container.x = container.x + (arg1.scopeDefPosition - container.x + this.lastDx) / this.slideToPosAccelerator;
                this.slideSelfAcceleratorDynamic = this.slideToPosAccelerator;
                if (container.x - arg1.scopeDefPosition + this.lastDx < 1 && Math.abs(this.lastDx) < 1)
                {
                    container.x = arg1.scopeDefPosition;
                    this.clearSlidingIntervalId();
                    this.currentFirstRenederer = 0;
                }
            }
            else if (loc1 < arg1.scopeDefPosition - arg1.allowDragDistance)
            {
                container.x = container.x + (arg1.scopeDefPosition - arg1.allowDragDistance - container.x + this.lastDx) / this.slideToPosAccelerator;
                this.slideSelfAcceleratorDynamic = this.slideToPosAccelerator;
                if (Math.abs(arg1.scopeDefPosition - arg1.allowDragDistance - container.x + this.lastDx) < 1 && Math.abs(this.lastDx) < 1)
                {
                    container.x = arg1.scopeDefPosition - arg1.allowDragDistance;
                    this.clearSlidingIntervalId();
                    this.currentFirstRenederer = (_renderers.length - 1);
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

        internal function beginSlideToPos():void
        {
            var loc1:*=this.getCurrentFirstRendererOnAnim();
            this.slideToRenderer(loc1);
            return;
        }

        internal function getCurrentFirstRendererOnAnim():Number
        {
            var loc1:*=-Math.round((container.x - this.getDefContainerPos()) / this.getSlotWidth());
            if (loc1 < 0)
                loc1 = 0;
            else if (loc1 > _renderers.length - this.visibleSlots)
                loc1 = _renderers.length - this.visibleSlots;
            return loc1;
        }

        internal function slideToRenderer(arg1:Number):void
        {
            this.currentFirstRenederer = arg1;
            var loc1:*=(-arg1) * this.getSlotWidth() + this.getDefContainerPos();
            this.tryClearTween();
//            this.tween = new scaleform.clik.motion.Tween(1000, container, {"x":loc1}, {"paused":false, "onComplete":this.onTweenComplete, "ease":fl.transitions.easing.Strong.easeInOut});
            this.isTween = true;
            return;
        }

        internal function onTweenComplete():void
        {
            this.isTween = false;
            this.tryClearTween();
            return;
        }

        protected function tryClearTween():void
        {
            if (this.tween)
            {
                this.tween.paused = true;
                this.tween = null;
                this.isTween = false;
            }
            return;
        }

        public override function get selectedIndex():int
        {
            return _selectedIndex;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 == _selectedIndex)
                return;
            var loc1:*=getRendererAt(_selectedIndex);
            if (loc1 != null)
                loc1.selected = false;
            super.selectedIndex = arg1;
            loc1 = getRendererAt(_selectedIndex);
            if (loc1 != null)
                loc1.selected = true;
            return;
        }


        {
            contentMargin = 0;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            this.updateArrowsState();
            return;
        }

        protected override function configUI():void
        {
            contentMargin = this.margin;
            super.configUI();
            this.initUIStartPosition();
            if (this.dragHitArea && this._dragEnabled)
                this.dragHitArea.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onDragAreaMouseDown);
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
            this.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemClick);
            this.addEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER, this.onItemRollOver);
            this.addEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT, this.onItemRollOut);
            return;
        }

        protected function initUIStartPosition():void
        {
            this.leftArrow.x = contentMargin;
            this.leftArrow.y = contentMargin;
            this.rightArrow.y = contentMargin;
            container.x = contentMargin;
            container.y = contentMargin;
            this.renderersMask.x = contentMargin;
            this.renderersMask.y = contentMargin;
            this.dragHitArea.x = this.renderersMask.x;
            this.dragHitArea.y = this.renderersMask.x;
            return;
        }

        internal function arrowPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.startSlideByArrow(arg1.target != this.leftArrow ? this.SLIDE_COURSE_RIGHT : this.SLIDE_COURSE_LEFT, true);
            return;
        }

        internal function arrowClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.startSlideByArrow(arg1.target != this.leftArrow ? this.SLIDE_COURSE_RIGHT : this.SLIDE_COURSE_LEFT, false);
            return;
        }

        internal function arrowUp(arg1:flash.events.MouseEvent):void
        {
            arg1.target.dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE));
            return;
        }

        internal function arrowRelease(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.stopSlideByArrow(arg1.target != this.leftArrow ? this.SLIDE_COURSE_RIGHT : this.SLIDE_COURSE_LEFT);
            return;
        }

        protected function onItemClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            return;
        }

        protected function onItemRollOut(arg1:net.wg.gui.events.ListEventEx):void
        {
            return;
        }

        protected function onItemRollOver(arg1:net.wg.gui.events.ListEventEx):void
        {
            return;
        }

        protected override function onItemStartDrag(arg1:net.wg.gui.events.ListEventEx):void
        {
            this.needCanceledClick = false;
            if (arg1.buttonIdx == 0)
            {
                stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onStageMouseUp);
                this.startDragging();
            }
            return;
        }

        internal function onDragAreaMouseDown(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*;
            if ((loc3 = loc1 != null ? loc1.buttonIdx : 0) != 0)
                return;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onStageMouseUp);
            this.startDragging();
            return;
        }

        internal function onStageMouseUp(arg1:flash.events.MouseEvent):void
        {
            if (stage.hasEventListener(flash.events.MouseEvent.MOUSE_UP))
                stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onStageMouseUp);
            this.stopDragging();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA))
            {
                this.refreshData();
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE))
            {
                this.updateVisibleSlots();
                this.updateEmptyRenderers();
                this.updateLayout();
            }
            return;
        }

        protected override function refreshData():void
        {
            this.removeRenderers();
            this.invalidateContainer();
            _totalRenderers = this.calculateRendererTotal(0, 0);
            this.drawRenderers(_totalRenderers);
            _dataProvider.requestItemRange(0, _dataProvider.length, this.populateData);
            return;
        }

        internal function invalidateContainer():void
        {
            if (this.contains(container))
                removeChild(container);
            if (!this.contains(container))
                addChild(container);
            if (this.renderersMask)
            {
                this.setChildIndex(this.renderersMask, (this.numChildren - 1));
                container.mask = this.renderersMask;
            }
            return;
        }

        protected function stopDragging():void
        {
            var loc1:*=null;
            this.clearDraggingIntervalId();
            this.slideSelfAcceleratorDynamic = this.slideSelfAccelerator;
            if (this.slidingIntervalId == 0)
            {
                loc1 = {"scopeDefPosition":this.getDefContainerPos(), "allowDragDistance":this.getScopeWidth() - this.renderersMask.width};
                this.tryClearTween();
                this.slidingFn(loc1);
                this.slidingIntervalId = flash.utils.setInterval(this.slidingFn, 30, loc1);
            }
            this.isDragging = false;
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
            if (_renderers == null)
                return;
            var loc5:*=this.padding.left + this.padding.right;
            loc1 = 0;
            while (loc1 < _totalRenderers)
            {
                if ((loc3 = createRenderer(loc1)) == null)
                    break;
                loc3.x = loc5 + loc1 * (this.slotImageWidth + loc5);
                _renderers.push(loc3);
                container.addChild(loc3 as flash.display.DisplayObject);
                ++loc1;
            }
            return;
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
                loc4.enabled = loc3 < loc1 && enabled;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                loc4.validateNow();
                ++loc3;
            }
            return;
        }

        protected function updateVisibleSlots():Number
        {
            this.visibleSlots = (this._allowW - (this.leftArrow.x + this.leftArrow.width + this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + this.padding.horizontal)) / this.getSlotWidth();
            return this.visibleSlots;
        }

        protected function getEmptySlotsNumForShow():uint
        {
            var loc1:*=0;
            if (initialized)
            {
                if (!this.visibleSlots)
                    this.updateVisibleSlots();
                loc1 = this.visibleSlots - this.calculateRendererTotal(0, 0);
            }
            return Math.max(loc1, 0);
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            var loc1:*=_dataProvider.length > 0 ? _dataProvider.length : 0;
            return loc1;
        }

        public override function scrollToIndex(arg1:uint):void
        {
            var loc1:*=0;
            if (container && _renderers)
            {
                this.updateVisibleSlots();
                loc1 = Math.floor(this.visibleSlots / 2);
                arg1 = Math.min(_renderers.length - this.visibleSlots, Math.max(0, arg1 - loc1));
                this.currentFirstRenederer = Math.min(_renderers.length - this.visibleSlots, arg1);
                this.goToFirstRenderer();
            }
            return;
        }

        public function set dragEnabled(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._dragEnabled == arg1)
                return;
            this._dragEnabled = arg1;
            if (_renderers)
            {
                loc1 = 0;
                while (loc1 < _renderers.length)
                {
                    loc2 = getRendererAt(loc1) as net.wg.gui.components.controls.DragableListItemRenderer;
                    loc2.dragEnabled = this._dragEnabled;
                    ++loc1;
                }
            }
            return;
        }

        public function get dragEnabled():Boolean
        {
            return this._dragEnabled;
        }

        public override function toString():String
        {
            return "[Wargaming Carusel" + name + "]";
        }

        public override function dispose():void
        {
            super.dispose();
            this.tryClearTween();
            this.clearDraggingIntervalId();
            this.clearSlidingIntervalId();
            this.clearArrowSlide();
            if (this.dragHitArea && this.dragHitArea.hasEventListener(flash.events.MouseEvent.MOUSE_DOWN))
                this.dragHitArea.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onDragAreaMouseDown);
            if (this.leftArrow && this.rightArrow)
            {
                if (this.leftArrow.hasEventListener(flash.events.MouseEvent.MOUSE_UP))
                    this.leftArrow.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
                if (this.rightArrow.hasEventListener(flash.events.MouseEvent.MOUSE_UP))
                    this.rightArrow.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.arrowUp);
                if (this.leftArrow.hasEventListener(scaleform.clik.events.ButtonEvent.PRESS))
                    this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
                if (this.rightArrow.hasEventListener(scaleform.clik.events.ButtonEvent.PRESS))
                    this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.arrowPress);
                if (this.leftArrow.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK))
                    this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
                if (this.rightArrow.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK))
                    this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.arrowClick);
                if (this.leftArrow.hasEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE))
                    this.leftArrow.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
                if (this.rightArrow.hasEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE))
                    this.rightArrow.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.arrowRelease);
            }
            if (this.hasEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK))
                this.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemClick);
            if (this.hasEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER))
                this.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER, this.onItemRollOver);
            if (this.hasEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT))
                this.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT, this.onItemRollOut);
            this.removeRenderers();
            if (container && this.contains(container))
                removeChild(container);
            _renderers = null;
            return;
        }

        public function get padding():scaleform.clik.utils.Padding
        {
            return this._padding;
        }

        public function set padding(arg1:scaleform.clik.utils.Padding):void
        {
            this._padding = arg1;
            return;
        }

        public function set inspectablePadding(arg1:Object):void
        {
            if (!componentInspectorSetting)
                return;
            this.padding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        internal const SLIDE_COURSE_LEFT:String="left";

        internal const SLIDE_COURSE_RIGHT:String="right";

        public static const FILTERS_CAROUSEL_OFFSET:Number=15;

        public static const CAROUSEL_BUTTON_ARROW_OFFSET:Number=0;

        public var rightArrow:net.wg.gui.components.controls.SoundButton;

        public var renderersMask:flash.display.MovieClip;

        public var dragHitArea:flash.display.MovieClip;

        public var bg:flash.display.MovieClip;

        protected var _padding:scaleform.clik.utils.Padding;

        protected var visibleSlots:Number=0;

        protected var _allowW:Number=0;

        protected var _allowH:Number=0;

        internal var courseFactor:Number=0;

        internal var slideSelfAccelerator:Number=7;

        internal var slideToPosAccelerator:Number=7;

        internal var dragAccelerator:Number=3;

        internal var slideSelfAcceleratorDynamic:Number;

        internal var lastDx:Number=0;

        internal var maxDx:Number=30;

        internal var lastContainerXPos:Number=0;

        internal var maxDragOffset:Number=100;

        public var margin:Number=0;

        public var slotImageWidth:Number=0;

        protected var isDragging:Boolean=false;

        protected var needCanceledClick:Boolean=false;

        internal var _dragEnabled:Boolean=true;

        internal var allowDrag:Boolean;

        protected var draggingIntervalId:Number=0;

        protected var slidingIntervalId:Number=0;

        protected var arrowSlideIntervalId:Number=0;

        protected var isTween:Boolean=false;

        protected var tween:scaleform.clik.motion.Tween=null;

        protected var _currentFirstRenederer:uint=0;

        protected var distanceOfDragDelay:uint=10;

        public var slotImageHeight:Number=0;

        public var leftArrow:net.wg.gui.components.controls.SoundButton;

        public static var contentMargin:Number=0;

        internal var skippCall:Boolean=false;
    }
}
