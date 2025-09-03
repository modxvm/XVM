/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.battle.shared.minimap.*;

    public class UI_CellFlashEntry extends CellFlashEntry
    {
        private var _entryDeleted:Boolean = false;

        public function UI_CellFlashEntry()
        {
            //Logger.add("UI_CellFlashEntry");
            super();
        }

        override protected function onDispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.onDispose();
        }

        override public function playAnimation():void
        {
            if (_entryDeleted)
            {
                return;
            }

            if (UI_Minimap.cfg.showCellClickAnimation)
            {
                mcAnimation.visible = true;
                super.playAnimation();
            }
            else
            {
                mcAnimation.visible = false;
            }
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;
        }
    }
}
