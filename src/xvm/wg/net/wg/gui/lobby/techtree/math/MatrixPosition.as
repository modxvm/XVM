package net.wg.gui.lobby.techtree.math 
{
    public class MatrixPosition extends Object
    {
        public function MatrixPosition(arg1:int=-1, arg2:int=-1)
        {
            super();
            this.row = arg1;
            this.column = arg2;
            return;
        }

        public function toString():String
        {
            return "[MatrixPosition: start = " + this.row + ", end = " + this.column + "]";
        }

        public var row:int;

        public var column:int;
    }
}
