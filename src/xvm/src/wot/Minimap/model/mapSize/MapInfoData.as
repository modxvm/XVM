/**
 * @author ilitvinov87@gmail.com
 * @author Assassik
 * @author Mr.A
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Logger;
import net.wargaming.managers.Localization;

class wot.Minimap.model.mapSize.MapInfoData
{
    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    /**
     * @param localized mapname
     * @return map size
     */
    public static function SizeByLocalizedMapName(localizedMapName:String):Number
    {
        return localizedData[localizedMapName] || undefined;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE
    
    private static var _systemMapnameList:Object = 
    {
        //$00_tank_tutorial
        $01_karelia:          { size: 100 }, // Карелия         -- FIXIT: Remove russian from sources // sirmax
        $02_malinovka:        { size: 100 }, // Малиновка
        $03_campania:         { size: 60 },  // Провинция
        $04_himmelsdorf:      { size: 70 },  // Химмельсдорф
        $05_prohorovka:       { size: 100 }, // Прохоровка
        $06_ensk:             { size: 60 },  // Энск
        $07_lakeville:        { size: 80 },  // Ласвилль
        $08_ruinberg:         { size: 80 },  // Руинберг
        $10_hills:            { size: 80 },  // Рудники
        $11_murovanka:        { size: 80 },  // Мурованка
        $13_erlenberg:        { size: 100 }, // Эрленберг
        $14_siegfried_line:   { size: 100 }, // Линия Зигфрида
        $15_komarin:          { size: 80 },  // Комарин
        $17_munchen:          { size: 60 },  // Уайдпарк
        $18_cliff:            { size: 100 }, // Утёс
        $19_monastery:        { size: 100 }, // Монастырь
        $23_westfeld:         { size: 100 }, // Вестфилд
        $28_desert:           { size: 100 }, // Песчаная река
        $29_el_hallouf:       { size: 100 }, // Эль-Халлуф
        $31_airfield:         { size: 100 }, // Аэропорт
        $33_fjord:            { size: 100 }, // Фьорды
        $34_redshire:         { size: 100 }, // Редшир
        $35_steppes:          { size: 100 }, // Степи
        $36_fishing_bay:      { size: 100 }, // Рыбацкая бухта
        $37_caucasus:         { size: 100 }, // Перевал
        $38_mannerheim_line:  { size: 100 }, // Заполярье
        $39_crimea:           { size: 100 }, // Южный берег
        $42_north_america:    { size: 83 },  // Порт
        $44_north_america:    { size: 100 }, // Лайв Окс
        $45_north_america:    { size: 100 }, // Хайвей
        $47_canada_a:         { size: 100 }, // Тихий берег
        $51_asia:             { size: 100 }, // Хребет дракона
        $60_asia_miao:        { size: 100 }, // Жемчужная река
        $73_asia_korea:       { size: 100 }, // Священная долина
        $85_winter:           { size: 100 }, // Белогорск-19
        __end__: null
    }

    private static var _localizedMapnameList:Object;
    
    private static function get localizedData():Object
    {
        if (_localizedMapnameList == null) 
            setupData();
        return _localizedMapnameList;
    }

    private static function setupData():Void
    {
        //var start = new Date();
        _localizedMapnameList = { };
        for (var key:String in _systemMapnameList) {
            var systemMapName:String = key.substring(1);
            var localMapName:String = Localization.makeString("#arenas:" + systemMapName + "/name", {});
            _localizedMapnameList[localMapName] = _systemMapnameList[systemMapName].size;
        }
        //Logger.add(com.xvm.Utils.elapsedMSec(start, new Date()).toString());
    }
}