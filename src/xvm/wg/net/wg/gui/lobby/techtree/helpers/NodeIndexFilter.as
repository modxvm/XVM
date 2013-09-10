package net.wg.gui.lobby.techtree.helpers 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    
    public class NodeIndexFilter extends Object
    {
        public function NodeIndexFilter(arg1:Array)
        {
            super();
            this.indexes = arg1;
            return;
        }

        public function doFilter(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:int, arg3:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>):Boolean
        {
            return !(arg1 == null) && this.indexes.indexOf(arg2) > -1;
        }

        internal var indexes:Array;
    }
}
