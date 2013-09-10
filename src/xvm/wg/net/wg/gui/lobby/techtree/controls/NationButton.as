package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.constants.*;
    
    public class NationButton extends net.wg.gui.components.controls.SoundButton
    {
        public function NationButton()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip, false);
            removeEventListener(flash.events.MouseEvent.CLICK, hideTooltip, false);
            super.dispose();
            return;
        }

        protected function defineSoundProps():void
        {
            soundId = net.wg.data.constants.SoundTypes.TAB;
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            this.defineSoundProps();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip, false, 0, true);
            addEventListener(flash.events.MouseEvent.CLICK, hideTooltip, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (!(_label == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.ico != null) 
                {
                    this.ico.gotoAndStop(_label);
                }
                if (this.icoAdd != null) 
                {
                    this.icoAdd.gotoAndStop(_label);
                }
            }
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (!_selected) 
            {
                super.handleMouseRelease(arg1);
            }
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            if (!(_label == null) && !_selected) 
            {
                if (App.toolTipMgr != null) 
                {
                    App.toolTipMgr.showComplex(new net.wg.gui.utils.ComplexTooltipHelper().addHeader(TOOLTIPS.techtreepage_nations(_label), true).make());
                }
            }
            return;
        }

        internal static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            if (App.toolTipMgr != null) 
            {
                App.toolTipMgr.hide();
            }
            return;
        }

        public var ico:flash.display.MovieClip;

        public var icoAdd:flash.display.MovieClip;
    }
}
