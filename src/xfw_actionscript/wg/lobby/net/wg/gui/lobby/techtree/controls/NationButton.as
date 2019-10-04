package net.wg.gui.lobby.techtree.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.geom.Rectangle;
    import flash.display.MovieClip;
    import net.wg.data.constants.SoundTypes;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.events.MouseEvent;

    public class NationButton extends SoundButtonEx
    {

        private static const ARROW_OFFEST:int = 12;

        private static const DEFAULT_CONTENT_SIZE:Rectangle = new Rectangle();

        public var borderStates:NationButtonStates;

        public var arrowMc:MovieClip;

        private var _flagScale:Number = 1;

        public function NationButton()
        {
            super();
        }

        override protected function preInitialize() : void
        {
            super.preInitialize();
            soundType = SoundTypes.TAB;
        }

        override protected function onDispose() : void
        {
            this.borderStates.dispose();
            this.borderStates = null;
            this.arrowMc = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:Rectangle = null;
            if(_baseDisposed)
            {
                return;
            }
            if(this.borderStates != null && isInvalid(InvalidationType.STATE))
            {
                if(StringUtils.isNotEmpty(_newFrame))
                {
                    App.utils.asserter.assert(_labelHash.hasOwnProperty(_newFrame),"Not found state " + _newFrame);
                    this.borderStates.gotoAndPlay(_newFrame);
                    if(_baseDisposed)
                    {
                        return;
                    }
                }
            }
            super.draw();
            if(_label != null && this.borderStates != null && isInvalid(InvalidationType.DATA))
            {
                this.borderStates.setIconState(_label);
                if(_baseDisposed)
                {
                    return;
                }
            }
            if(this.borderStates && isInvalid(InvalidationType.LAYOUT))
            {
                _loc1_ = this.borderStates.contentSize;
                this.borderStates.scaleX = (_originalWidth - _loc1_.width + this._flagScale * _loc1_.width) / _originalWidth;
                this.borderStates.scaleY = (_originalHeight - _loc1_.height + this._flagScale * _loc1_.height) / _originalHeight;
                if(this.arrowMc)
                {
                    this.arrowMc.x = (_loc1_.width * (1 + this._flagScale) >> 1) + ARROW_OFFEST;
                }
            }
        }

        override protected function showTooltip() : void
        {
            if(_label != null && !_selected && App.toolTipMgr != null)
            {
                App.toolTipMgr.showComplex(App.toolTipMgr.getNewFormatter().addHeader(TOOLTIPS.techtreepage_nations(_label),true).make());
            }
        }

        public function setFlagScale(param1:Number) : void
        {
            if(this._flagScale != param1)
            {
                this._flagScale = param1;
                invalidateLayout();
            }
        }

        public function get contentSize() : Rectangle
        {
            return this.borderStates?this.borderStates.contentSize:DEFAULT_CONTENT_SIZE;
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            if(!_selected)
            {
                super.handleMouseRelease(param1);
            }
        }
    }
}
