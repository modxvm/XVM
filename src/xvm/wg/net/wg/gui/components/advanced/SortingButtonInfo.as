package net.wg.gui.components.advanced 
{
    public class SortingButtonInfo extends Object
    {
        public function SortingButtonInfo()
        {
            super();
            return;
        }

        public var iconId:String;

        public var iconSource:String;

        public var ascendingIconSource:String;

        public var descendingIconSource:String;

        public var toolTip:String;

        public var buttonWidth:Number=NaN;

        public var buttonHeight:Number=NaN;

        public var enabled:Boolean=true;

        public var defaultSortDirection:String="none";

        public var label:String="";
    }
}
