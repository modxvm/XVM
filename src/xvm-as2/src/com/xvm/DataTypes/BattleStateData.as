import com.xvm.DataTypes.*;
/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
class com.xvm.DataTypes.BattleStateData
{
    public var playerName:String = null;
    public var playerId:Number = NaN;
    public var vehId:Number = NaN;
    public var dead:Boolean = false;
    public var curHealth:Number = NaN;
    public var maxHealth:Number = NaN;
    public var marksOnGun:Number = NaN;
    public var spottedStatus:Number = SpottedStatusType.NEVER_SEEN;
    public var frags:Number = NaN;
    public var ready:Boolean = false;
    public var blowedUp:Boolean = false;
    public var teamKiller:Boolean = false;
    public var squad:Number = 0;
    public var selected:Boolean = false;
    public var entityName:String = null;
    public var entryName:String = null;
    public var position:Number = NaN;
}
