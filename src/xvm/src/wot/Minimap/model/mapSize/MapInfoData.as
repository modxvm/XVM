/**
 * @author Assassik
 * @author Mr.A
 */
import com.xvm.Logger;
import net.wargaming.managers.Localization;

class wot.Minimap.model.mapSize.MapInfoData
{
    private static var systemMapnameList:Object;
    private static var localizedMapnameList:Object;
    
    /**
     * @param localized mapname
     * @return map size
     */
    public static function SizeByLocalizedMapName(localizedMapName:String):Number
    {
        getData();
        return localizedMapnameList[localizedMapName] || undefined;
    }

    private static function setupData():Void
    {
        systemMapnameList = new Object();

        //systemMapnameList["00_tank_tutorial"] =  { size: };
        systemMapnameList["01_karelia"] =          { size: 100 }; // Карелия
        systemMapnameList["02_malinovka"] =        { size: 100 }; // Малиновка
        systemMapnameList["03_campania"] =         { size: 60 };  // Провинция
        systemMapnameList["04_himmelsdorf"] =      { size: 70 };  // Химмельсдорф
        systemMapnameList["05_prohorovka"] =       { size: 100 }; // Прохоровка
        systemMapnameList["06_ensk"] =             { size: 60 };  // Энск
        systemMapnameList["07_lakeville"] =        { size: 80 };  // Ласвилль
        systemMapnameList["08_ruinberg"] =         { size: 80 };  // Руинберг
        systemMapnameList["10_hills"] =            { size: 80 };  // Рудники
        systemMapnameList["11_murovanka"] =        { size: 80 };  // Мурованка
        systemMapnameList["13_erlenberg"] =        { size: 100 }; // Эрленберг
        systemMapnameList["14_siegfried_line"] =   { size: 100 }; // Линия Зигфрида
        systemMapnameList["15_komarin"] =          { size: 80 };  // Комарин
        systemMapnameList["17_munchen"] =          { size: 60 };  // Уайдпарк
        systemMapnameList["18_cliff"] =            { size: 100 }; // Утёс
        systemMapnameList["19_monastery"] =        { size: 100 }; // Монастырь
        systemMapnameList["23_westfeld"] =         { size: 100 }; // Вестфилд
        systemMapnameList["28_desert"] =           { size: 100 }; // Песчаная река
        systemMapnameList["29_el_hallouf"] =       { size: 100 }; // Эль-Халлуф
        systemMapnameList["31_airfield"] =         { size: 100 }; // Аэропорт
        systemMapnameList["33_fjord"] =            { size: 100 }; // Фьорды
        systemMapnameList["34_redshire"] =         { size: 100 }; // Редшир
        systemMapnameList["35_steppes"] =          { size: 100 }; // Степи
        systemMapnameList["36_fishing_bay"] =      { size: 100 }; // Рыбацкая бухта
        systemMapnameList["37_caucasus"] =         { size: 100 }; // Перевал
        systemMapnameList["38_mannerheim_line"] =  { size: 100 }; // Заполярье
        systemMapnameList["39_crimea"] =           { size: 100 }; // Южный берег
        systemMapnameList["42_north_america"] =    { size: 83 };  // Порт
        systemMapnameList["44_north_america"] =    { size: 100 }; // Лайв Окс
        systemMapnameList["45_north_america"] =    { size: 100 }; // Хайвей
        systemMapnameList["47_canada_a"] =         { size: 100 }; // Тихий берег
        systemMapnameList["51_asia"] =             { size: 100 }; // Хребет дракона
        systemMapnameList["60_asia_miao"] =        { size: 100 }; // Жемчужная река
        systemMapnameList["73_asia_korea"] =       { size: 100 }; // Священная долина
        systemMapnameList["85_winter"] =           { size: 100 }; // Белогорск-19

        localizedMapnameList = new Object();

        Logger.add((new Date()).getTime().toString());
        for (var systemMapName:String in systemMapnameList) {
            var localMapName:String = Localization.makeString("#arenas:" + systemMapName + "/name", {});
            localizedMapnameList[localMapName] = systemMapnameList[systemMapName].size;
        }
        Logger.add((new Date()).getTime().toString());
    }

    private static function getData():Object
    {
        if (!localizedMapnameList) 
            setupData();
        return localizedMapnameList;
    }
}