/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.*;
    import com.xvm.wg.*;
    import flash.events.*;

    public class UI_StrategicCameraEntry extends StrategicCameraEntry
    {
        private var _entryDeleted:Boolean = false;

        private var _loader:ImageXVM = null;
        private var _aimScale:Number = 1;
        private var _previousVisible:Boolean = false;
        private var _previousScale:Number = NaN;

        public function UI_StrategicCameraEntry()
        {
            super();
            visible = false;
            Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
        }

        override protected function onDispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.onDispose();
        }

        override protected function configUI():void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: draw() on deleted StrategicCameraEntry");
                return;
            }

            super.configUI();

            update();
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

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
        }

        // PRIVATE

        private function update():void
        {
            _aimScale = UI_Minimap.cfg.minimapAimIconScale / 100.0;
            var iconPath:String = UI_Minimap.cfg.minimapAimIcon;
            if (iconPath)
            {
                iconPath = Utils.fixImgTagSrc(iconPath);
                if (!_loader)
                {
                    _loader = new ImageXVM();
                    _loader.addEventListener(Event.COMPLETE, onImageSuccessLoadHandler, false, 0, true);
                    _loader.addEventListener(IOErrorEvent.IO_ERROR, onImageFaultLoadHandler, false, 0, true);
                    parent.addChild(_loader);
                }
            }
            else
            {
                iconPath = null;
            }
            if (_loader)
            {
                if (_loader.source != iconPath)
                {
                    App.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                    _previousScale = 0;
                    _previousVisible = false;
                    _loader.visible = false;
                    _loader.source = iconPath;
                }
            }
        }

        private function onImageSuccessLoadHandler():void
        {
            App.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
        }

        private function onEnterFrame():void
        {
            _loader.x = x - _loader.width / 2;
            _loader.y = y - _loader.height / 2;

            if (_previousScale != _loader.parent.scaleX)
            {
                _previousScale = _loader.parent.scaleX;
                _loader.scaleX = 1 / _loader.parent.scaleX * _aimScale;
                _loader.scaleY = 1 / _loader.parent.scaleY * _aimScale;
            }

            if (visible != _previousVisible)
            {
                _loader.visible = visible;
                _previousVisible = visible;
            }
        }

        private function onImageFaultLoadHandler():void
        {
           Logger.add("minimapAimIcon: can't resolve path: " + _loader.source);
        }
    }
}
