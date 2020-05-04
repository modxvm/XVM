package net.wg.gui.battle.pveEvent.views.radialMenu
{
    import net.wg.infrastructure.base.meta.impl.EventRadialMenuMeta;
    import net.wg.infrastructure.base.meta.IEventRadialMenuMeta;
    import flash.text.TextField;
    import net.wg.gui.battle.pveEvent.views.radialMenu.components.RadialPaging;
    import net.wg.gui.battle.views.radialMenu.RadialButton;
    import scaleform.clik.motion.Tween;
    import scaleform.gfx.TextFieldEx;
    import net.wg.gui.battle.views.radialMenu.RadialMenu;
    import fl.motion.easing.Linear;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import flash.geom.Point;

    public class EventRadialMenu extends EventRadialMenuMeta implements IEventRadialMenuMeta
    {

        public static const DEFAULT_STATE:String = "default";

        public static const ALLY_STATE:String = "ally";

        public static const ENEMY_STATE:String = "enemy";

        private static const DEFAULT_SCALE:Number = 1;

        private static const CHANGE_ANIMATION_SCALE:Number = 0.9;

        private static const EVENT_BACK_ALPHA:Number = 0.45;

        private static const TWEEN_HALF_TIME:Number = 100;

        private static const EVENT_OFFSET_ANGLE:Number = 45;

        private static const EVENT_FIRST_ANGLE:Number = 225;

        private static const EVENT_POINT_RADIUS:int = 200;

        private static const EVENT_INTERNAL_MENU_RADIUS:int = 185;

        private static const ONE_PAGE:int = 1;

        public var chatTitleTF:TextField = null;

        public var alliesTF:TextField = null;

        public var allyNameTF:TextField = null;

        public var enemyNameTF:TextField = null;

        public var paging:RadialPaging = null;

        public var middleBtn:RadialButton = null;

        private var _targetDisplayName:String = null;

        private var _pageTween:Tween = null;

        private var _pageTweenObj:Object;

        private var _currentPage:int = 0;

        private var _pageCount:int = 0;

        private var _isInAnimation:Boolean = false;

        public function EventRadialMenu()
        {
            this._pageTweenObj = {"scale":DEFAULT_SCALE};
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            TextFieldEx.setTextAutoSize(this.allyNameTF,TextFieldEx.TEXTAUTOSZ_SHRINK);
            TextFieldEx.setTextAutoSize(this.enemyNameTF,TextFieldEx.TEXTAUTOSZ_SHRINK);
        }

        override protected function getButtons() : Vector.<RadialButton>
        {
            return new <RadialButton>[negativeBtn,toBaseBtn,helpBtn,this.middleBtn,reloadBtn,attackBtn,positiveBtn];
        }

        override protected function getButtonData(param1:Array, param2:uint) : Object
        {
            return param1[this._currentPage * buttonsCount + param2];
        }

        override protected function showWithName(param1:String, param2:Array, param3:Array, param4:String) : void
        {
            this._targetDisplayName = param4;
            this._currentPage = 0;
            var _loc5_:int = getStateData(param1).length;
            this._pageCount = int(_loc5_ / buttonsCount);
            show(param1,param2,param3);
        }

        override protected function configBG() : void
        {
            background.setBackgroundAlpha(EVENT_BACK_ALPHA);
        }

        override protected function onDispose() : void
        {
            super.onDispose();
            this.chatTitleTF = null;
            this.alliesTF = null;
            this.enemyNameTF = null;
            this.allyNameTF = null;
            this.middleBtn.dispose();
            this.middleBtn = null;
            this.paging.dispose();
            this.paging = null;
            if(this._pageTween != null)
            {
                this._pageTween.dispose();
                this._pageTween = null;
            }
            this._pageTweenObj = null;
        }

        override protected function updateData() : void
        {
            super.updateData();
            var _loc1_:String = this.state;
            var _loc2_:* = _loc1_ == DEFAULT_STATE;
            var _loc3_:* = _loc1_ == ALLY_STATE;
            var _loc4_:* = _loc1_ == ENEMY_STATE;
            if(_loc4_)
            {
                this.chatTitleTF.text = EVENT.RADIALMENU_CHATABOUT;
                this.enemyNameTF.text = this._targetDisplayName;
            }
            else
            {
                this.chatTitleTF.text = EVENT.RADIALMENU_CHATWITH;
                if(_loc2_)
                {
                    this.alliesTF.text = EVENT.RADIALMENU_ALLIES;
                }
                else if(_loc3_)
                {
                    this.allyNameTF.text = this._targetDisplayName;
                }
            }
            var _loc5_:* = this._pageCount > ONE_PAGE;
            if(_loc5_)
            {
                this.paging.nextPageTF.text = EVENT.RADIALMENU_NEXTPAGE;
                this.paging.setCurrentPage(this._currentPage);
            }
        }

        override protected function updateButton(param1:RadialButton, param2:Object) : void
        {
            var _loc4_:* = false;
            var _loc5_:String = null;
            var _loc6_:* = false;
            super.updateButton(param1,param2);
            var _loc3_:EventRadialButton = param1 as EventRadialButton;
            if(_loc3_ != null)
            {
                _loc4_ = param2 == null;
                _loc3_.setDisabledButton(_loc4_);
                if(!_loc4_)
                {
                    _loc5_ = this.state;
                    _loc3_.setRadialState(_loc5_);
                    _loc6_ = this._currentPage > 0;
                    _loc3_.setChatState(_loc6_);
                }
            }
        }

        override protected function selectButton(param1:RadialButton) : void
        {
            if((param1 as EventRadialButton).disabledButton)
            {
                return;
            }
            if(!param1.selected)
            {
                showHandCursorS();
            }
            super.selectButton(param1);
        }

        override protected function unSelectButton(param1:RadialButton) : void
        {
            if((param1 as EventRadialButton).disabledButton)
            {
                return;
            }
            super.unSelectButton(param1);
        }

        override protected function cancelButton(param1:RadialButton) : void
        {
            if((param1 as EventRadialButton).disabledButton)
            {
                return;
            }
            super.cancelButton(param1);
        }

        override protected function internalShow() : void
        {
            var _loc4_:* = false;
            super.internalShow();
            var _loc1_:String = this.state;
            var _loc2_:* = _loc1_ == DEFAULT_STATE;
            var _loc3_:* = _loc1_ == ALLY_STATE;
            _loc4_ = _loc1_ == ENEMY_STATE;
            this.chatTitleTF.visible = true;
            this.alliesTF.visible = _loc2_;
            this.allyNameTF.visible = _loc3_;
            this.enemyNameTF.visible = _loc4_;
            var _loc5_:* = this._pageCount > ONE_PAGE;
            this.paging.visible = _loc5_;
            this.setButtonsScale(DEFAULT_SCALE);
            this._isInAnimation = false;
        }

        override protected function internalHide() : void
        {
            super.internalHide();
            this.hideTextAndPage();
            if(this._pageTween != null)
            {
                this._pageTween.dispose();
                this._pageTween = null;
            }
        }

        override protected function updateButtons() : void
        {
            var _loc1_:RadialButton = null;
            var _loc2_:* = NaN;
            var _loc3_:uint = 0;
            while(_loc3_ < buttonsCount)
            {
                _loc1_ = buttons[_loc3_];
                _loc2_ = (EVENT_FIRST_ANGLE + _loc3_ * EVENT_OFFSET_ANGLE) % RadialMenu.CIRCLE_DEGREES;
                _loc1_.angle = _loc2_;
                _loc1_.visible = true;
                _loc3_++;
            }
        }

        override protected function action() : void
        {
            super.action();
            if(!isAction)
            {
                leaveRadialModeS();
            }
        }

        override protected function onHideFromSchedule() : void
        {
            this.hideTextAndPage();
        }

        private function hideTextAndPage() : void
        {
            this.chatTitleTF.visible = false;
            this.alliesTF.visible = false;
            this.enemyNameTF.visible = false;
            this.allyNameTF.visible = false;
            this.paging.visible = false;
        }

        private function nextPage() : void
        {
            if(this._pageCount <= ONE_PAGE)
            {
                return;
            }
            this._isInAnimation = true;
            var _loc1_:uint = 0;
            while(_loc1_ < buttonsCount)
            {
                this.cancelButton(buttons[_loc1_]);
                _loc1_++;
            }
            this._pageTweenObj.scale = DEFAULT_SCALE;
            this._pageTween = new Tween(TWEEN_HALF_TIME,this._pageTweenObj,{"scale":CHANGE_ANIMATION_SCALE},{
                "ease":Linear.easeIn,
                "onComplete":this.nextPageFadeIn
            });
            this._pageTween.onChange = this.pageFadeUpdate;
        }

        private function nextPageFadeIn() : void
        {
            this._currentPage = this._currentPage + 1;
            if(this._currentPage == this._pageCount)
            {
                this._currentPage = 0;
            }
            this.updateButtons();
            this.updateData();
            this.internalShow();
            this._pageTween = new Tween(TWEEN_HALF_TIME,this._pageTweenObj,{"scale":DEFAULT_SCALE},{
                "ease":Linear.easeIn,
                "onComplete":this.nextPageComplete
            });
            this._pageTween.onChange = this.pageFadeUpdate;
        }

        private function nextPageComplete() : void
        {
            this._isInAnimation = false;
            this._pageTween.dispose();
            this._pageTween = null;
            this.onMouseMove(null);
        }

        private function pageFadeUpdate() : void
        {
            this.setButtonsScale(this._pageTweenObj.scale);
        }

        private function setButtonsScale(param1:Number) : void
        {
            var _loc2_:int = this.buttonsCount;
            var _loc3_:Vector.<RadialButton> = this.buttons;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_[_loc4_].scaleX = param1;
                _loc3_[_loc4_].scaleY = param1;
                _loc4_++;
            }
        }

        override protected function onButtonMouseDown(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx && visible && !isAction && !this._isInAnimation)
            {
                if(MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON)
                {
                    this.nextPage();
                }
                else if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
                {
                    this.action();
                }
            }
        }

        override protected function onMouseMove(param1:MouseEvent) : void
        {
            var _loc2_:uint = 0;
            var _loc3_:Point = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:RadialButton = null;
            if(visible && !isAction && !this._isInAnimation)
            {
                _loc2_ = 0;
                _loc3_ = new Point(this.mouseX,this.mouseY);
                _loc4_ = _loc3_.x;
                _loc5_ = _loc3_.y;
                _loc6_ = Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_);
                if(_loc6_ > EVENT_INTERNAL_MENU_RADIUS)
                {
                    _loc7_ = Math.atan2(_loc5_,_loc4_);
                    _loc8_ = EVENT_POINT_RADIUS * Math.cos(_loc7_);
                    _loc9_ = EVENT_POINT_RADIUS * Math.sin(_loc7_);
                    _loc3_.x = _loc8_;
                    _loc3_.y = _loc9_;
                }
                if(_loc6_ > EVENT_INTERNAL_MENU_RADIUS)
                {
                    _loc3_ = this.localToGlobal(_loc3_);
                    while(_loc2_ < buttonsCount)
                    {
                        _loc10_ = buttons[_loc2_];
                        if(_loc10_.hitAreaSpr.hitTestPoint(_loc3_.x * scaleKoefX,_loc3_.y * scaleKoefY,true))
                        {
                            this.selectButton(_loc10_);
                        }
                        else
                        {
                            this.unSelectButton(_loc10_);
                        }
                        _loc2_++;
                    }
                }
                else
                {
                    while(_loc2_ < buttonsCount)
                    {
                        this.unSelectButton(buttons[_loc2_]);
                        _loc2_++;
                    }
                    hideHandCursorS();
                }
            }
        }

        override protected function onMouseWheel(param1:MouseEvent) : void
        {
        }
    }
}
