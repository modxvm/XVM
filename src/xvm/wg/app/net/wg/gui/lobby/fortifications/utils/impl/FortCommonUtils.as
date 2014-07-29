package net.wg.gui.lobby.fortifications.utils.impl
{
    import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.text.TextFormatAlign;
    import flash.text.TextFormat;
    
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
        
        public function getFunctionalState(param1:Boolean, param2:Boolean) : Number
        {
            return (Number(param1) << 1) || (Number(param2));
        }
        
        public function fadeSomeElementSimply(param1:Boolean, param2:Boolean, param3:DisplayObject) : void
        {
            if(param2)
            {
                if(param1)
                {
                    TweenAnimator.instance.addFadeInAnim(param3,null);
                }
                else
                {
                    TweenAnimator.instance.addFadeOutAnim(param3,null);
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
                TweenAnimator.instance.addMoveDownAnim(param3,param2,null);
            }
            else
            {
                TweenAnimator.instance.addMoveUpAnim(param3,param2,null);
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
    }
}
