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

        public function BIChances()
            { 
                var BIChancesField:MovieClip = _root;
                	if (!Config.config.battle.WinChancesOnBattleInterface.DisableStatic)
                		BIChances._BIChances.__isShowChances = true;
                	else BIChances._BIChances.__isShowChances = false;
                	if (Config.networkServicesSettings.chanceLive && !Config.config.battle.WinChancesOnBattleInterface.DisableLive)
						BIChances._BIChances.__isShowLiveChances = true;
					else BIChances._BIChances.__isShowLiveChances = false;
                    BIChances._BIChances.__formatStaticTextFirst = "<span class='chances'>";
                    BIChances._BIChances.__formatStaticTextSecond = "</span>";
                    BIChances._BIChances.__Count = 0;
					chances = BIChancesField.createTextField("chances", 
                        BIChancesField.getNextHighestDepth(), 
                        GetCoordinateXY(Config.config.battle.WinChancesOnBattleInterface.position.halign, Config.config.battle.WinChancesOnBattleInterface.position.width) + Config.config.battle.WinChancesOnBattleInterface.position.x,
                        GetCoordinateXY(Config.config.battle.WinChancesOnBattleInterface.position.valign, Config.config.battle.WinChancesOnBattleInterface.position.height) + Config.config.battle.WinChancesOnBattleInterface.position.y,
                        Config.config.battle.WinChancesOnBattleInterface.position.width, Config.config.battle.WinChancesOnBattleInterface.position.height);
                    chances.selectable = false;
                    chances.antiAliasType = "advanced";
                    chances.html = true;
                    chances.styleSheet = Utils.createStyleSheet(Utils.createCSS("chances",
                    	int(Config.config.battle.WinChancesOnBattleInterface.font.color), Config.config.battle.WinChancesOnBattleInterface.font.name, 
                    	Config.config.battle.WinChancesOnBattleInterface.font.size, Config.config.battle.WinChancesOnBattleInterface.font.align, 
                    	Config.config.battle.WinChancesOnBattleInterface.font.bold, Config.config.battle.WinChancesOnBattleInterface.font.italic));
                    chances.filters = [new flash.filters.DropShadowFilter(Config.config.battle.WinChancesOnBattleInterface.shadow.distance, 
                    	Config.config.battle.WinChancesOnBattleInterface.shadow.angle, int(Config.config.battle.WinChancesOnBattleInterface.shadow.color), 
                    	Config.config.battle.WinChancesOnBattleInterface.shadow.alpha, Config.config.battle.WinChancesOnBattleInterface.shadow.blurX, 
                    	Config.config.battle.WinChancesOnBattleInterface.shadow.blurY, Config.config.battle.WinChancesOnBattleInterface.shadow.strength)];
                    _BIChances.__intervalID = setInterval(function() {
                        BIChances._BIChances.__Count++;
                        BIChances.UpdateBIChances();
                        }, 2000);
            }
    
        public static function UpdateBIChances() {
            if (BIChances._BIChances.__isShowLiveChances == undefined) {
                return;
            }
                var BIChancesText: String = Chance.GetChanceText(true, false,  BIChances._BIChances.__isShowLiveChances);
                if (((BIChancesText != "") && (BIChances._BIChances.__isClearedInterval != "true")) || (BIChances._BIChances.__Count > 5)) {
                    clearInterval(_BIChances.__intervalID);
                    BIChances._BIChances.__isClearedInterval = "true";
                }
                if BIChancesText == "" {
                    BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(BIChances._BIChances.__formatStaticTextFirst + '' + BIChances._BIChances.__formatStaticTextSecond);
                }
                else {
                    BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(formatChanceText(BIChancesText, BIChances._BIChances.__isShowChances, BIChances._BIChances.__isShowLiveChances));
                }
        }
        
        private static function formatChanceText(ChancesText: String, isShowChance, isShowLiveChance: Boolean) {
           var temp: Array = ChancesText.split('|', 2);
           var tempA: Array =	temp[0].split(':', 2);
           		if (isShowChance && isShowLiveChance) {
            		var tempB: Array = temp[1].split(':', 2);
                		return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + '/' + tempB[1] + BIChances._BIChances.__formatStaticTextSecond;
           		}
            	else { 
            		if (isShowChance && !isShowLiveChance){
            			return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + BIChances._BIChances.__formatStaticTextSecond;
            		}	
            	 	else {
            	 		var tempB: Array = temp[1].split(':', 2);
            			return BIChances._BIChances.__formatStaticTextFirst + tempB[1] + BIChances._BIChances.__formatStaticTextSecond;
            		}
            	}
            	
        }

        private static function GetCoordinateXY(align, WidthOrHeight: Number) {
        //'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' for vertical
            switch (align) {  
                case 'left':  
                    return 0;  
                    Logger.add('0');  
                case 'right' :  
                    return Stage.width - WidthOrHeight;    
                    break; 
                case 'center':  
                    return (Stage.width/2) - (WidthOrHeight/2);  
                    break;  
                case 'top':  
                    return 0;  
                    break; 
                case 'bottom':  
                    return Stage.height - WidthOrHeight;  
                    break;
                case 'middle':  
                    return (Stage.height/2) - (WidthOrHeight/2);  
                    break;     
            }
        }
	}
