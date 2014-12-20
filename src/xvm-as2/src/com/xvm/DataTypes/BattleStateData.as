/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
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
    public var spotted:String = null;

    public function BattleStateData(playerName:String, playerId:Number, vehId:Number, dead:Boolean, curHealth:Number, maxHealth:Number, marksOnGun:Number, spotted:String)
    {
        if (playerName != null)
            this.playerName = playerName;

        if (!isNaN(playerId))
            this.playerId = playerId;

        if (!isNaN(vehId))
            this.vehId = vehId;

        this.dead = dead;

        if (!isNaN(curHealth))
            this.curHealth = curHealth;

        if (!isNaN(maxHealth))
            this.maxHealth = maxHealth;

        if (!isNaN(marksOnGun))
            this.marksOnGun = marksOnGun;

        if (spotted != null)
            this.spotted = spotted;
    }
}
