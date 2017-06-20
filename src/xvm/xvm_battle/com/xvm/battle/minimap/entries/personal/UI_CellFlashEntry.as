/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.minimap.entries.personal
{
    import com.xfw.*;

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

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;
        }
    }
}
