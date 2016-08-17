/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.wg.*;
    import flash.events.*;

    public class UI_StrategicCameraEntry extends StrategicCameraEntry
    {
        private var _loader:ImageWG = null;
        private var _aimScale:Number;
        private var _previousVisible:Boolean = false;
        private var _previousScale:Number;

        public function UI_StrategicCameraEntry()
        {
            super();
            visible = false;
        }

        override protected function configUI():void
        {
            super.configUI();
            _aimScale = Macros.FormatNumberGlobal(Config.config.minimap.minimapAimIconScale) / 100.0;
            var iconPath:String = Macros.FormatStringGlobal(Config.config.minimap.minimapAimIcon);
            if (iconPath)
            {
                iconPath = Utils.fixImgTagSrc(iconPath);
                _loader = new ImageWG();
                _loader.successCallback = onImageSuccessLoadHandler;
                _loader.errorCallback = onImageFaultLoadHandler;
                _loader.source = iconPath;
            }
        }

        override protected function onDispose():void
        {
            App.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            if (_loader)
            {
                if (_loader.parent)
                {
                    _loader.parent.removeChild(_loader);
                }
                _loader.dispose();
                _loader = null;
            }
            super.onDispose();
        }

        // PRIVATE

        private function onImageSuccessLoadHandler():void
        {
            parent.addChild(_loader);
            _loader.visible = false;
            _previousScale = _loader.parent.scaleX;
            _loader.scaleX = 1 / _loader.parent.scaleX * _aimScale;
            _loader.scaleY = 1 / _loader.parent.scaleY * _aimScale;
            App.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
        }

        private function onEnterFrame():void
        {
            _loader.x = x - _loader.width / 2;
            _loader.y = y - _loader.height / 2;

            if (visible != _previousVisible)
            {
                _loader.visible = visible;
                _previousVisible = visible;
            }

            if (_previousScale != _loader.parent.scaleX)
            {
                _previousScale = _loader.parent.scaleX;
                _loader.scaleX = 1 / _loader.parent.scaleX * _aimScale;
                _loader.scaleY = 1 / _loader.parent.scaleY * _aimScale;
            }
        }

        private function onImageFaultLoadHandler():void
        {
           Logger.add("Can't resolve path: " + _loader.source);
        }
    }
}
