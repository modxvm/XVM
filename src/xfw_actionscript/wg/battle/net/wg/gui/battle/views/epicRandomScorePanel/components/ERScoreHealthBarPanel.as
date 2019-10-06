package net.wg.gui.battle.views.epicRandomScorePanel.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;

    public class ERScoreHealthBarPanel extends UIComponentEx
    {

        public static const PERCENT_SIGN:String = " %";

        public var enemyHpTF:TextField = null;

        public var allyHpTF:TextField = null;

        public var allyHpBar:ERScoreHealthBar = null;

        public var enemyHpBar:ERScoreHealthBar = null;

        private var _healthAlly:int = -1;

        private var _healthEnemy:int = -1;

        private var _percentagesChanged:Boolean = false;

        public function ERScoreHealthBarPanel()
        {
            super();
            this.allyHpBar.setColor(true,false);
            this.allyHpBar.setHealth(100);
            this.enemyHpBar.setColor(false,false);
            this.enemyHpBar.setHealth(100);
        }

        override protected function onDispose() : void
        {
            this.enemyHpTF = null;
            this.allyHpTF = null;
            this.allyHpBar.dispose();
            this.allyHpBar = null;
            this.enemyHpBar.dispose();
            this.enemyHpBar = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.allyHpTF.text = this._healthAlly.toString() + PERCENT_SIGN;
                this.allyHpBar.setHealth(this._healthAlly);
                this.enemyHpTF.text = this._healthEnemy.toString() + PERCENT_SIGN;
                this.enemyHpBar.setHealth(this._healthEnemy);
            }
        }

        public function updateColorBlind(param1:Boolean) : void
        {
            this.enemyHpBar.setColor(false,param1);
        }

        public function updateData(param1:int, param2:int) : void
        {
            if(this._healthAlly != param1)
            {
                this._percentagesChanged = true;
                this._healthAlly = param1;
            }
            if(this._healthEnemy != param2)
            {
                this._percentagesChanged = true;
                this._healthEnemy = param2;
            }
            if(this._percentagesChanged)
            {
                invalidateData();
                this._percentagesChanged = false;
            }
        }
    }
}
