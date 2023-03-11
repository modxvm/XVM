/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;

    public class UI_DeadPointEntry extends DeadPointEntry
    {
        private var _entryDeleted:Boolean = false;

        public function UI_DeadPointEntry()
        {
            //Logger.add("UI_DeadPointEntry");
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
