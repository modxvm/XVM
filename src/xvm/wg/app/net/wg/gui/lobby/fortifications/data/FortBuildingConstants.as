package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    
    public class FortBuildingConstants extends Object
    {
        
        public function FortBuildingConstants()
        {
            super();
        }
        
        public static var TROWEL_STATE:String = "trowel_state";
        
        public static var BUILD_FOUNDATION_STATE:String = "buildFoundation_state";
        
        public static var DEFAULT_FOUNDATION_STATE:String = "defaultFoundation_state";
        
        public static var CRASHABLE_BUILDINGS:Array = [FORTIFICATION_ALIASES.FORT_BASE_BUILDING];
        
        public static var BUILD_CODE_TO_NAME_MAP:Object = {};
        
        public static var BASE_BUILDING:String = "base_building";
        
        public static var CRASH_POSTFIX:String = "_crash";
        
        public static var FORT_UNKNOWN:String = "unknown";
    }
}
