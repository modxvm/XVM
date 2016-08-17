/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.wg.*;
    import flash.events.*;

    public class UI_StrategicCameraEntry extends StrategicCameraEntry
    {
        private var _loader:ImageWG = null;
        private var _aimScale:Number = 1;
        private var _previousVisible:Boolean = false;
        private var _previousScale:Number = NaN;

        public function UI_StrategicCameraEntry()
        {
            super();
            visible = false;
            Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
        }

        override protected function configUI():void
        {
            super.configUI();
            update();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
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

        private function update():void
        {
            App.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            _aimScale = Macros.FormatNumberGlobal(UI_Minimap.cfg.minimapAimIconScale) / 100.0;
            var iconPath:String = Macros.FormatStringGlobal(UI_Minimap.cfg.minimapAimIcon);
            if (iconPath)
            {
                iconPath = Utils.fixImgTagSrc(iconPath);
                if (!_loader)
                {
                    _loader = new ImageWG();
                    _loader.successCallback = onImageSuccessLoadHandler;
                    _loader.errorCallback = onImageFaultLoadHandler;
                }
                if (_loader.source != iconPath)
                {
                    _loader.source = iconPath;
                }
            }
            else
            {
                _loader.source = null;
            }
        }

        private function onImageSuccessLoadHandler():void
        {
            parent.addChild(_loader);
            _loader.visible = false;
            _previousVisible = false;
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
