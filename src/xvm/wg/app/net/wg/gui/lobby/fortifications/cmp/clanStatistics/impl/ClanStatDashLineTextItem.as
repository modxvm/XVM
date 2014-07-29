package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import net.wg.gui.components.advanced.DashLineTextItem;
    import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;
    
    public class ClanStatDashLineTextItem extends DashLineTextItem
    {
        
        public function ClanStatDashLineTextItem()
        {
            super();
        }
        
        private var _data:ClanStatItemVO;
        
        override protected function onDispose() : void
        {
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            super.onDispose();
        }
        
        public function get data() : ClanStatItemVO
        {
            return this._data;
        }
        
        public function set data(param1:ClanStatItemVO) : void
        {
            this._data = param1;
            if(this._data)
            {
                this.label = this._data.label;
                this.value = this._data.value;
                this.enabled = this._data.enabled;
            }
        }
    }
}
