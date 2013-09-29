package scaleform.clik.core 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.managers.*;
    import scaleform.gfx.*;
    
    public dynamic class CLIK extends Object
    {
        public function CLIK()
        {
            super();
            return;
        }

        public static function initialize(arg1:flash.display.Stage, arg2:scaleform.clik.core.UIComponent):void
        {
            if (initialized) 
            {
                return;
            }
            scaleform.clik.core.CLIK.stage = arg1;
            scaleform.gfx.Extensions.enabled = true;
            initialized = true;
            scaleform.clik.managers.FocusHandler.init(arg1, arg2);
            scaleform.clik.managers.PopUpManager.init(arg1);
            initQueue = new flash.utils.Dictionary(true);
            validDictIndices = new Vector.<uint>();
            return;
        }

        public static function getTargetPathFor(arg1:flash.display.DisplayObjectContainer):String
        {
            var loc1:*=null;
            if (!arg1.parent) 
            {
                return arg1.name;
            }
            loc1 = arg1.name;
            return getTargetPathImpl(arg1.parent as flash.display.DisplayObjectContainer, loc1);
        }

        public static function queueInitCallback(arg1:scaleform.clik.core.UIComponent):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=getTargetPathFor(arg1);
            if (useImmediateCallbacks || firingInitCallbacks) 
            {
                scaleform.gfx.Extensions.CLIK_addedToStageCallback(arg1.name, loc1, arg1);
            }
            else 
            {
                loc2 = loc1.split(".");
                loc3 = (loc2.length - 1);
                if ((loc4 = initQueue[loc3]) == null) 
                {
                    loc4 = new flash.utils.Dictionary(true);
                    initQueue[loc3] = loc4;
                    validDictIndices.push(loc3);
                    if (validDictIndices.length > 1) 
                    {
                        validDictIndices.sort(sortFunc);
                    }
                }
                loc4[arg1] = loc1;
                if (!isInitListenerActive) 
                {
                    isInitListenerActive = true;
                    stage.addEventListener(flash.events.Event.EXIT_FRAME, fireInitCallback, false, 0, true);
                }
            }
            return;
        }

        protected static function fireInitCallback(arg1:flash.events.Event):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            firingInitCallbacks = true;
            stage.removeEventListener(flash.events.Event.EXIT_FRAME, fireInitCallback, false);
            isInitListenerActive = false;
            while (loc1 < validDictIndices.length) 
            {
                loc2 = validDictIndices[loc1];
                loc3 = initQueue[loc2] as flash.utils.Dictionary;
                var loc6:*=0;
                var loc7:*=loc3;
                for (loc4 in loc7) 
                {
                    loc5 = loc4 as scaleform.clik.core.UIComponent;
                    scaleform.gfx.Extensions.CLIK_addedToStageCallback(loc5.name, loc3[loc5], loc5);
                    loc3[loc5] = null;
                }
                ++loc1;
            }
            validDictIndices.length = 0;
            clearQueue();
            firingInitCallbacks = false;
            return;
        }

        protected static function clearQueue():void
        {
            var loc1:*=undefined;
            var loc2:*=0;
            var loc3:*=initQueue;
            for (loc1 in loc3) 
            {
                initQueue[loc1] = null;
            }
            return;
        }

        protected static function sortFunc(arg1:uint, arg2:uint):Number
        {
            if (arg1 < arg2) 
            {
                return -1;
            }
            if (arg1 > arg2) 
            {
                return 1;
            }
            return 0;
        }

        protected static function getTargetPathImpl(arg1:flash.display.DisplayObjectContainer, arg2:String=""):String
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return arg2;
            }
            loc1 = arg1.name ? arg1.name + "." : "";
            arg2 = loc1 + arg2;
            return getTargetPathImpl(arg1.parent as flash.display.DisplayObjectContainer, arg2);
        }

        
        {
            initialized = false;
            disableNullFocusMoves = false;
            disableDynamicTextFieldFocus = false;
            disableTextFieldToNullFocusMoves = true;
            useImmediateCallbacks = false;
            isInitListenerActive = false;
            firingInitCallbacks = false;
        }

        public static var stage:flash.display.Stage;

        public static var initialized:Boolean=false;

        public static var disableNullFocusMoves:Boolean=false;

        public static var disableDynamicTextFieldFocus:Boolean=false;

        public static var disableTextFieldToNullFocusMoves:Boolean=true;

        public static var useImmediateCallbacks:Boolean=false;

        protected static var isInitListenerActive:Boolean=false;

        protected static var firingInitCallbacks:Boolean=false;

        protected static var initQueue:flash.utils.Dictionary;

        protected static var validDictIndices:__AS3__.vec.Vector.<uint>;
    }
}
