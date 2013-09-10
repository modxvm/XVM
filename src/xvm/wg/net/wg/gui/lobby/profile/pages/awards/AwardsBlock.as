package net.wg.gui.lobby.profile.pages.awards 
{
    import flash.display.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.constants.*;
    
    public class AwardsBlock extends net.wg.gui.lobby.profile.components.AwardsTileListBlock
    {
        public function AwardsBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            tileList.direction = scaleform.clik.constants.DirectionMode.VERTICAL;
            tileList.columnCount = 12;
            return;
        }

        protected override function applyLabel():void
        {
            textField.htmlText = this._showProgress ? labelText + "<font color=\'#7b7969\' size=\'14\'> (" + this._currentCount + "/" + this._totalCount + ")</font>" : labelText;
            return;
        }

        public function get showProgress():Boolean
        {
            return this._showProgress;
        }

        public function set showProgress(arg1:Boolean):void
        {
            this._showProgress = arg1;
            invalidate(LABEL_INV);
            return;
        }

        protected override function applySizeChanges():void
        {
            var loc1:*=Math.round(tileList.y + tileList.height + BG_PADDING);
            this.background.y = Math.round(loc1 - this.background.height);
            _height = loc1;
            return;
        }

        public function set totalCount(arg1:uint):void
        {
            this._totalCount = arg1;
            invalidate(LABEL_INV);
            return;
        }

        public function set currentCount(arg1:uint):void
        {
            this._currentCount = arg1;
            invalidate(LABEL_INV);
            return;
        }

        internal static const BG_PADDING:uint=28;

        public var background:flash.display.MovieClip;

        internal var _showProgress:Boolean=true;

        internal var _currentCount:uint;

        protected var _totalCount:uint;
    }
}
