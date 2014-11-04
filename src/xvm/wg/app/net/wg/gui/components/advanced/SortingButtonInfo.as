package net.wg.gui.components.advanced
{
    import net.wg.data.constants.SortingInfo;
    
    public class SortingButtonInfo extends Object
    {
        
        public function SortingButtonInfo()
        {
            this.defaultSortDirection = SortingInfo.WITHOUT_SORT;
            super();
        }
        
        public static var NUMERIC:String = "numeric";
        
        public static var CASEINSENSITIVE:String = "string";
        
        public var iconId:String;
        
        public var iconSource:String;
        
        public var ascendingIconSource:String;
        
        public var descendingIconSource:String;
        
        public var toolTip:String;
        
        public var buttonWidth:Number = NaN;
        
        public var buttonHeight:Number = NaN;
        
        public var enabled:Boolean = true;
        
        public var inverted:Boolean = false;
        
        public var defaultSortDirection:String;
        
        public var sortOrder:int = -1;
        
        public var sortType:String = "numeric";
        
        public var label:String = "";
        
        public function get defaultSortDir() : uint
        {
            return this.defaultSortDirection == SortingInfo.DESCENDING_SORT?Array.DESCENDING:0;
        }
        
        public function get dataSortType() : uint
        {
            return this.sortType == NUMERIC?Array.NUMERIC:Array.CASEINSENSITIVE;
        }
        
        public function set dataSortType(param1:uint) : void
        {
            this.sortType = param1 == Array.NUMERIC?NUMERIC:CASEINSENSITIVE;
        }
    }
}
