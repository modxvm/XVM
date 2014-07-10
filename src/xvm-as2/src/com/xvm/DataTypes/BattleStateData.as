class com.xvm.DataTypes.BattleStateData
{
    public var playerName:String = null;
    public var playerId:Number = 0;
    public var vehId:Number = 0;
    public var dead:Boolean = false;
    public var curHealth:Number = 0;
    public var maxHealth:Number = 0;

    public function BattleStateData(playerName, playerId, vehId, dead, curHealth, maxHealth)
    {
        this.playerName = playerName;
        this.playerId = playerId;
        this.vehId = vehId;
        this.dead = dead;
        this.curHealth = curHealth;
        this.maxHealth = maxHealth;
    }
}
