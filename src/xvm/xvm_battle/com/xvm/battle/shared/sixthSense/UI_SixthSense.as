/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.sixthSense
{
    import com.greensock.*;
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.wg.*;
    import flash.events.*;

    public class UI_SixthSense extends sixthSenseUI
    {
        private var _loader:ImageXVM;
        private var _isPathValid:Boolean;
        private var _isLoadComplete:Boolean;
        private var _isImageLoading:Boolean;
        private var _currentAlpha:int = 0;
        private var _isShown:Boolean;

        public function UI_SixthSense()
        {
            super();
            mouseEnabled = false;
            
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            _loader = new ImageXVM();
            _loader.addEventListener(Event.COMPLETE, onImageSuccessLoadHandler, false, 0, true);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, onImageFaultLoadHandler, false, 0, true);
            _loader.alpha = 0;
            _currentAlpha = 0;
        }

        override protected function configUI():void
        {
            super.configUI();
            onConfigLoaded(null);
        }

        override public function as_show():void
        {
            _isShown = true;
            checkImage();
        }

        override public function as_hide():void
        {
            _isShown = false;
            checkImage();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            _loader.removeEventListener(Event.COMPLETE, onImageSuccessLoadHandler);
            _loader.removeEventListener(IOErrorEvent.IO_ERROR, onImageFaultLoadHandler);
            _loader.dispose();
            _loader = null;
            super.onDispose();
        }

        // PRIVATE

        private function onConfigLoaded(event:Event):void
        {
            var iconPath:String = Config.config.battle.sixthSenseIcon;
            if (iconPath)
            {
                iconPath = Utils.fixImgTagSrc(Macros.FormatStringGlobal(iconPath));
                _isPathValid = true;
                _isImageLoading = true;
                _loader.source = iconPath;
            }
            else
            {
                _isPathValid = false;
            }
        }

        private function onImageSuccessLoadHandler():void
        {
            if (!_loader.parent)
            {
                while (numChildren > 0)
                {
                    removeChildAt(0);
                }
                addChild(_loader);
            }
            _loader.x = -_loader.width / 2;
            _loader.y = -_loader.height / 2;
            _isImageLoading = false;
            _isLoadComplete = true;
            checkImage();
        }

        private function onImageFaultLoadHandler():void
        {
            _isImageLoading = false;
            _isLoadComplete = false;
            checkImage();
        }

        private function checkImage():void
        {
            if (!_isImageLoading)
            {
                if (_isPathValid && _isLoadComplete)
                {
                    if (_isShown)
                    {
                        if (_loader.alpha != 1)
                        {
                            TweenLite.to(_loader, 0.2, {alpha: 1});
                            _currentAlpha = 1;
                        }
                    }
                    else
                    {
                        if (_loader.alpha != 0)
                        {
                            TweenLite.to(_loader, 0.5, {alpha: 0});
                            _currentAlpha = 1;
                        }
                    }
                }
                else
                {
                    if (_isShown)
                    {
                        if (_currentAlpha != 1)
                        {
                            super.as_show();
                            _currentAlpha = 1;
                        }
                    }
                    else
                    {
                        if (_currentAlpha != 0)
                        {
                            super.as_hide();
                            _currentAlpha = 0;
                        }
                    }
                }
            }
        }
    }
}
