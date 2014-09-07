package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.gui.lobby.fortifications.interfaces.IDirectionModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportModeClient;
    import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.BattleNotifierVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import net.wg.gui.lobby.fortifications.data.FunctionalStates;
    import net.wg.utils.ITweenAnimator;
    
    public class FortBattleNotifier extends UIComponent implements IPopOverCaller, IDirectionModeClient, ITransportModeClient, ITweenAnimatorHandler
    {
        
        public function FortBattleNotifier()
        {
            super();
        }
        
        private static var NORMAL:String = "normal";
        
        private static var HAS_ACTIVE_BATTLES:String = "hasActiveBattles";
        
        private static var OVER_POSTFIX:String = "_hover";
        
        private static var OUT_POSTFIX:String = "_out";
        
        public var typeMC:MovieClip;
        
        public var dotMC:MovieClip;
        
        private var data:BattleNotifierVO = null;
        
        private var isInHoverState:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.CLICK,this.handleClick);
            addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
            mouseChildren = false;
            buttonMode = true;
            useHandCursor = true;
        }
        
        public function setData(param1:BattleNotifierVO) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            var _loc1_:String = null;
            buttonMode = true;
            useHandCursor = true;
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.data)
                {
                    this.visible = true;
                    this.updateHover();
                    _loc1_ = this.data.hasActiveBattles?HAS_ACTIVE_BATTLES:NORMAL;
                    gotoAndPlay(_loc1_);
                }
                else
                {
                    this.visible = false;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.handleClick);
            removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            this.typeMC = null;
            this.dotMC = null;
            App.utils.tweenAnimator.removeAnims(this);
        }
        
        private function handleClick(param1:MouseEvent) : void
        {
            var _loc2_:Point = null;
            App.toolTipMgr.hide();
            if(this.data)
            {
                _loc2_ = localToGlobal(new Point(this.x,this.y));
                App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_BATTLE_DIRECTION_POPOVER_ALIAS,this.data.direction);
                this.data.hasActiveBattles = false;
                invalidateData();
            }
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this;
        }
        
        public function updateTransportMode(param1:FortModeVO) : void
        {
            this.updateMode(param1);
        }
        
        private function updateMode(param1:FortModeVO) : void
        {
            switch(FortCommonUtils.instance.getFunctionalState(param1))
            {
                case FunctionalStates.ENTER:
                    this.showNotifier(false);
                    break;
                case FunctionalStates.LEAVE:
                    this.showNotifier(true);
                    break;
            }
        }
        
        public function updateDirectionsMode(param1:FortModeVO) : void
        {
            this.updateMode(param1);
        }
        
        private function showNotifier(param1:Boolean) : void
        {
            var _loc2_:ITweenAnimator = null;
            if(this.data)
            {
                _loc2_ = App.utils.tweenAnimator;
                if(_loc2_ != null)
                {
                    _loc2_.removeAnims(this);
                    if(param1)
                    {
                        _loc2_.addFadeInAnim(this,this);
                    }
                    else
                    {
                        _loc2_.addFadeOutAnim(this,this);
                    }
                }
            }
        }
        
        public function onComplete() : void
        {
        }
        
        private function overHandler(param1:MouseEvent) : void
        {
            if((this.data) && (this.data.tooltip))
            {
                App.toolTipMgr.showComplex(this.data.tooltip);
            }
            this.isInHoverState = true;
            this.updateHover();
        }
        
        private function outHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            this.isInHoverState = false;
            this.updateHover();
        }
        
        private function updateHover() : void
        {
            if(this.data)
            {
                this.typeMC.gotoAndPlay(this.data.battleType + (this.isInHoverState?OVER_POSTFIX:OUT_POSTFIX));
                this.dotMC.gotoAndPlay(this.isInHoverState?OVER_POSTFIX:OUT_POSTFIX);
            }
        }
    }
}
