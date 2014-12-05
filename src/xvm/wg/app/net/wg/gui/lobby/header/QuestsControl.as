package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.QuestsControlMeta;
    import net.wg.infrastructure.base.meta.IQuestsControlMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.utils.IHelpLayout;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.header.vo.QuestsControlBtnVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ComponentEvent;
    import flash.text.TextFieldAutoSize;
    import org.idmedia.as3commons.util.StringUtils;
    
    public class QuestsControl extends QuestsControlMeta implements IQuestsControlMeta, IDAAPIModule, IHelpLayoutComponent
    {
        
        public function QuestsControl()
        {
            super();
        }
        
        private static var NEW:String = "New";
        
        public var bg:MovieClip = null;
        
        public var alertIcon:MovieClip = null;
        
        public var bagIcon:MovieClip = null;
        
        public var txtMessage:TextField = null;
        
        private var _disposed:Boolean = false;
        
        private var _isDAAPIInited:Boolean = false;
        
        private var _hasNew:Boolean = false;
        
        private var _helpLayout:DisplayObject = null;
        
        private var tooltipStr:String = "";
        
        private var additionalText:String = "";
        
        public function as_isShowAlertIcon(param1:Boolean, param2:Boolean) : void
        {
            this._hasNew = param2;
            this.alertIcon.visible = param1;
            invalidate(NEW);
        }
        
        public function as_isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        public function as_populate() : void
        {
            this._isDAAPIInited = true;
        }
        
        public function as_dispose() : void
        {
            try
            {
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
                dispose();
                this._disposed = true;
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
        }
        
        public function showHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Rectangle = new Rectangle(7,0,this.width,this.height - 2);
            var _loc3_:Object = _loc1_.getProps(_loc2_,LOBBY_HELP.HANGAR_QUESTSCONTROL,Directions.RIGHT);
            this._helpLayout = _loc1_.create(this.root,_loc3_,this);
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            _loc1_.destroy(this._helpLayout);
            this._helpLayout = null;
        }
        
        public function get disposed() : Boolean
        {
            return this._disposed;
        }
        
        public function get isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        override protected function onDispose() : void
        {
            this.tooltipStr = null;
            this.txtMessage = null;
            this.bagIcon = null;
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
            removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.additionalText = null;
            this._helpLayout = null;
            this.alertIcon = null;
            super.onDispose();
        }
        
        override protected function setData(param1:QuestsControlBtnVO) : void
        {
            this.label = param1.titleText;
            this.additionalText = param1.additionalText;
            this.txtMessage.htmlText = param1.additionalText;
            this.tooltipStr = param1.tooltip;
            param1.dispose();
            var param1:QuestsControlBtnVO = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
            addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.mouseChildren = false;
            this.bg.mouseEnabled = false;
            this.bg.mouseChildren = false;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            if(isInvalid(NEW))
            {
                setState("up");
            }
            if(isInvalid(InvalidationType.STATE))
            {
                if(_newFrame)
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if((focusIndicator) && (_newFocusIndicatorFrame))
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                updateAfterStateChange();
                dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
                invalidate(InvalidationType.DATA,InvalidationType.SIZE);
            }
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.txtMessage)
                {
                    this.txtMessage.htmlText = this.additionalText;
                }
                updateText();
            }
            if((isInvalid(InvalidationType.DATA)) && (textField))
            {
                textField.autoSize = TextFieldAutoSize.LEFT;
                this.txtMessage.autoSize = TextFieldAutoSize.LEFT;
                _loc1_ = Math.max(this.txtMessage.width,textField.width);
                hitMc.width = this.txtMessage.x - hitMc.x + _loc1_ ^ 0;
            }
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            var _loc1_:* = "new_";
            return this._hasNew?Vector.<String>([_loc1_]):statesDefault;
        }
        
        private function onPress(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            if(App.utils.commons.isLeftButton(param1))
            {
                showQuestsWindowS();
            }
        }
        
        private function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function showTooltip(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this.tooltipStr))
            {
                App.toolTipMgr.showComplex(this.tooltipStr);
            }
        }
    }
}
