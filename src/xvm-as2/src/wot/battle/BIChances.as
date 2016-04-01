/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>, wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 */
import com.xvm.*;
import wot.battle.BattleMain;

class wot.battle.BIChances
    {      
        public static var _BIChances:Object = {};
        public var chances: TextField; 
        public static var showed: Number = 0;

        public function BIChances()
            { 
                var debugPanel:MovieClip = _root.debugPanel;
                var lag:MovieClip = debugPanel.lag;
                var fps:MovieClip = debugPanel.fps;
                var clock:MovieClip = debugPanel.clock;
                    BIChances._BIChances.__isShowChances = Config.networkServicesSettings.chance;
                    BIChances._BIChances.__isShowLiveChances =  Config.networkServicesSettings.chanceLive;
                    BIChances._BIChances.__formatStaticTextFirst = "<span class='chances'>";
                    BIChances._BIChances.__formatStaticTextSecond = "</span>";
                    BIChances._BIChances.__Count = 0;
                    if ((Config.config.battle.DisableLiveWinChancesOnBattleInterface == false) && (BIChances._BIChances.__isShowLiveChances == true)) {
                        BIChances._BIChances.__isShowLiveChancesOnBI = true;
                    }
                    else {
                        BIChances._BIChances.__isShowLiveChancesOnBI = false;
                    }
                    chances = debugPanel.createTextField("chances", debugPanel.getNextHighestDepth(), clock._x + (lag._width * 2) + 5, fps._y, 100, clock._height);
                    chances.selectable = false;
                    chances.antiAliasType = "advanced";
                    chances.html = true;
                    var tf: TextFormat = fps.getNewTextFormat();
                    chances.styleSheet = Utils.createStyleSheet(Utils.createCSS("chances",
                    tf.color, tf.font, tf.size, "left", tf.bold, tf.italic));
                    chances.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5)];
                    _BIChances.__intervalID = setInterval(function() {
                        BIChances._BIChances.__Count++;
                        BIChances.UpdateBIChances();
                        }, 2000);
            }
    
        public static function UpdateBIChances() {
            if (BIChances._BIChances.__isShowLiveChances == undefined) {
                return;
            }
                var BIChancesText:String;
                var isShowChances:Boolean = BIChances._BIChances.__isShowChances;
                var isShowChancesLive: Boolean = BIChances._BIChances.__isShowLiveChancesOnBI; 
                BIChancesText = Chance.GetChanceText(isShowChances, false,  isShowChancesLive);
                if (((BIChancesText != "") && (BIChances._BIChances.__isClearedInterval != "true")) || (BIChances._BIChances.__Count > 5)) {
                    clearInterval(_BIChances.__intervalID);
                    BIChances._BIChances.__isClearedInterval = "true";
                }
                if BIChancesText == "" {
                    BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(BIChances._BIChances.__formatStaticTextFirst + '' + BIChances._BIChances.__formatStaticTextSecond);
                }
                else {
                    BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(formatChanceText(BIChancesText, isShowChancesLive));
                }
        }
        
        private static function formatChanceText(ChancesText: String, IsShowLiveChance: Boolean) {
            var temp: Array = ChancesText.split('|', 2);
            var tempA: Array = temp[0].split(':', 2);
            if IsShowLiveChance == true {
              var tempB: Array = temp[1].split(':', 2);
                return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + '/' + tempB[1] + BIChances._BIChances.__formatStaticTextSecond;
            }
            else {
                return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + BIChances._BIChances.__formatStaticTextSecond;
            }
        }
    }
