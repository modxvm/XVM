intrinsic class net.wargaming.hangar.FinalStatistic.view.DetailsBlock extends gfx.core.UIComponent
{
    var xpTitleLbl: TextField;
    var xpLbl: TextField;
    var premXpLbl: TextField;
    var _dataDirty;

    function draw();
    
/*
    var _data, invalidate, __get__data, noPremTitleLbl, premTitleLbl, creditsLbl, xpLbl, premCreditsLbl, premXpLbl, buyPremiumBtn, xpTitleLbl, _parent, damLbl, premDamLbl, shots1bl, shots2Lbl, shots3Lbl, damageAssisted1Lbl, damageAssisted2Lbl, damageAssisted3Lbl, damage1Lbl, damage2Lbl, damage3Lbl, __set__data;
    function DetailsBlock()
    {
        super();
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function set data(value)
    {
        _data = value;
        _dataDirty = true;
        this.invalidate();
        //return (this.data());
        null;
    } // End of the function
    function configUI()
    {
        super.configUI();
        noPremTitleLbl.text = "#battle_results:common/details/noPremTitle";
        premTitleLbl.text = "#battle_results:common/details/premTitle";
    } // End of the function
    function draw()
    {
        super.draw();
        if (_dataDirty)
        {
            noPremTitleLbl._alpha = this.__get__data().isPremium ? (25) : (100);
            premTitleLbl._alpha = this.__get__data().isPremium ? (25) : (100);
            creditsLbl._alpha = this.__get__data().isPremium ? (25) : (100);
            xpLbl._alpha = this.__get__data().isPremium ? (25) : (100);
            premTitleLbl._alpha = this.__get__data().isPremium ? (100) : (25);
            premCreditsLbl._alpha = this.__get__data().isPremium ? (100) : (25);
            premXpLbl._alpha = this.__get__data().isPremium ? (100) : (25);
            buyPremiumBtn.__set__visible(false);
            xpTitleLbl.text = this.__get__data().xpTitleStr;
            xpLbl.htmlText = this.__get__data().xpNoPremStr;
            premXpLbl.htmlText = this.__get__data().xpPremStr;
            creditsLbl.htmlText = this.__get__data().creditsNoPremStr;
            premCreditsLbl.htmlText = this.__get__data().creditsPremStr;
            var _loc6 = _parent._parent._parent._parent.__get__data();
            var _loc13 = _loc6.personal.xpData;
            var _loc9 = _loc6.personal.creditsData;
            creditsLbl.htmlText = _loc9[_loc9.length - 1].col1;
            premCreditsLbl.htmlText = _loc9[_loc9.length - 1].col3;
            damLbl.alpha = this.__get__data().isPremium ? (25) : (100);
            premDamLbl.alpha = this.__get__data().isPremium ? (25) : (100);
            var _loc4 = _loc6.team1;
            var _loc5 = 0;
            for (var _loc3 = 0; _loc3 < 15; ++_loc3)
            {
                if (_loc4[_loc3].playerName == _loc6.common.playerNameStr)
                {
                    _loc5 = _loc3;
                    break;
                } // end if
            } // end of for
            var _loc11 = _loc4[_loc5].damageDealt;
            var _loc10 = _loc4[_loc5].damageAssisted;
            var _loc8 = _loc11.toString();
            if (_loc11 >= 1000)
            {
                _loc8 = _loc8.substr(0, _loc8.length - 3) + " " + _loc8.substr(_loc8.length - 3, 3);
            } // end if
            var _loc7 = _loc10.toString();
            if (_loc10 >= 1000)
            {
                _loc7 = _loc7.substr(0, _loc7.length - 3) + " " + _loc7.substr(_loc7.length - 3, 3);
            } // end if
            var _loc12 = int(_loc4[_loc5].hits / _loc4[_loc5].shots * 100);
            shots1bl.htmlText = "<FONT color=\'#C9C9B6\'>Процент попаданий</FONT>";
            shots2Lbl.htmlText = "<FONT color=\'#C9C9B6\'>" + _loc4[_loc5].hits + " / " + _loc4[_loc5].shots + "</FONT>";
            shots3Lbl.htmlText = "<FONT color=\'#eeeeee\'>" + _loc12 + "%" + "</FONT>";
            damageAssisted1Lbl.htmlText = "<FONT color=\'#C9C9B6\'>Урон по разведданым</FONT>";
            damageAssisted2Lbl.htmlText = "";
            damageAssisted3Lbl.htmlText = "<FONT color=\'#408ccf\'>" + _loc7 + "</FONT>";
            damage1Lbl.htmlText = "<FONT color=\'#C9C9B6\'>Нанесенный Урон</FONT>";
            damage2Lbl.htmlText = "";
            damage3Lbl.htmlText = "<FONT color=\'#ffc133\'>" + _loc8 + "</FONT>";
            _dataDirty = false;
        } // end if
    } // End of the function
    var _dataDirty = false;
    */
}
