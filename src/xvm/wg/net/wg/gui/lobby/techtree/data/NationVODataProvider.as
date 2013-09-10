package net.wg.gui.lobby.techtree.data 
{
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class NationVODataProvider extends net.wg.gui.lobby.techtree.data.AbstractDataProvider implements net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider
    {
        public function NationVODataProvider()
        {
            this._displaySettings = new net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings();
            super();
            return;
        }

        public function get scrollIndex():Number
        {
            return this._scrollIndex;
        }

        public function get displaySettings():net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings
        {
            return this._displaySettings;
        }

        public override function parse(arg1:Object):void
        {
            var loc4:*=null;
            clearUp();
            net.wg.gui.lobby.techtree.data.vo.NodeData.setDisplayInfoClass(net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo);
            var loc1:*=arg1.nodes;
            var loc2:*=App.utils.locale;
            if (arg1.hasOwnProperty("scrollIndex")) 
            {
                this._scrollIndex = arg1.scrollIndex;
            }
            if (arg1.hasOwnProperty("displaySettings")) 
            {
                this._displaySettings.fromObject(arg1.displaySettings, loc2);
            }
            var loc3:*=loc1.length;
            var loc5:*=0;
            while (loc5 < loc3) 
            {
                (loc4 = new net.wg.gui.lobby.techtree.data.vo.NodeData()).fromObject(loc1[loc5], loc2);
                nodeIdxCache[loc4.id] = nodeData.length;
                nodeData.push(loc4);
                ++loc5;
            }
            return;
        }

        protected var _scrollIndex:Number=-1;

        protected var _displaySettings:net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    }
}
