package net.wg.gui.lobby.storage.categories.cards
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import flash.display.Graphics;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import net.wg.utils.StageSizeBoundaries;
    import fl.motion.easing.Cubic;
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ICommons;

    public class BlueprintsCard extends UIComponentEx implements IStageSizeDependComponent, IScrollerItemRenderer, ISoundable
    {

        private static const FIRST_ANIMATION_DURATION:Number = 200;

        private static const ROLL_OVER_ANIMATION_DELAY:int = 0;

        private static const SELL_BUTTON_MIN_WIDTH:int = 90;

        private static const BORDER_OFFSET:Number = 0.5;

        private static const BORDER_CORNER_RADIUS:int = 2;

        private static const BORDER_SIZE_CORRECTION:Number = 2.5;

        private static const OVERLAY_SIZE_CORRECTION:int = 3;

        private static const DESCRIPTION_OFFSET_Y:int = 5;

        private static const FRAGMENTS_COUNT_OFFSET_Y:int = 4;

        private static const BG_SHINE_OFFSET_X:int = -1;

        private static const PADDINGS_SMALL:Rectangle = new Rectangle(12,12,260 - 8 - 12 - 2,171 - 8 - 12 - 2);

        private static const IMAGE_SIZE_SMALL:Rectangle = new Rectangle(0,0,144,108);

        private static const PADDINGS_BIG:Rectangle = new Rectangle(12,12,312 - 14 - 12,205 - 11 - 12);

        private static const IMAGE_SIZE_BIG:Rectangle = new Rectangle(0,0,180,135);

        private static const BG_STATE_BIG:String = "big";

        private static const BG_STATE_SMALL:String = "small";

        public var titleTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var image:Image = null;

        public var bgShine:MovieClip = null;

        public var plus:MovieClip = null;

        public var bgImage:MovieClip = null;

        public var fragmentsCountTF:TextField = null;

        public var treeIcon:MovieClip = null;

        public var navigateButton:SoundButtonEx = null;

        public var fragmentsCostTF:TextField = null;

        private var _data:BlueprintCardVO = null;

        private var _container:Sprite = null;

        private var _overlay:Sprite = null;

        private var _tweens:Vector.<Tween>;

        private var _isOver:Boolean = false;

        private var _index:uint = 0;

        private var _useSmallImage:Boolean = false;

        public function BlueprintsCard()
        {
            this._tweens = new Vector.<Tween>(0);
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            alpha = 0;
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(dispatchEvent);
            if(App.soundMgr != null)
            {
                App.soundMgr.removeSoundHdlrs(this);
            }
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this._data = null;
            this.navigateButton.dispose();
            this.navigateButton = null;
            this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.image.dispose();
            this.image = null;
            this.bgImage = null;
            this.titleTF = null;
            this.descriptionTF = null;
            this.disposeTweens();
            this._tweens = null;
            this._container = null;
            this._overlay = null;
            this.fragmentsCountTF = null;
            this.bgShine = null;
            this.plus = null;
            this.treeIcon = null;
            this.fragmentsCostTF = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = true;
            this._overlay = new Sprite();
            this._overlay.name = "overlay";
            this._overlay.alpha = 0;
            hitArea = this._overlay;
            this._container = new Sprite();
            this._container.name = "container";
            this._container.addChild(this.titleTF);
            this._container.addChild(this.descriptionTF);
            this._container.mouseEnabled = this._container.mouseChildren = false;
            this.titleTF.multiline = true;
            this.titleTF.wordWrap = true;
            this.titleTF.autoSize = TextFieldAutoSize.LEFT;
            this.descriptionTF.alpha = 0;
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
            this.bgShine.mouseEnabled = this.bgShine.mouseChildren = false;
            this.bgImage.mouseEnabled = this.bgImage.mouseChildren = false;
            this.plus.mouseEnabled = this.plus.mouseChildren = false;
            this.image.mouseEnabled = this.image.mouseChildren = false;
            this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.navigateButton.alpha = 0;
            this.navigateButton.minWidth = SELL_BUTTON_MIN_WIDTH;
            this.navigateButton.autoSize = TextFieldAutoSize.RIGHT;
            this.navigateButton.label = STORAGE.BLUEPRINTS_BUTTONLABEL_GOTOBLUEPRINTS;
            this.treeIcon.mouseEnabled = this.treeIcon.mouseChildren = false;
            this.fragmentsCountTF.mouseEnabled = false;
            this.fragmentsCostTF.mouseEnabled = false;
            addChild(this._container);
            addChildAt(this._overlay,0);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            if(App.soundMgr)
            {
                App.soundMgr.addSoundsHdlrs(this);
            }
            alpha = 1;
        }

        override protected function draw() : void
        {
            var _loc1_:Graphics = null;
            var _loc2_:Rectangle = null;
            var _loc3_:Rectangle = null;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.titleTF.htmlText = this._data.title;
                this.descriptionTF.htmlText = this._data.description;
                this.fragmentsCountTF.htmlText = this._data.fragmentsProgress;
                this.fragmentsCostTF.htmlText = this._data.fragmentsCostText;
                this.treeIcon.visible = this._data.availableToUnlock;
                this.bgShine.visible = this._data.hasDiscount;
                this.plus.visible = this._data.convertAvailable;
                invalidateSize();
            }
            if(this._data && isInvalid(InvalidationType.SIZE))
            {
                if(this.image.source != this._data.image)
                {
                    this.image.alpha = 0;
                    this.image.sourceAlt = this._data.imageAlt;
                    this.image.source = this._data.image;
                }
                _loc1_ = graphics;
                _loc1_.clear();
                _loc1_.lineStyle(1,16777215,0.15);
                _loc1_.beginFill(0,0.25);
                _loc1_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_SIZE_CORRECTION,height - BORDER_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
                _loc1_.endFill();
                _loc1_ = this._overlay.graphics;
                _loc1_.clear();
                _loc1_.beginFill(1973272);
                _loc1_.drawRoundRect(1,1,width - OVERLAY_SIZE_CORRECTION,height - OVERLAY_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
                _loc1_.endFill();
                _loc2_ = this._useSmallImage?PADDINGS_SMALL:PADDINGS_BIG;
                _loc3_ = this._useSmallImage?IMAGE_SIZE_SMALL:IMAGE_SIZE_BIG;
                this.bgImage.gotoAndStop(this._useSmallImage?BG_STATE_SMALL:BG_STATE_BIG);
                if(_baseDisposed)
                {
                    return;
                }
                this.titleTF.x = _loc2_.left | 0;
                this.titleTF.width = _loc2_.width | 0;
                if(!this._isOver)
                {
                    this._container.y = _loc2_.bottom - this.fragmentsCountTF.height - this.titleTF.height | 0;
                }
                this.descriptionTF.x = _loc2_.left | 0;
                this.descriptionTF.y = this.titleTF.y + this.titleTF.height + DESCRIPTION_OFFSET_Y | 0;
                this.descriptionTF.width = _loc2_.width >> 0;
                this.navigateButton.x = _loc2_.right - this.navigateButton.width >> 0;
                this.navigateButton.y = _loc2_.bottom - this.navigateButton.height >> 0;
                this.onImageChange();
                this.treeIcon.x = _loc2_.right - this.treeIcon.width | 0;
                this.treeIcon.y = _loc2_.bottom - this.treeIcon.height | 0;
                this.bgShine.x = width - this.bgShine.width + BG_SHINE_OFFSET_X | 0;
                this.bgShine.y = 0;
                this.image.width = _loc3_.width | 0;
                this.image.height = _loc3_.height | 0;
                this.image.x = width - this.image.width >> 1;
                this.fragmentsCountTF.x = _loc2_.right - this.fragmentsCountTF.width | 0;
                this.fragmentsCountTF.y = _loc2_.top - FRAGMENTS_COUNT_OFFSET_Y | 0;
                this.fragmentsCostTF.x = _loc2_.left | 0;
                this.fragmentsCostTF.y = _loc2_.bottom - this.fragmentsCostTF.height >> 0;
                if(this.plus.visible)
                {
                    this.plus.x = width - this.plus.width >> 1;
                }
            }
        }

        public function canPlaySound(param1:String) : Boolean
        {
            return true;
        }

        public function getSoundId() : String
        {
            return null;
        }

        public function getSoundType() : String
        {
            return null;
        }

        public function measureSize(param1:Point = null) : Point
        {
            return null;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            this._useSmallImage = param1 < StageSizeBoundaries.WIDTH_1600;
            invalidateSize();
        }

        private function startRollOverTweens() : void
        {
            var _loc1_:* = height - this._container.height >> 1;
            if(this.navigateButton.visible && _loc1_ + this._container.height > this.navigateButton.y)
            {
                _loc1_ = this.navigateButton.y - this._container.height >> 1;
            }
            this.disposeTweens();
            this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":1},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":0.2},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY,
                "ease":Cubic.easeInOut
            }),new Tween(0.5 * FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":1},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY + 0.5 * FIRST_ANIMATION_DURATION,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.navigateButton,{"alpha":1},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.bgImage,{"alpha":0.2},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY,
                "ease":Cubic.easeInOut
            }));
            if(this.treeIcon.visible)
            {
                this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.treeIcon,{"alpha":0},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY,
                    "ease":Cubic.easeInOut
                }));
            }
        }

        private function startRollOutTweens() : void
        {
            this.disposeTweens();
            var _loc1_:int = this._useSmallImage?PADDINGS_SMALL.bottom:PADDINGS_BIG.bottom;
            var _loc2_:* = _loc1_ - this.fragmentsCostTF.height - this.titleTF.height | 0;
            this._tweens.push(new Tween(0.5 & FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":0},{
                "fastTransform":false,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc2_},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":0},{
                "fastTransform":false,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{
                "fastTransform":false,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.navigateButton,{"alpha":0},{
                "fastTransform":false,
                "ease":Cubic.easeInOut
            }),new Tween(FIRST_ANIMATION_DURATION,this.bgImage,{"alpha":1},{
                "fastTransform":false,
                "ease":Cubic.easeInOut
            }));
            if(this.treeIcon.visible)
            {
                this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.treeIcon,{"alpha":1},{
                    "fastTransform":false,
                    "ease":Cubic.easeInOut
                }));
            }
        }

        private function animateImage() : void
        {
            if(!this._isOver && this.image.alpha != 1)
            {
                this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false}));
            }
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }

        private function onImageChange() : void
        {
            if(this.image.ready)
            {
                this.animateImage();
                invalidateSize();
            }
        }

        public function get index() : uint
        {
            return this._index;
        }

        public function set index(param1:uint) : void
        {
            this._index = param1;
        }

        public function get owner() : UIComponent
        {
            return null;
        }

        public function set owner(param1:UIComponent) : void
        {
        }

        public function get selected() : Boolean
        {
            return false;
        }

        public function set selected(param1:Boolean) : void
        {
        }

        public function get data() : Object
        {
            return this._data;
        }

        public function set data(param1:Object) : void
        {
            var _loc2_:BlueprintCardVO = param1 as BlueprintCardVO;
            if(this._data && this._data.isEqual(_loc2_))
            {
                return;
            }
            this._data = _loc2_;
            invalidateData();
        }

        public function set tooltipDecorator(param1:ITooltipMgr) : void
        {
        }

        public function set isViewPortEnabled(param1:Boolean) : void
        {
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this._isOver = true;
            this.startRollOverTweens();
            App.utils.scheduler.scheduleTask(dispatchEvent,ROLL_OVER_ANIMATION_DELAY,new CardEvent(CardEvent.PLAY_INFO_SOUND));
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._isOver = false;
            this.startRollOutTweens();
            App.utils.scheduler.cancelTask(dispatchEvent);
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            var _loc2_:ICommons = App.utils.commons;
            if(_loc2_.isRightButton(param1))
            {
                if(this._data.contextMenuId)
                {
                    dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,this._data));
                }
            }
            else
            {
                dispatchEvent(new CardEvent(CardEvent.SELL,this._data));
            }
        }

        private function onImageChangeHandler(param1:Event = null) : void
        {
            this.onImageChange();
        }
    }
}
