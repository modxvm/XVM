package net.wg.gui.battle.views.radialMenu.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.utils.Dictionary;
    import net.wg.data.constants.generated.BATTLE_ICONS_CONSTS;

    public class Icons extends Sprite implements IDisposable
    {

        public var followmeIcon:Sprite = null;

        public var stopIcon:Sprite = null;

        public var turnbackIcon:Sprite = null;

        public var supportIcon:Sprite = null;

        public var attackSPGIcon:Sprite = null;

        public var helpmeexIcon:Sprite = null;

        public var helpmeIcon:Sprite = null;

        public var backtobaseIcon:Sprite = null;

        public var noIcon:Sprite = null;

        public var reloadIcon:Sprite = null;

        public var attackIcon:Sprite = null;

        public var yesIcon:Sprite = null;

        private var _iconsDictionary:Dictionary;

        public function Icons()
        {
            this._iconsDictionary = new Dictionary();
            super();
            this._iconsDictionary[BATTLE_ICONS_CONSTS.FOLLOW_ME] = this.followmeIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.STOP] = this.stopIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.TURN_BACK] = this.turnbackIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.SUPPORT] = this.supportIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.ATTACK_SPG] = this.attackSPGIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.HELP_ME_EX] = this.helpmeexIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.HELP_ME] = this.helpmeIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.BACK_TO_BASE] = this.backtobaseIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.NO] = this.noIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.RELOAD] = this.reloadIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.ATTACK] = this.attackIcon;
            this._iconsDictionary[BATTLE_ICONS_CONSTS.YES] = this.yesIcon;
        }

        public function showIcon(param1:String) : void
        {
            this.hideAll();
            this._iconsDictionary[param1].visible = true;
        }

        public function hideAll() : void
        {
            this.followmeIcon.visible = false;
            this.stopIcon.visible = false;
            this.turnbackIcon.visible = false;
            this.supportIcon.visible = false;
            this.attackSPGIcon.visible = false;
            this.helpmeexIcon.visible = false;
            this.helpmeIcon.visible = false;
            this.backtobaseIcon.visible = false;
            this.noIcon.visible = false;
            this.reloadIcon.visible = false;
            this.attackIcon.visible = false;
            this.yesIcon.visible = false;
        }

        public function dispose() : void
        {
            App.utils.data.cleanupDynamicObject(this._iconsDictionary);
            this._iconsDictionary = null;
            this.followmeIcon = null;
            this.stopIcon = null;
            this.turnbackIcon = null;
            this.supportIcon = null;
            this.attackSPGIcon = null;
            this.helpmeexIcon = null;
            this.helpmeIcon = null;
            this.backtobaseIcon = null;
            this.noIcon = null;
            this.reloadIcon = null;
            this.attackIcon = null;
            this.yesIcon = null;
        }
    }
}
