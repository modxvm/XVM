package net.wg.gui.lobby.fortifications.utils.impl
{
    import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.text.TextFormatAlign;
    import flash.text.TextFormat;
    import net.wg.utils.IUtils;
    import net.wg.utils.IDateTime;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Time;
    import net.wg.gui.components.controls.TimeNumericStepper;
    
    public class FortCommonUtils extends Object implements IFortCommonUtils
    {
        
        public function FortCommonUtils()
        {
            super();
        }
        
        private static var ms_instance:IFortCommonUtils = null;
        
        public static function get instance() : IFortCommonUtils
        {
            if(ms_instance == null)
            {
                ms_instance = new FortCommonUtils();
            }
            return ms_instance;
        }
        
        public function getFunctionalState(param1:FortModeVO) : Number
        {
            return (Number(param1.isEntering) << 1) || (Number(param1.isTutorial));
        }
        
        public function fadeSomeElementSimply(param1:Boolean, param2:Boolean, param3:DisplayObject) : void
        {
            if(param2)
            {
                if(param1)
                {
                    App.utils.tweenAnimator.addFadeInAnim(param3,null);
                }
                else
                {
                    App.utils.tweenAnimator.addFadeOutAnim(param3,null);
                }
            }
            else
            {
                param3.visible = param1;
            }
        }
        
        public function moveElementSimply(param1:Boolean, param2:Number, param3:DisplayObject) : void
        {
            if(param1)
            {
                App.utils.tweenAnimator.addMoveDownAnim(param3,param2,null);
            }
            else
            {
                App.utils.tweenAnimator.addMoveUpAnim(param3,param2,null);
            }
        }
        
        public function changeTextAlign(param1:TextField, param2:String) : void
        {
            var _loc3_:Array = [TextFormatAlign.LEFT,TextFormatAlign.CENTER,TextFormatAlign.RIGHT,TextFormatAlign.JUSTIFY];
            App.utils.asserter.assert(!(_loc3_.indexOf(param2) == -1),"unknown align value: " + param2);
            var _loc4_:TextFormat = param1.getTextFormat();
            _loc4_.align = param2;
            param1.setTextFormat(_loc4_);
        }
        
        public function getNextHourText(param1:int) : String
        {
            var _loc7_:* = false;
            var _loc8_:String = null;
            var _loc2_:IUtils = App.utils;
            var _loc3_:IDateTime = _loc2_.dateTime;
            var _loc4_:String = Values.EMPTY_STR;
            var _loc5_:int = param1 + 1;
            if(param1 == Time.HOURS_IN_DAY - 1)
            {
                _loc5_ = 0;
            }
            var _loc6_:String = Values.EMPTY_STR;
            if(_loc2_.isTwelveHoursFormatS())
            {
                _loc6_ = _loc2_.intToStringWithPrefixPaternS(_loc3_.convertToTwelveHourFormat(_loc5_),Time.COUNT_SYMBOLS_WITH_PREFIX,Time.PREFIX);
                _loc7_ = _loc5_ < Time.HOURS_IN_DAY >> 1;
                _loc8_ = _loc7_?Time.AM:Time.PM;
                _loc4_ = _loc6_ + Values.SPACE_STR + _loc8_;
            }
            else
            {
                _loc6_ = _loc2_.intToStringWithPrefixPaternS(_loc5_,Time.COUNT_SYMBOLS_WITH_PREFIX,Time.PREFIX);
                _loc4_ = _loc6_ + TimeNumericStepper.DELIMITER + TimeNumericStepper.DEFAULT_MINUTES;
            }
            return _loc4_;
        }
    }
}
