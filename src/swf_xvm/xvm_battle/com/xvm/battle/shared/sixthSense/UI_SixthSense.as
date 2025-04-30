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
        private var _imagePathValid:Boolean;
        private var _imageLoading:Boolean;
        private var _imageLoaded:Boolean;
        private var _spotted:Boolean;
        private var _shown:Boolean;
        private var _immediate:Boolean;
        CLIENT::LESTA {
            private var _permanent:Boolean;
        }

        public function UI_SixthSense()
        {
            super();
            mouseEnabled = false;

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            _loader = new ImageXVM();
            _loader.addEventListener(Event.COMPLETE, onImageSuccessLoadHandler, false, 0, true);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, onImageFaultLoadHandler, false, 0, true);
            _loader.alpha = 0;
            CLIENT::LESTA {
                addEventListener(EVENT_POSITION_CHANGED, onSixthSensePositionChanged);
            }
        }

        override protected function configUI():void
        {
            super.configUI();
            onConfigLoaded(null);
        }

        CLIENT::WG {
            override public function as_show():void
            {
                _spotted = true;
                updateState();
            }

            override public function as_hide(immediate:Boolean):void
            {
                _spotted = false;
                _immediate = immediate;
                updateState();
            }
        }

        CLIENT::LESTA {
            override public function as_show(immediate:Boolean):void
            {
                _spotted = true;
                _immediate = immediate;
                updateState();
            }

            override public function as_showIndicator():void
            {
                _permanent = true;
                updateState();
            }

            override public function as_hide(immediate:Boolean):void
            {
                _spotted = false;
                _permanent = false;
                _immediate = immediate;
                updateState();
            }
        }

        override protected function onDispose():void
        {
            CLIENT::LESTA {
                removeEventListener(EVENT_POSITION_CHANGED, onSixthSensePositionChanged);
            }
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            _loader.removeEventListener(Event.COMPLETE, onImageSuccessLoadHandler);
            _loader.removeEventListener(IOErrorEvent.IO_ERROR, onImageFaultLoadHandler);
            _loader.dispose();
            _loader = null;
            super.onDispose();
        }

        public function get isCustomImageMode():Boolean
        {
            return _imagePathValid && _imageLoaded;
        }

        // PRIVATE

        private function onConfigLoaded(event:Event):void
        {
            updateImage();
            CLIENT::WG {
                updateAlpha();
            }
            updateScale();
            updatePosition();
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
            _imageLoading = false;
            _imageLoaded = true;
            updateState();
        }

        private function onImageFaultLoadHandler():void
        {
            _imageLoading = false;
            _imageLoaded = false;
            updateState();
        }

        private function updateImage():void
        {
            var iconPath:String = Config.config.battle.sixthSense.icon;

            if (iconPath)
            {
                iconPath = Utils.fixImgTagSrc(Macros.FormatStringGlobal(iconPath));
                _imagePathValid = true;
                _imageLoading = true;
                _loader.source = iconPath;
            }
            else
            {
                _imagePathValid = false;
            }
        }

        CLIENT::WG {
            private function updateAlpha():void
            {
                alpha = Macros.FormatNumberGlobal(Config.config.battle.sixthSense.alpha, 100) / 100.0;
            }
        }

        private function updateScale():void
        {
            var scale:Number = Macros.FormatNumberGlobal(Config.config.battle.sixthSense.scale, 1);
            scaleX = scaleY = isNaN(scale) ? 1 : scale;
        }

        private function updatePosition():void
        {
            CLIENT::LESTA {
                var useOldInitialPosition:Boolean = Macros.FormatBooleanGlobal(Config.config.battle.sixthSense.useOldInitialPosition, false);
                if (useOldInitialPosition)
                {
                    x = App.appWidth >> 1;
                    y = App.appHeight >> 2;
                }
            }
            x += Macros.FormatNumberGlobal(Config.config.battle.sixthSense.offsetX, 0);
            y += Macros.FormatNumberGlobal(Config.config.battle.sixthSense.offsetY, 0);
        }

        CLIENT::WG {
            private function updateState():void
            {
                if (_imageLoading)
                    return;

                if (!isCustomImageMode)
                {
                    if (_spotted)
                    {
                        if (!_shown)
                        {
                            super.as_show();
                            _shown = true;
                        }
                    }
                    else
                    {
                        if (_shown)
                        {
                            super.as_hide(_immediate);
                            _shown = false;
                        }
                    }

                    return;
                }

                TweenLite.killTweensOf(_loader);

                if (_spotted)
                {
                    if (!_shown)
                    {
                        TweenLite.to(_loader, 0.2, {alpha: 1});
                        _shown = true;
                    }
                }
                else
                {
                    if (_shown)
                    {
                        if (!_immediate)
                        {
                            TweenLite.to(_loader, 0.5, {alpha: 0});
                        }
                        else
                        {
                            _loader.alpha = 0;
                        }
                        _shown = false;
                    }
                }
            }
        }

        CLIENT::LESTA {
            private function onSixthSensePositionChanged(event:Event):void
            {
                updatePosition();
            }

            private function updateState():void
            {
                if (_imageLoading)
                    return;

                if (!isCustomImageMode)
                {
                    if (_spotted)
                    {
                        if (!_shown)
                        {
                            super.as_show(_immediate);
                            _shown = true;
                        }
                        else if (_shown && _permanent)
                        {
                            super.as_showIndicator();
                        }
                    }
                    else
                    {
                        if (_shown)
                        {
                            super.as_hide(_immediate);
                            _shown = false;
                        }
                    }

                    return;
                }

                TweenLite.killTweensOf(_loader);

                if (_spotted)
                {
                    if (!_shown)
                    {
                        XfwAccess.setPrivateField(this, '_isActive', true);
                        visible = true;
                        if (!_immediate)
                        {
                            TweenLite.to(_loader, 0.2, {alpha: 1});
                        }
                        else
                        {
                            _loader.alpha = 1;
                        }
                        _shown = true;
                    }
                    else if (_shown && _permanent)
                    {
                        var permanentScale:Number = Macros.FormatNumberGlobal(Config.config.battle.sixthSense.permanentScale, 0.7);
                        permanentScale = isNaN(permanentScale) ? 1 : permanentScale;
                        if (permanentScale != 1)
                        {
                            TweenLite.to(_loader, 0.2, {
                                scaleX: permanentScale,
                                scaleY: permanentScale,
                                onUpdate: function():void {
                                    _loader.x = -_loader.width / 2;
                                    _loader.y = -_loader.height / 2;
                                }
                            });
                        }
                    }
                }
                else
                {
                    if (_shown)
                    {
                        XfwAccess.setPrivateField(this, '_isActive', false);
                        if (!_immediate)
                        {
                            TweenLite.to(_loader, 0.5, {
                                alpha: 0,
                                onComplete: function():void {
                                    visible = false;
                                    _loader.scaleX = _loader.scaleY = 1;
                                    _loader.x = -_loader.width / 2;
                                    _loader.y = -_loader.height / 2;
                                }
                            });
                        }
                        else
                        {
                            _loader.alpha = 0;
                            visible = false;
                            _loader.scaleX = _loader.scaleY = 1;
                            _loader.x = -_loader.width / 2;
                            _loader.y = -_loader.height / 2;
                        }
                        _shown = false;
                    }
                }
            }
        }
    }
}
