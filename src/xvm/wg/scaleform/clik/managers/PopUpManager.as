package scaleform.clik.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.utils.*;
    import scaleform.gfx.*;
    
    public class PopUpManager extends Object
    {
        public function PopUpManager()
        {
            super();
            return;
        }

        public static function init(arg1:flash.display.Stage):void
        {
            if (initialized) 
            {
                return;
            }
            scaleform.clik.managers.PopUpManager._stage = arg1;
            _defaultPopupCanvas = new flash.display.MovieClip();
            _defaultPopupCanvas.addEventListener(flash.events.Event.REMOVED, handleRemovePopup, false, 0, true);
            _stage.addChild(_defaultPopupCanvas);
            initialized = true;
            return;
        }

        public static function get popupCanvas():flash.display.MovieClip
        {
            return _defaultPopupCanvas;
        }

        public static function show(arg1:flash.display.DisplayObject, arg2:Number=0, arg3:Number=0, arg4:flash.display.DisplayObjectContainer=null):void
        {
            if (!_stage) 
            {
                trace("PopUpManager has not been initialized. Automatic initialization has not occured or has failed; call PopUpManager.init() manually.");
                return;
            }
            var loc1:*;
            (loc1 = App.utils.events).disableDisposingForObj(arg1);
            if (arg1.parent) 
            {
                arg1.parent.removeChild(arg1);
            }
            handleStageAddedEvent(null);
            _defaultPopupCanvas.addChild(arg1);
            loc1.enableDisposingForObj(arg1);
            if (!arg4) 
            {
                arg4 = _stage;
            }
            var loc2:*=new flash.geom.Point(arg2, arg3);
            loc2 = arg4.localToGlobal(loc2);
            arg1.x = loc2.x;
            arg1.y = loc2.y;
            _stage.setChildIndex(_defaultPopupCanvas, (_stage.numChildren - 1));
            _stage.addEventListener(flash.events.Event.ADDED, scaleform.clik.managers.PopUpManager.handleStageAddedEvent, false, 0, true);
            return;
        }

        public static function showModal(arg1:flash.display.Sprite, arg2:Number=0, arg3:Number=0, arg4:flash.display.Sprite=null, arg5:uint=0, arg6:flash.display.Sprite=null):void
        {
            if (!_stage) 
            {
                trace("PopUpManager has not been initialized. Automatic initialization has not occured or has failed; call PopUpManager.init() manually.");
                return;
            }
            if (_modalMc) 
            {
                _defaultPopupCanvas.removeChild(_modalMc);
            }
            if (arg1 == null) 
            {
                return;
            }
            if (arg4 == null) 
            {
                (arg4 = new flash.display.Sprite()).graphics.lineStyle(0, 16777215, 0);
                arg4.graphics.beginFill(16777215, 0);
                arg4.graphics.drawRect(0, 0, _stage.stageWidth, _stage.stageHeight);
                arg4.graphics.endFill();
            }
            _modalMc = arg1;
            _modalBg = arg4;
            _modalMc.x = arg2;
            _modalMc.y = arg3;
            _defaultPopupCanvas.addChild(_modalBg);
            _defaultPopupCanvas.addChild(_modalMc);
            scaleform.clik.managers.FocusHandler.getInstance().setFocus(arg6, arg5, false);
            scaleform.gfx.FocusManager.setModalClip(_modalMc, arg5);
            _modalMc.addEventListener(flash.events.Event.REMOVED_FROM_STAGE, handleRemoveModalMc, false, 0, true);
            _stage.addEventListener(flash.events.Event.ADDED, scaleform.clik.managers.PopUpManager.handleStageAddedEvent, false, 0, true);
            return;
        }

        protected static function handleStageAddedEvent(arg1:flash.events.Event):void
        {
            _stage.setChildIndex(_defaultPopupCanvas, (_stage.numChildren - 1));
            return;
        }

        protected static function handleRemovePopup(arg1:flash.events.Event):void
        {
            removeAddedToStageListener();
            return;
        }

        protected static function handleRemoveModalMc(arg1:flash.events.Event):void
        {
            _modalBg.removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, handleRemoveModalMc, false);
            if (_modalBg) 
            {
                _defaultPopupCanvas.removeChild(_modalBg);
            }
            _modalMc = null;
            _modalBg = null;
            scaleform.gfx.FocusManager.setModalClip(null);
            removeAddedToStageListener();
            return;
        }

        protected static function removeAddedToStageListener():void
        {
            if (_defaultPopupCanvas.numChildren == 0 && _modalMc == null) 
            {
                _stage.removeEventListener(flash.events.Event.ADDED, scaleform.clik.managers.PopUpManager.handleStageAddedEvent, false);
            }
            return;
        }

        
        {
            initialized = false;
        }

        protected static var initialized:Boolean=false;

        protected static var _stage:flash.display.Stage;

        protected static var _defaultPopupCanvas:flash.display.MovieClip;

        protected static var _modalMc:flash.display.Sprite;

        protected static var _modalBg:flash.display.Sprite;
    }
}
