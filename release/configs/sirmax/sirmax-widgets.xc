{
  "widgets": {
    "login": [
    ],
    "lobby": [
      ${ "../default/widgetsTemplates.xc":"statistics" },
      ${ "../default/widgetsTemplates.xc":"clock" }
      /*
      ,{
        "enabled": true,
        "layer": "normal",
        "type": "extrafield",
        "formats": [
          {
            "updateEvent": "ON_EVERY_SECOND",
            "x": -300,
            "y": 50,
            "width": 200,
            "height": 400,
            "screenHAlign": "right",
            "textFormat": { "align": "right", "valign": "bottom", "color": "0x959688" },
            "format": "<font face='$FieldFont' size='10'>player_id: {{mystat.player_id}}<br>name: {{mystat.name}}<br>flag: {{mystat.flag}}<br>clan: {{mystat.clan}}<br>clan_id: {{mystat.clan_id}}<br>winrate: {{mystat.winrate}}<br>eff: <font color='{{mystat.c_xeff}}'>{{mystat.eff}}</font><br>wgr: <font color='{{mystat.c_xwgr}}'>{{mystat.wgr}}</font><br>wtr: <font color='{{mystat.c_xwtr}}'>{{mystat.wtr}}</font><br>wn8: <font color='{{mystat.c_xwn8}}'>{{mystat.wn8}}</font><br>xeff: {{mystat.xeff}}<br>xwgr: {{mystat.xwgr}}<br>xwtr: {{mystat.xwtr}}<br>xwn8: {{mystat.xwn8}}<br>lvl: {{mystat.lvl}}<br>battles: {{mystat.battles}}<br>wins: {{mystat.wins}}<br>def: {{mystat.def}}<br>frg: {{mystat.frg}}<br>dmg: {{mystat.dmg}}<br>cap: {{mystat.cap}}<br>hip: {{mystat.hip}}<br>spo: {{mystat.spo}}<br>ts: {{mystat.ts}}</font>"
          }
        ]
      }
      */
    ]
  }
}
