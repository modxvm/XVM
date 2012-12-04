import wot.utils.Utils;

/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.model.IconsProxy
{
    public static function getAssignedUids():Array
    {
        var minimapEntries:Array = Utils.getChildrenOf(getIcons(), false);
        
        var assigned:Array = [];
        for (var i:Number = 0; i < minimapEntries.length; i++)
        {
            if (minimapEntries[i].uid)
                assigned.push(minimapEntries[i].uid);
        }
        
        return assigned;
    }
    
    // -- Private
    
    private static function getIcons():MovieClip
    {
        return _root.minimap.icons;
    }
}