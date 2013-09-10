package scaleform.gfx 
{
    import flash.display.*;
    
    public final class FocusManager extends Object
    {
        public function FocusManager()
        {
            super();
            return;
        }

        public static function set alwaysEnableArrowKeys(arg1:Boolean):void
        {
            return;
        }

        public static function get alwaysEnableArrowKeys():Boolean
        {
            return false;
        }

        public static function set disableFocusKeys(arg1:Boolean):void
        {
            return;
        }

        public static function get disableFocusKeys():Boolean
        {
            return false;
        }

        public static function moveFocus(arg1:String, arg2:flash.display.InteractiveObject=null, arg3:Boolean=false, arg4:uint=0):flash.display.InteractiveObject
        {
            return null;
        }

        public static function findFocus(arg1:String, arg2:flash.display.DisplayObjectContainer=null, arg3:Boolean=false, arg4:flash.display.InteractiveObject=null, arg5:Boolean=false, arg6:uint=0):flash.display.InteractiveObject
        {
            return null;
        }

        public static function setFocus(arg1:flash.display.InteractiveObject, arg2:uint=0):void
        {
            trace("FocusManager.setFocus is only usable with GFx. Use stage.focus property in Flash.");
            return;
        }

        public static function getFocus(arg1:uint=0):flash.display.InteractiveObject
        {
            trace("FocusManager.getFocus is only usable with GFx. Use stage.focus property in Flash.");
            return null;
        }

        public static function get numFocusGroups():uint
        {
            return 1;
        }

        public static function setFocusGroupMask(arg1:flash.display.InteractiveObject, arg2:uint):void
        {
            return;
        }

        public static function getFocusGroupMask(arg1:flash.display.InteractiveObject):uint
        {
            return 1;
        }

        public static function setControllerFocusGroup(arg1:uint, arg2:uint):Boolean
        {
            return false;
        }

        public static function getControllerFocusGroup(arg1:uint):uint
        {
            return 0;
        }

        public static function getControllerMaskByFocusGroup(arg1:uint):uint
        {
            return 0;
        }

        public static function getModalClip(arg1:uint=0):flash.display.Sprite
        {
            return null;
        }

        public static function setModalClip(arg1:flash.display.Sprite, arg2:uint=0):void
        {
            return;
        }
    }
}
