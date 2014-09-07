package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
    import flash.events.MouseEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.lobby.fortifications.data.DirectionVO;
    import flash.display.BlendMode;
    
    public class ConnectedDirctns extends UIComponent
    {
        
        public function ConnectedDirctns()
        {
            super();
            this.connectionAnimation.blendMode = BlendMode.ADD;
            this.connectionAnimation.visible = false;
        }
        
        public var leftDirection:DirectionCmp;
        
        public var rightDirection:DirectionCmp;
        
        public var connectionIcon:AnimatedIcon;
        
        public var connectionRoad:Sprite;
        
        public var connectionAnimation:MovieClip;
        
        private var model:ConnectedDirectionsVO;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.leftDirection.layout = DirectionCmp.LAYOUT_LEFT_RIGHT;
            this.leftDirection.disableLowLevelBuildings = true;
            this.rightDirection.layout = DirectionCmp.LAYOUT_RIGHT_LEFT;
            this.rightDirection.disableLowLevelBuildings = true;
            this.connectionIcon.addEventListener(MouseEvent.ROLL_OVER,this.iconOverHandler);
            this.connectionIcon.addEventListener(MouseEvent.ROLL_OUT,this.iconOutHandler);
        }
        
        private function iconOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function iconOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(this.model)
            {
                _loc2_ = new ComplexTooltipHelper().addHeader(this.model.connectionIconTTHeader).addBody(this.model.connectionIconTTBody).make();
                if(_loc2_.length > 0)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this.connectionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.iconOverHandler);
            this.connectionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.iconOutHandler);
            this.leftDirection.dispose();
            this.rightDirection.dispose();
            this.leftDirection = null;
            this.rightDirection = null;
            this.connectionIcon.dispose();
            this.connectionIcon = null;
            this.connectionRoad = null;
            this.connectionAnimation = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        public function setData(param1:ConnectedDirectionsVO) : void
        {
            this.model = param1;
            if(this.model)
            {
                this.setupDirection(this.leftDirection,this.model.leftDirection);
                this.setupDirection(this.rightDirection,this.model.rightDirection);
                this.connectionIcon.iconSource = this.model.connectionIcon;
            }
            else
            {
                this.setupDirection(this.leftDirection,null);
                this.setupDirection(this.rightDirection,null);
            }
            invalidateData();
        }
        
        public function showHideConnectedDirection(param1:Boolean) : void
        {
            this.rightDirection.visible = param1;
            this.connectionRoad.visible = param1;
            this.connectionIcon.visible = param1;
        }
        
        public function showHideConnectionAnimation(param1:Boolean) : void
        {
            if(param1)
            {
                this.connectionAnimation.gotoAndPlay(0);
                this.connectionAnimation.visible = true;
                this.connectionIcon.playFadeIn();
            }
            else
            {
                this.connectionAnimation.visible = false;
                this.connectionIcon.visible = false;
            }
        }
        
        private function setupDirection(param1:DirectionCmp, param2:DirectionVO) : void
        {
            if(param2)
            {
                param1.setData(param2);
                param1.visible = true;
            }
            else
            {
                param1.visible = false;
            }
        }
    }
}
