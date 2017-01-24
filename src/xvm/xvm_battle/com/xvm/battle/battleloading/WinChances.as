/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import net.wg.gui.battle.battleloading.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.gfx.*;

    public class WinChances implements IDisposable
    {
        private var cfg:CBattleLoading;
        private var form:BattleLoadingForm;
        private var winChanceTF:TextField = null;

        public function WinChances(form:BattleLoadingForm)
        {
            this.form = form;
            cfg = form.formBackgroundTable.visible ? Config.config.battleLoading : Config.config.battleLoadingTips;

            winChanceTF = createWinChanceTextField(form.battleText);
            winChanceTF.styleSheet = XfwUtils.createTextStyleSheet("chances", form.battleText.defaultTextFormat);
            winChanceTF.x = -512;
            winChanceTF.width = 1024;
            winChanceTF.y = -57;
            winChanceTF.height = form.battleText.height;
            form.addChild(winChanceTF);

            // Load battle stat
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, updateChanceText, false, 0, true)
            if (Stat.battleStatLoaded)
            {
                updateChanceText();
            }
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            form.removeChild(winChanceTF);
            winChanceTF = null;
        }

        // PRIVATE

        private function updateChanceText():void
        {
            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in Stat.battleStat)
                playerNames.push(name);
            var chanceStatic:Boolean = Config.networkServicesSettings.statBattle && Config.networkServicesSettings.chance;
            var chanceText:String = Chance.GetChanceText(playerNames, Stat.battleStat, chanceStatic, cfg.showBattleTier);
            if (chanceText)
            {
                winChanceTF.htmlText = '<span class="chances">' + chanceText + '</span>';
            }
        }

        private function createWinChanceTextField(tpl:TextField):TextField
        {
            var f:TextField = new TextField();
            f.mouseEnabled = false;
            f.selectable = false;
            TextFieldEx.setNoTranslate(f, true);
            f.antiAliasType = AntiAliasType.ADVANCED;
            f.autoSize = TextFieldAutoSize.NONE;
            var tf:TextFormat = tpl.getTextFormat();
            tf.color = 0xFFFFFF;
            tf.align = TextFormatAlign.CENTER;
            f.defaultTextFormat = tf;
            f.filters = tpl.filters;
            return f;
        }
    }
}
