/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>, wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 */
import com.xvm.*;

class wot.battle.BIChances
{      
    public static var _BIChances:Object = {};
    public var chances: TextField; 

    public function BIChances()
    { 


  // _root['test'];
        for (var i:Number = -16900; i < 16900; ++i) {
            if _root.getInstanceAtDepth(i) != undefined
            Logger.add(String(i) + ' ' + String(_root.getInstanceAtDepth(i)));
        }

        
        if (!Config.config.battle.winChancesOnBattleInterface.disableStatic)
            BIChances._BIChances.__isShowChances = true;
        else BIChances._BIChances.__isShowChances = false;
        if (Config.networkServicesSettings.chanceLive && !Config.config.battle.winChancesOnBattleInterface.disableLive)
            BIChances._BIChances.__isShowLiveChances = true;
        else BIChances._BIChances.__isShowLiveChances = false;
        BIChances._BIChances.__formatStaticTextFirst = "<span class='chances'>";
        BIChances._BIChances.__formatStaticTextSecond = "</span>";
        BIChances._BIChances.__Count = 0;
        chances = _root.xvm_holder.createTextField("chances", 
            _root.xvm_holder.getNextHighestDepth(), 
            GetCoordinateXY(Config.config.battle.winChancesOnBattleInterface.position.halign, Config.config.battle.winChancesOnBattleInterface.position.width) + Config.config.battle.winChancesOnBattleInterface.position.x,
            GetCoordinateXY(Config.config.battle.winChancesOnBattleInterface.position.valign, Config.config.battle.winChancesOnBattleInterface.position.height) + Config.config.battle.winChancesOnBattleInterface.position.y,
            Config.config.battle.winChancesOnBattleInterface.position.width, Config.config.battle.winChancesOnBattleInterface.position.height);
        chances.selectable = false;
        chances.antiAliasType = "advanced";
        chances.html = true;
        chances.styleSheet = Utils.createStyleSheet(Utils.createCSS("chances",
            int(Config.config.battle.winChancesOnBattleInterface.font.color), Config.config.battle.winChancesOnBattleInterface.font.name, 
            Config.config.battle.winChancesOnBattleInterface.font.size, Config.config.battle.winChancesOnBattleInterface.font.align, 
            Config.config.battle.winChancesOnBattleInterface.font.bold, Config.config.battle.winChancesOnBattleInterface.font.italic));
        chances.filters = [new flash.filters.DropShadowFilter(Config.config.battle.winChancesOnBattleInterface.shadow.distance, 
            Config.config.battle.winChancesOnBattleInterface.shadow.angle, int(Config.config.battle.winChancesOnBattleInterface.shadow.color), 
            Config.config.battle.winChancesOnBattleInterface.shadow.alpha, Config.config.battle.winChancesOnBattleInterface.shadow.blurX, 
            Config.config.battle.winChancesOnBattleInterface.shadow.blurY, Config.config.battle.winChancesOnBattleInterface.shadow.strength)];
       // _BIChances.__intervalID = setInterval(function()
       // {
         //   BIChances._BIChances.__Count++;
            //BIChances.UpdateBIChances();
            var _BIChancesText: String = Chance.GetChanceText(true, false,  BIChances._BIChances.__isShowLiveChances);
            chances.htmlText = Utils.fixImgTag(formatChanceText(_BIChancesText, BIChances._BIChances.__isShowChances, BIChances._BIChances.__isShowLiveChances));
       // }, 2000);
    }
    
    public static function UpdateBIChances()
    {
        if (BIChances._BIChances.__isShowLiveChances == undefined)
        {
            return;
        }
        var BIChancesText: String = Chance.GetChanceText(true, false,  BIChances._BIChances.__isShowLiveChances);
      //  if (((BIChancesText != "") && (BIChances._BIChances.__isClearedInterval != "true")) || (BIChances._BIChances.__Count > 5)) {
      //      clearInterval(_BIChances.__intervalID);
       //     BIChances._BIChances.__isClearedInterval = "true";
      //  }
        if BIChancesText == ""
        {
            BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(BIChances._BIChances.__formatStaticTextFirst + '' + BIChances._BIChances.__formatStaticTextSecond);
        }
        else
        {
            BIChances._BIChances.__instance.chances.htmlText = Utils.fixImgTag(formatChanceText(BIChancesText, BIChances._BIChances.__isShowChances, BIChances._BIChances.__isShowLiveChances));
        }
    }
        
    private static function formatChanceText(ChancesText: String, isShowChance, isShowLiveChance: Boolean)
    {
        var temp: Array = ChancesText.split('|', 2);
        var tempA: Array = temp[0].split(':', 2);
        if (isShowChance && isShowLiveChance)
        {
          var tempB: Array = temp[1].split(':', 2);
          return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + '/' + tempB[1] + BIChances._BIChances.__formatStaticTextSecond;
        }
        else
        { 
            if (isShowChance && !isShowLiveChance)
            {
                return BIChances._BIChances.__formatStaticTextFirst + tempA[1] + BIChances._BIChances.__formatStaticTextSecond;
            }	
            else
            {
                var tempB: Array = temp[1].split(':', 2);
                return BIChances._BIChances.__formatStaticTextFirst + tempB[1] + BIChances._BIChances.__formatStaticTextSecond;
            }
        }	
    }

    private static function GetCoordinateXY(align, WidthOrHeight: Number)
    {
    //'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' for vertical
        switch (align)
        {  
            case 'left':  
                return 0;  
            case 'right' :  
                return Stage.width - WidthOrHeight;    
            case 'center':  
                return (Stage.width/2) - (WidthOrHeight/2);  
            case 'top':  
                return 0;  
            case 'bottom':  
                return Stage.height - WidthOrHeight;  
            case 'middle':  
                return (Stage.height/2) - (WidthOrHeight/2);  
        }
    }
    public static function init()  
    {
        BIChances._BIChances.__instance = new BIChances();
    }
}
