/**
 * @author ilitvinov87@gmail.com
 * @author Pavel Máca
 * @author Mr.A
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
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
        return localizedData[localizedMapName.toUpperCase()] || undefined;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private static var _systemMapnameList:Object =
    {
        $00_tank_tutorial:      { size: 100 }, // (Tutorial)
        $01_karelia:            { size: 100 }, // Karelia
        $02_malinovka:          { size: 100 }, // Malinovka
        $03_campania:           { size: 60 },  // Province
        $04_himmelsdorf:        { size: 70 },  // Himmelsdorf
        $05_prohorovka:         { size: 100 }, // Prokhorovka
        $06_ensk:               { size: 60 },  // Ensk
        $07_lakeville:          { size: 80 },  // Lakeville
        $08_ruinberg:           { size: 80 },  // Ruinberg
        $10_hills:              { size: 80 },  // Mines
        $11_murovanka:          { size: 100 }, // Murovanka
        $13_erlenberg:          { size: 100 }, // Erlenberg
        $14_siegfried_line:     { size: 100 }, // Siegfried Line
        $15_komarin:            { size: 80 },  // Komarin
        $17_munchen:            { size: 60 },  // Widepark
        $18_cliff:              { size: 100 }, // Cliff
        $19_monastery:          { size: 100 }, // Abbey
        $22_slough:             { size: 100 }, // Swamp
        $23_westfeld:           { size: 100 }, // Westfield
        $28_desert:             { size: 100 }, // Sand River
        $29_el_hallouf:         { size: 100 }, // El Halluf
        $31_airfield:           { size: 100 }, // Airfield
        $33_fjord:              { size: 100 }, // Fjords
        $34_redshire:           { size: 100 }, // Redshire
        $35_steppes:            { size: 100 }, // Steppes
        $36_fishing_bay:        { size: 100 }, // Fisherman's Bay
        $37_caucasus:           { size: 100 }, // Mountain Pass
        $38_mannerheim_line:    { size: 100 }, // Arctic Region
        $39_crimea:             { size: 100 }, // South Coast
        $43_north_america:      { size: 100 }, // Northwest
        $44_north_america:      { size: 100 }, // Live Oaks
        $45_north_america:      { size: 100 }, // Highway
        $47_canada_a:           { size: 100 }, // Serene Coast
        $51_asia:               { size: 100 }, // Dragon Ridge
        $53_japan:              { size: 100 }, // Hidden Village
        $59_asia_great_wall:    { size: 100 }, // Empire's Border
        $60_asia_miao:          { size: 100 }, // Pearl River
        $63_tundra:             { size: 80 },  // Tundra
        $73_asia_korea:         { size: 100 }, // Sacred Valley
        $83_kharkiv:            { size: 80 },  // Kharkiv
        $84_winter:             { size: 100 }, // Windstorm
        $86_himmelsdorf_winter: { size: 70 },  // Winter Himmelsdorf
        $92_stalingrad:         { size: 95 },  // Stalingrad
        $95_lost_city:          { size: 80 },  // Lost City
        $96_prohorovka_defense: { size: 100 }, // Fiery Salient
        $100_thepit:            { size: 60 },  // The Pit
        $103_ruinberg_winter:   { size: 80 },  // Winter Ruinberg
        $109_battlecity_ny:     { size: 50 },  // Battle City
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
        //var start = (new Date()).getTime();
        _localizedMapnameList = { };
        for (var key:String in _systemMapnameList) {
            var systemMapName:String = key.substring(1);
            var localMapName:String = Localization.makeString("#arenas:" + systemMapName + "/name", {});
            _localizedMapnameList[localMapName.toUpperCase()] = _systemMapnameList[key].size;
        }
        //Logger.add(((new Date()).getTime() - start).toString());
    }
}
