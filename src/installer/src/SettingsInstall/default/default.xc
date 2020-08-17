{
  // Название секции может быть любым
  "1battle": {
    // Название пункта, обязательный параметр. Здесь может быть указан ключ из файла перевода. Файлы перевода находятся в \installerXVM\src\SettingsInstall\default\l10n\ секция [CheckListBox].
    "name": "battle_interface",
    // Подробное описание пункта. Здесь может быть указан ключ из файла перевода. Файлы перевода находятся в \installerXVM\src\SettingsInstall\default\l10n\ секция [DescriptionLabel].
    "description": "battle_interface",
    // Задает отображение пункта, как radioButton, checkBox или group. Значение по умолчанию CheckBox
    "itemType": "checkBox",
    // true - пункт выбран. Значение по умолчанию true
    "checked": true,
    // Файл изображения, если выбран пункт. Значение по умолчанию "empty.png" (максимальный размер 370х353)
    "imageIfSelected": "",
    // Файл изображения, если не выбран пункт. Значение по умолчанию "empty.png" (максимальный размер 370х353)
    "imageIfNotSelected": "",
    // Значение, если выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfSelected": "",
    // Секция, если не выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfNotSelected": "",
    // В данной секции настраиваются дочерние пункты TNewCheckListBox
    "children": {
      // Название секции может быть любым
      "01minimap": {
        "name": "minimap",
        "description": "minimap",
        "itemType": "checkBox",
        "checked": true,
        "imageIfSelected": "minimap_true.png",
        "imageIfNotSelected": "minimap_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          // Название секции может быть любым
          "disabledMinimap": {
            // Файл конфигурации в который будут вносится изменения из секции "value"
            "configFileName": "minimap.xc",
            // Значение
            "value": {
              "minimap": { "enabled": false }
            }
          }
        },
        "children": {
          "zoomMinimap": {
            "name": "increase_minimap",
            "description": "increase_minimap",
            "checked": true,
            "imageIfSelected": "minimap_true.png",
            "imageIfNotSelected": "minimap_true.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "centerMinimap": {
                "configFileName": "hotkeys.xc",
                "value": {
                  "hotkeys": {
                    "minimapZoom": { "enabled": false }
                  }
                }
              }
            },
            "children": {
              "zoomMinimapCenter": {
                "name": "increase_center",
                "description": "increase_center",
                "checked": false,
                "imageIfSelected": "minimap_true.png",
                "imageIfNotSelected": "minimap_true.png",
                "valueIfSelected": {
                  "centerMinimap": {
                    "configFileName": "minimap.xc",
                    "value": {
                      "minimap": {
                        "zoom": { "centered": true }
                      }
                    }
                  }
                }
              }
            }
          },
          "minimap_alt_mode": {
            "name": "alt_mode",
            "description": "alt_mode",
            "checked": true,
            "imageIfSelected": "minimap_alt_hp_false.png",
            "imageIfNotSelected": "minimap_alt_hp_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "centerMinimap": {
                "configFileName": "hotkeys.xc",
                "value": {
                  "hotkeys": {
                    "minimapAltMode": { "enabled": false }
                  }
                }
              }
            },
            "children": {
              "hotkey_alt_mode": {
                "name": "hotkey_alt_mode",
                "itemType": "group",
                "children": {
                  "key_l_CTRL": {
                    "name": "key_l_control",
                    "description": "key_l_control",
                    "itemType": "radioButton",
                    "checked": true,
                    "imageIfSelected": "left_CTRL.png",
                    "valueIfSelected": {
                      "sixthSenseEye": {
                        "configFileName": "hotkeys.xc",
                        "value": {
                          "hotkeys": {
                            "minimapAltMode": { "keyCode": 29 }
                          }
                        }
                      }
                    }
                  },
                  "key_l_ALT": {
                    "name": "key_l_ALT",
                    "description": "key_l_ALT",
                    "itemType": "radioButton",
                    "checked": false,
                    "imageIfSelected": "left_ALT.png",
                    "valueIfSelected": {
                      "sixthSenseEye": {
                        "configFileName": "hotkeys.xc",
                        "value": {
                          "hotkeys": {
                            "minimapAltMode": { "keyCode": 56 }
                          }
                        }
                      }
                    }
                  }
                }
              },
              "minimap_alt_hp": {
                "name": "hp_in_alternative_mode",
                "description": "hp_in_alternative_mode",
                "checked": false,
                "imageIfSelected": "minimap_alt_hp_true.png",
                "imageIfNotSelected": "minimap_alt_hp_false.png",
                "valueIfSelected": {
                  "minimap_alt_hp1": {
                    "configFileName": "minimapLabelsAlt.xc",
                    "value": {
                      "labels": {
                        "formats": [
                          ${ "minimapLabelsTemplates.xc":"def.hpLost" },
                          ${ "minimapLabelsTemplates.xc":"def.hpSpotted" }
                        ]
                      }
                    }
                  },
                  "minimap_alt_hp2": {
                    "configFileName": "minimapLabelsTemplates.xc",
                    "value": {
                      "def": {
                        "hpSpotted": {
                          "$ref": { "path":"def.vtypeSpotted" },
                          "enabled": true,
                          "textFormat": { "font": "dynamic2", "size": 20, "align": "center", "valign": "center" },
                          "format": "<font color='{{.minimap.labelsData.colors.dot.{{sys-color-key}}}}'>{{hp-ratio%.335a|&#x1B3;}}</font>"
                        },
                        "hpLost": {
                          "$ref": { "path":"def.vtypeLost" },
                          "textFormat": { "font": "dynamic2", "size": 20, "align": "center", "valign": "center" },
                          "format": "<font color='{{.minimap.labelsData.colors.lostDot.{{sys-color-key}}}}'>{{hp-ratio%.335a|&#x1B3;}}</font>"
                        }
                      }
                    }
                  }
                },
                "valueIfNotSelected": ""
              }
            }
          },
          "minimap_hp": {
            "name": "minimap_hp_in_basic_mode",
            "description": "minimap_hp_in_basic_mode",
            "checked": false,
            "imageIfSelected": "minimap_alt_hp_true.png",
            "imageIfNotSelected": "minimap_alt_hp_false.png",
            "valueIfSelected": {
              "minimap_alt_hp1": {
                "configFileName": "minimapLabels.xc",
                "value": {
                  "labels": {
                    "formats": [
                      ${ "minimapLabelsTemplates.xc":"def.hpLost" },
                      ${ "minimapLabelsTemplates.xc":"def.hpSpotted" }
                    ]
                  }
                }
              },
              "minimap_alt_hp2": {
                "configFileName": "minimapLabelsTemplates.xc",
                "value": {
                  "def": {
                    "hpSpotted": {
                      "$ref": { "path":"def.vtypeSpotted" },
                      "enabled": true,
                      "textFormat": { "font": "dynamic2", "size": 20, "align": "center", "valign": "center" },
                      "format": "<font color='{{.minimap.labelsData.colors.dot.{{sys-color-key}}}}'>{{hp-ratio%.335a|&#x1B3;}}</font>"
                    },
                    "hpLost": {
                      "$ref": { "path":"def.vtypeLost" },
                      "textFormat": { "font": "dynamic2", "size": 20, "align": "center", "valign": "center" },
                      "format": "<font color='{{.minimap.labelsData.colors.lostDot.{{sys-color-key}}}}'>{{hp-ratio%.335a|&#x1B3;}}</font>"
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "13sixthSense": {
        "name": "images_for_sixth_sense",
        "itemType": "group",
        "children": {
          "sixthSenseEye": {
            "name": "eye_Sauron",
            "description": "images_for_sixth_sense",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense_Eye.png",
            "imageIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": [
                  "res_mods/mods/shared_resources/xvm/res/SixthSense_Eye.png"
                ],
                "configFileName": "battle.xc",
                "value": {
                  "battle": { "sixthSenseIcon": "xvm://res/SixthSense_Eye.png" }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "sixthSenseSmile": {
            "name": "smiley",
            "description": "images_for_sixth_sense",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense_Smile.png",
            "imageIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": [
                  "res_mods/mods/shared_resources/xvm/res/SixthSense_Smile.png"
                ],
                "configFileName": "battle.xc",
                "value": {
                  "battle": { "sixthSenseIcon": "xvm://res/SixthSense_Smile.png" }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "sixthSenseXVM": {
            "name": "lamp_XVM",
            "description": "lamp_XVM",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense.png",
            "imageIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": [
                  "res_mods/mods/shared_resources/xvm/res/SixthSense.png"
                ],
                "configFileName": "battle.xc",
                "value": {
                  "battle": { "sixthSenseIcon": "xvm://res/SixthSense.png" }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "sixthSenseDefault": {
            "name": "standard_lamp",
            "description": "images_for_sixth_sense",
            "itemType": "radioButton",
            "checked": true,
            "imageIfSelected": "SixthSenseWG.png",
            "imageIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "configFileName": "battle.xc",
                "value": {
                  "battle": { "sixthSenseIcon": "" }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "14durationSixthSense": {
        "name": "sixth_sense_timer",
        "description": "sixth_sense_timer",
        "checked": false,
        "imageIfSelected": "durationSixthSense_true.png",
        "imageIfNotSelected": "durationSixthSense_false.png",
        "valueIfSelected": {
          "refTimer": {
            // Параметр задает способ изменения конфига. По умолчанию true.
            // true -  значения массива добавляются.
            // false - массив полностью заменяется.
            "isAdd": true,
            // В данном параметре задаются через запятую файлы, которые необходимо скопировать в директорию игры.
            // В данном примере исходный файл расположен "SettingsInstall/default/files/res_mods/configs/xvm/py_macro/sixthSense.py".
            // Если пользователь выбрал данный пункт, то файл будет скопирован в "Каталог_игры/res_mods/configs/xvm/py_macro/sixthSense.py".
            "@files": [
              "res_mods/configs/xvm/py_macro/sixthSense.py"
            ],
            "configFileName": "battleLabels.xc",
            "value": {
              "labels": {
                "formats": [
                  ${ "battleLabelsTemplates.xc":"def.sixthSenseTimer" }
                ]
              }
            }
          },
          "timer": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "sixthSenseTimer": {
                  "enabled": true,
                  "updateEvent": "PY(ON_SIXTH_SENSE_SHOW)",
                  "x": 0,
                  "y": "{{py:sub(-{{py:div({{py:xvm.screenHeight}}, 4)}}, 14)}}",
                  "width": 60,
                  "height": 50,
                  "screenHAlign": "center",
                  "screenVAlign": "center",
                  "textFormat": { "align": "center", "size": 40 },
                  "format": "{{py:xvm.sixthSenseTimer(10)}}"
                }
              }
            }
          },
          "duretionImage": {
            "configFileName": "battle.xc",
            "value": {
              "battle": { "sixthSenseDuration": 10000 }
            }
          }
        },
        "valueIfNotSelected": ""
      },
      "08sight": {
        "name": "sight",
        "description": "sight",
        "itemType": "group",
        "children": {
          "timer_AIM": {
            "name": "time_until_full_notice",
            "description": "time_until_full_notice",
            "checked": false,
            "imageIfSelected": "timer_AIM_true.png",
            "imageIfNotSelected": "timer_AIM_false.png",
            "valueIfSelected": {
              "timer_AIM1": {
                "@files": [
                  "res_mods/configs/xvm/py_macro/aimingSystem.py",
                  "res_mods/configs/xvm/py_macro/beginBattle.py",
                  "res_mods/configs/xvm/py_macro/aiming.py"
                ],
                "configFileName": "battleLabels.xc",
                "value": {
                  "labels": {
                    "formats": [
                      ${ "battleLabelsTemplates.xc":"def.timerAIM" }
                    ]
                  }
                }
              },
              "timer_AIM2": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "timerAIM": {
                      "enabled": true,
                      "updateEvent": "PY(ON_AIM_MODE), PY(ON_AIMING), PY(ON_BEGIN_BATTLE), ON_CURRENT_VEHICLE_DESTROYED",
                      "x": -202,
                      "y": 61,
                      "width": 60,
                      "height": 30,
                      "layer": "bottom",
                      "alpha": "{{py:aim.mode=str?{{py:isBattle?{{alive?100|0}}|0}}|0}}",
                      "screenHAlign": "center",
                      "screenVAlign": "center",
                      "textFormat": { "size": 20, "color": "0x{{py:sight.timeAIM=0?2DC822|FF0000}}" },
                      "format": "{{py:sight.timeAIM%2.1f}}"
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "time_flight": {
            "name": "flight_time_of_shells",
            "description": "flight_time_of_shells",
            "checked": false,
            "imageIfSelected": "time_flight_true.png",
            "imageIfNotSelected": "time_flight_false.png",
            "valueIfSelected": {
              "time_flight1": {
                "@files": [
                  "res_mods/configs/xvm/py_macro/aimingSystem.py",
                  "res_mods/configs/xvm/py_macro/beginBattle.py",
                  "res_mods/configs/xvm/py_macro/markerPosition.py"
                ],
                "configFileName": "battleLabels.xc",
                "value": {
                  "labels": {
                    "formats": [
                      ${ "battleLabelsTemplates.xc":"def.timeFlight" }
                    ]
                  }
                }
              },
              "timeFlight2": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "timeFlight": {
                      "enabled": true,
                      "updateEvent": "PY(ON_AIM_MODE), PY(ON_MARKER_POSITION), PY(ON_BEGIN_BATTLE), ON_CURRENT_VEHICLE_DESTROYED",
                      "x": -202,
                      "y": -61,
                      "width": 60,
                      "height": 30,
                      "layer": "bottom",
                      "alpha": "{{py:aim.mode=str?{{py:isBattle?{{alive?100|0}}|0}}|0}}",
                      "screenHAlign": "center",
                      "screenVAlign": "center",
                      "textFormat": { "size": 20, "color": "0x2DC822" },
                      "format": "{{py:sight.timeFlight%2.1f}} {{l10n:sec}}"
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "02playersPanel": {
        "name": "players_panel",
        "description": "players_panel",
        "checked": true,
        "imageIfSelected": "playersPanel_true.png",
        "imageIfNotSelected": "playersPanel_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "disabledPlayersPanel": {
            "configFileName": "playersPanel.xc",
            "value": {
              "playersPanel": { "enabled": false }
            }
          }
        },
        "children": {
          "statistics": {
            "name": "displaying_statistics",
            "description": "displaying_statistics",
            "checked": true,
            "imageIfSelected": "pp_stat_true.png",
            "imageIfNotSelected": "pp_stat_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "notDisplayStatistic": {
                "configFileName": "playersPanel.xc",
                "value": {
                  "playersPanel": {
                    "medium": {
                      "nickFormatLeft": "<font alpha='{{alive?#FF|#80}}'>{{name%.{{anonym?10|12}}s~..}}</font>{{anonym? <font face='xvm' size='19'>&#x11E;</font>}} <font alpha='#A0'>{{clan}}</font>",
                      "nickFormatRight": "<font alpha='#A0'>{{clan}}</font> <font alpha='{{alive?#FF|#80}}'>{{name%.12s~..}}</font>"
                    },
                    "medium2": {
                      "vehicleFormatLeft": "<font alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
                      "vehicleFormatRight": "<font alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>"
                    },
                    "large": {
                      "nickFormatLeft": "{{name%.{{anonym?12|15}}s~..}}{{anonym? <font face='xvm' size='13'>&#x11E;</font>}}<font alpha='#A0'>{{clan}}</font>",
                      "nickFormatRight": "<font alpha='#A0'>{{clan}}</font>{{name%.15}~..}}"
                    }
                  }
                }
              }
            }
          },
          "hpBar": {
            "name": "hit_points",
            "description": "hit_points",
            "itemType": "group",
            "children": {
              "hitPointsAlt": {
                "name": "hit_points_ALT",
                "description": "hit_points_ALT",
                "checked": true,
                "imageIfSelected": "hp_alt_PP_true.png",
                "imageIfNotSelected": "hp_alt_PP_false.png",
                "valueIfSelected": "",
                "valueIfNotSelected": {
                  "notHitPointsAlt": {
                    "configFileName": "playersPanel.xc",
                    "value": {
                      "def": {
                        "hpBarBg": { "enabled": false },
                        "hpBar": { "enabled": false },
                        "hp": { "enabled": false }
                      }
                    }
                  }
                }
              },
              "hitPointsThin": {
                "name": "hit_points_thin",
                "description": "hit_points_thin",
                "checked": false,
                "imageIfSelected": "",
                "imageIfNotSelected": "",
                "valueIfSelected": {
                  "hitPointsThin": {
                    "configFileName": "playersPanel.xc",
                    "value": {
                      "def": {
                        "hp_thin_bg": { "y": 22, "height": 4, "alpha": 50, "bgColor": "0x555555", "borderColor": "0x000000" },
                        "hp_thin": { "y": 23, "height": 2, "alpha": 100, "bgColor": ${ "colors.xc":"def.al" }
                        }
                      }
                    }
                  }
                },
                "valueIfNotSelected": "",
                "children": {
                  "medium": {
                    "name": "middle_panel_players",
                    "description": "middle_panel_players",
                    "checked": false,
                    "imageIfSelected": "hp_medium_PP_true.png",
                    "imageIfNotSelected": "hp_medium_PP_false.png",
                    "valueIfSelected": {
                      "hitPointsThin": {
                        "configFileName": "playersPanel.xc",
                        "value": {
                          "playersPanel": {
                            "medium": {
                              "extraFieldsLeft": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 72, "width": 100 },
                                { "$ref": { "path": "def.hp_thin" }, "x": 73, "width": "{{hp-ratio:98}}" }
                              ],
                              "extraFieldsRight": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 70, "width": 100 },
                                { "$ref": { "path": "def.hp_thin" }, "bgColor": ${ "colors.xc":"def.en" }, "x": 71, "width": "{{hp-ratio:98}}" }
                              ]
                            }
                          }
                        }
                      }
                    },
                    "valueIfNotSelected": ""
                  },
                  "medium2": {
                    "name": "middle2_panel_players",
                    "description": "middle2_panel_players",
                    "checked": false,
                    "imageIfSelected": "hp_medium2_PP_true.png",
                    "imageIfNotSelected": "hp_medium2_PP_false.png",
                    "valueIfSelected": {
                      "hitPointsThin": {
                        "configFileName": "playersPanel.xc",
                        "value": {
                          "playersPanel": {
                            "medium2": {
                              "extraFieldsLeft": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 48, "width": 72 },
                                { "$ref": { "path": "def.hp_thin" }, "x": 49, "width": "{{hp-ratio:70}}" }
                              ],
                              "extraFieldsRight": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 48, "width": 72 },
                                { "$ref": { "path": "def.hp_thin" }, "bgColor": ${ "colors.xc":"def.en" }, "x": 49, "width": "{{hp-ratio:70}}" }
                              ]
                            }
                          }
                        }
                      }
                    },
                    "valueIfNotSelected": ""
                  },
                  "large": {
                    "name": "large_panel_players",
                    "description": "large_panel_players",
                    "checked": false,
                    "imageIfSelected": "hp_large_PP_true.png",
                    "imageIfNotSelected": "hp_large_PP_false.png",
                    "valueIfSelected": {
                      "hitPointsThin": {
                        "configFileName": "playersPanel.xc",
                        "value": {
                          "playersPanel": {
                            "large": {
                              "extraFieldsLeft": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 72, "width": 190 },
                                { "$ref": { "path": "def.hp_thin" }, "x": 73, "width": "{{hp-ratio:188}}" }
                              ],
                              "extraFieldsRight": [
                                { "$ref": { "path": "def.hp_thin_bg" }, "x": 70, "width": 190 },
                                { "$ref": { "path": "def.hp_thin" }, "bgColor": ${ "colors.xc":"def.en" }, "x": 71, "width": "{{hp-ratio:188}}" }
                              ]
                            }
                          }
                        }
                      }
                    },
                    "valueIfNotSelected": ""
                  }
                }
              }
            }
          }
        }
      },
      "12fragCorrelation": {
        "name": "display_live",
        "description": "display_live",
        "checked": false,
        "imageIfSelected": "showAliveNotFrags_true.png",
        "imageIfNotSelected": "showAliveNotFrags_false.png",
        "valueIfSelected": {
          "showAlive": {
            "configFileName": "battle.xc",
            "value": {
              "fragCorrelation": { "showAliveNotFrags": true }
            }
          }
        },
        "valueIfNotSelected": ""
      },
      "06hitlog": {
        "name": "hitlog",
        "description": "hitlog",
        "checked": true,
        "imageIfSelected": "hitlog_true.png",
        "imageIfNotSelected": "hitlog_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "hitlog_disabled_battleLabels": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "hitLogBody": { "enabled": false }
              }
            }
          },
          "hitlog_disabled": {
            "configFileName": "hitLog.xc",
            "value": {
              "hitLog": { "enabled": false }
            }
          }
        },
        "children": {
          "group_hits": {
            "name": "group_hits",
            "description": "group_hits",
            "checked": true,
            "imageIfSelected": "hitlog_true.png",
            "imageIfNotSelected": "hitlog_group_hits_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "group_hits_false": {
                "configFileName": "hitLog.xc",
                "value": {
                  "hitLog": { "log": { "groupHitsByPlayer": false } }
                }
              }
            }
          },
          "insert_order": {
            "name": "insert_order",
            "description": "insert_order",
            "checked": true,
            "imageIfSelected": "hitlog_true.png",
            "imageIfNotSelected": "hitlog_toEnd_true.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "order": {
                "configFileName": "hitLog.xc",
                "value": {
                  "hitLog": { "log": { "addToEnd": true } }
                }
              }
            }
          }
        }
      },
      "07hitlog_header": {
        "name": "hitlog_header",
        "description": "hitlog_header",
        "checked": true,
        "imageIfSelected": "hitlog_true.png",
        "imageIfNotSelected": "hitlog_header_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "header_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "hitLogHeader": { "enabled": true },
                "totalEfficiency": { "enabled": false }
              }
            }
          }
        },
        "children": {
          "header_new": {
            "name": "header_new",
            "description": "header_new",
            "itemType": "radioButton",
            "checked": true,
            "imageIfSelected": "hitlog_true.png"
          },
          "header_old": {
            "name": "header_old",
            "description": "header_old",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "hitlog_header_old.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "order": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "hitLogHeader": { "enabled": false },
                    "totalEfficiency": { "enabled": true }
                  }
                }
              }
            }
          }
        }
      },
      "04damageLog": {
        "name": "damagelog",
        "description": "damagelog",
        "checked": true,
        "imageIfSelected": "damageLog_true.png",
        "imageIfNotSelected": "damageLog_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "damageLog_disabled": {
            "configFileName": "damageLog.xc",
            "value": {
              "damageLog": { "enabled": false }
            }
          }
        },
        "children": {
          "damageLog_bg": {
            "name": "background",
            "description": "background",
            "checked": false,
            "imageIfSelected": "damageLog_bg_true.png",
            "imageIfNotSelected": "damageLog_true.png",
            "valueIfSelected": {
              "bg_enabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "damageLogBackground": { "enabled": true }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "09totalEfficiency": {
        "name": "panel_efficiency",
        "description": "panel_efficiency",
        "checked": true,
        "imageIfSelected": "totalEfficiency_true.png",
        "imageIfNotSelected": "totalEfficiency_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "te_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "totalEfficiency": { "enabled": false }
              }
            }
          }
        }
      },
      "05repairTime": {
        "name": "timer_repair_modules",
        "description": "timer_repair_modules",
        "checked": true,
        "imageIfSelected": "repairTime_true.png",
        "imageIfNotSelected": "repairTime_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "rt_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "repairTimeEngine": { "enabled": false },
                "repairTimeGun": { "enabled": false },
                "repairTimeTurret": { "enabled": false },
                "repairTimeTracks": { "enabled": false },
                "repairTimeSurveying": { "enabled": false },
                "repairTimeRadio": { "enabled": false }
              }
            }
          }
        }
      },
      "11hp_panel": {
        "name": "indicator_amount_HP_commands",
        "description": "indicator_amount_HP_commands",
        "checked": true,
        "imageIfSelected": "hp_panel_true.png",
        "imageIfNotSelected": "hp_panel_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "hppl_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "totalHP": { "enabled": false }
              }
            }
          }
        },
        "children": {
          "avgDamage": {
            "name": "average_damage_on_current_vehicle",
            "description": "average_damage_on_current_vehicle",
            "checked": true,
            "imageIfSelected": "avgDamage_true.png",
            "imageIfNotSelected": "avgDamage_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "avgDamage_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "avgDamage": { "enabled": false }
                  }
                }
              }
            }
          },
          "mainGun": {
            "name": "damage_to_main_caliber",
            "description": "damage_to_main_caliber",
            "checked": true,
            "imageIfSelected": "mainGun_true.png",
            "imageIfNotSelected": "mainGun_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "mainGun_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "mainGun": { "enabled": false }
                  }
                }
              }
            }
          }
        }
      },
      "15postmortemTips": {
        "name": "panel_after_death",
        "description": "panel_after_death",
        "checked": true,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "pt_disabled": {
            "configFileName": "battle.xc",
            "value": {
              "battle": { "showPostmortemTips": false }
            }
          }
        }
      },
      "10camera": {
        "name": "camera_settings",
        "description": "camera_settings",
        "checked": false,
        "children": {
          "zoomIndicator": {
            "name": "zoom_indicator",
            "description": "zoom_indicator",
            "checked": true,
            "imageIfSelected": "zoomIndicator_true.png",
            "imageIfNotSelected": "zoomIndicator_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "szi_disabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": {
                      "zoomIndicator": { "enabled": false }
                    }
                  }
                }
              }
            }
          },
          "noFlashBang": {
            "name": "red_flash_when_taking_damage",
            "description": "red_flash_when_taking_damage",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "nfb_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": { "noFlashBang": true }
                }
              }
            }
          },
          "hideHint": {
            "name": "tips_siege_mode_SPG_mode",
            "description": "tips_siege_mode_SPG_mode",
            "checked": true,
            "imageIfSelected": "hideHint_true.png",
            "imageIfNotSelected": "hideHint_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "hh_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": { "hideHint": true }
                }
              }
            }
          },
          "noBinoculars": {
            "name": "blackout_sniper_mode",
            "description": "blackout_sniper_mode",
            "checked": true,
            "imageIfSelected": "noBinoculars_false.png",
            "imageIfNotSelected": "noBinoculars_true.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "snb_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": { "noBinoculars": true }
                  }
                }
              }
            }
          },
          "shotRecoilEffect": {
            "name": "effect_of_kickback",
            "description": "effect_of_kickback",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "sre_disabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "arcade": { "shotRecoilEffect": false },
                    "postmortem": { "shotRecoilEffect": false },
                    "strategic": { "shotRecoilEffect": false },
                    "sniper": { "shotRecoilEffect": false }
                  }
                }
              }
            }
          },
          "noCameraLimit": {
            "name": "camera_rotation_limit",
            "description": "camera_rotation_limit",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "ncl_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": {
                      "noCameraLimit": { "enabled": true }
                    }
                  }
                }
              }
            }
          }
        }
      },
      "03markers": {
        "name": "markers_over_vechicle",
        "description": "markers_over_vechicle",
        "checked": true,
        "imageIfSelected": "markers_true.png",
        "imageIfNotSelected": "markers_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "disabledMinimap": {
            "configFileName": "markers.xc",
            "value": {
              "markers": { "enabled": false }
            }
          }
        },
        "children": {
          "stars": {
            "name": "marker_stars",
            "description": "marker_stars",
            "checked": false,
            "imageIfSelected": "marker_stars_true.png",
            "imageIfNotSelected": "marker_stars_false.png",
            "valueIfSelected":  {
              "marker_stars_true": {
                "configFileName": "markersAliveNormal.xc",
                "value": {
                  "def": {
                    "rating": { "x": 52, "format": "&#x21;" }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "16mirroredVehicleIcons": {
        "name": "mirror_vehicle_icons",
        "description": "mirror_vehicle_icons",
        "checked": true,
        "imageIfSelected": "mirroredVehicleIcons_true.png",
        "imageIfNotSelected": "mirroredVehicleIcons_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "disabledMinimap": {
            "configFileName": "battle.xc",
            "value": {
              "battle": { "mirroredVehicleIcons": false }
            }
          }
        }
      }
    }
  },
  "2hangar": {
    "name": "hangar",
    "description": "hangar",
    "checked": true,
    "valueIfSelected": "",
    "valueIfNotSelected": {
      "carousel_disabled": {
        "configFileName": "carousel.xc",
        "value": {
          "carousel": { "enabled": false }
        }
      }
    },
    "children": {
      "widgets": {
        "name": "widgets",
        "description": "widgets",
        "checked": true,
        "children": {
          "clock_widgets": {
            "name": "clock",
            "description": "clock",
            "checked": true,
            "imageIfSelected": "clock_true.png",
            "imageIfNotSelected": "clock_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "clock_disabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "clock": { "enabled": false }
                }
              }
            }
          },
          "statistics_widgets": {
            "name": "account_stats",
            "description": "account_stats",
            "checked": true,
            "imageIfSelected": "statistics_true.png",
            "imageIfNotSelected": "statistics_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "statistics_disabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "statistics": { "enabled": false }
                }
              }
            }
          }
        }
      },
      "carousel": {
        "name": "carousel",
        "description": "carousel",
        "checked": true,
        "imageIfSelected": "carousel_true.png",
        "imageIfNotSelected": "carousel_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "carousel_disabled": {
            "configFileName": "carousel.xc",
            "value": {
              "carousel": { "enabled": false }
            }
          }
        }
      },
      "pingServers": {
        "name": "ping_servers",
        "description": "ping_servers",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "ping_login": {
            "name": "on_login_screen",
            "description": "on_login_screen",
            "checked": false,
            "imageIfSelected": "ping_login_true.png",
            "imageIfNotSelected": "ping_login_false.png",
            "valueIfSelected": {
              "ping_enabled": {
                "configFileName": "login.xc",
                "value": {
                  "login": {
                    "pingServers": { "enabled": true }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "ping_hangar": {
            "name": "in_hangar",
            "description": "in_hangar",
            "checked": false,
            "imageIfSelected": "ping_hangar_true.png",
            "imageIfNotSelected": "ping_hangar_false.png",
            "valueIfSelected": {
              "ping_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "pingServers": { "enabled": true }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "onlineServers": {
        "name": "online_servers",
        "description": "online_servers",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "online_login": {
            "name": "on_login_screen",
            "checked": false,
            "imageIfSelected": "online_login_true.png",
            "imageIfNotSelected": "online_login_false.png",
            "valueIfSelected": {
              "online_enabled": {
                "configFileName": "login.xc",
                "value": {
                  "login": {
                    "onlineServers": { "enabled": true }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "online_hangar": {
            "name": "in_hangar",
            "description": "in_hangar",
            "checked": false,
            "imageIfSelected": "online_hangar_true.png",
            "imageIfNotSelected": "online_hangar_false.png",
            "valueIfSelected": {
              "online_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "onlineServers": { "enabled": true }
                  }
                }
              },
              "move_clock": {
                "isAdd": false,
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "clock": {
                    "formats": [
                      {
                        "updateEvent": "ON_EVERY_SECOND",
                        "x": -315,
                        "y": 80,
                        "width": 200,
                        "height": 50,
                        "screenHAlign": "right",
                        "shadow": { "enabled": true, "alpha": 70, "blur": 4, "strength": 2 },
                        "textFormat": { "align": "right", "valign": "bottom", "color": "0xF3F3EB" },
                        "format": "<font face='$FieldFont'><textformat leading='-38'><font size='36'>{{py:xvm.formatDate('%H:%M')}}</font><br></textformat><textformat rightMargin='85' leading='-2'>{{py:xvm.formatDate('%A')}}<br><font size='15'>{{py:xvm.formatDate('%d %b %Y')}}</font></textformat></font>"
                      }
                    ]
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "1saveLastServer": {
        "name": "save_last_server",
        "description": "save_last_server",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": {
          "sls_enabled": {
            "configFileName": "login.xc",
            "value": {
              "login": { "saveLastServer": true }
            }
          }
        },
        "valueIfNotSelected": ""
      },
      "autologin": {
        "name": "automatic_login_to_game",
        "description": "automatic_login_to_game",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": {
          "autologin_enabled": {
            "configFileName": "login.xc",
            "value": {
              "login": { "autologin": true }
            }
          }
        },
        "valueIfNotSelected": ""
      },
      "premiumButton": {
        "name": "buy_premium_button",
        "description": "buy_premium_button",
        "checked": true,
        "imageIfSelected": "premium_button_true.png",
        "imageIfNotSelected": "buy_premium_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "premiumButtonHide": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": { "showBuyPremiumButton": false }
            }
          }
        }
      },
      "premiumShopButton": {
        "name": "premium_shop_button",
        "description": "premium_shop_button",
        "checked": true,
        "imageIfSelected": "premium_button_true.png",
        "imageIfNotSelected": "premium_shop_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "premiumShopButtonHide": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": { "showPremiumShopButton": false }
            }
          }
        }
      },
      "promoPremVehicle": {
        "name": "promo_of_premium_vehicle",
        "description": "promo_of_premium_vehicle",
        "checked": true,
        "imageIfSelected": "promo_vehicle_true.png",
        "imageIfNotSelected": "promo_vehicle_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "promoPremVehicleHide": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": { "showPromoPremVehicle": false }
            }
          }
        }
      },
      "customizationCounter": {
        "name": "customize_counter",
        "description": "customize_counter",
        "checked": true,
        "imageIfSelected": "customize_counter_true.png",
        "imageIfNotSelected": "customize_counter_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "customizationCounterHide": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": { "showCustomizationCounter": false }
            }
          }
        }
      },
      "crewAutoReturn": {
        "name": "crew_auto_return",
        "description": "crew_auto_return",
        "checked": true,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected":  {
          "crewAutoReturnDisabled": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": { "enableCrewAutoReturn": false }
            }
          }
        }
      },
      "crewReturnByDefault": {
        "name": "crew_return_default",
        "description": "crew_return_default",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected":  {
          "crewReturnByDefaultDisabled": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": {"crewReturnByDefault": true}
            }
          }
        },
        "valueIfNotSelected": ""
      },
      "lockers": {
        "name": "lockers",
        "description": "lockers",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "gold_locker": {
            "name": "gold_locker",
            "description": "gold_locker",
            "checked": false,
            "imageIfSelected": "gold_locker_true.png",
            "imageIfNotSelected": "locker_false.png",
            "valueIfSelected": {
              "gold_locker_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "enableGoldLocker": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "free_xp_locker": {
            "name": "free_xp_locker",
            "description": "free_xp_locker",
            "checked": false,
            "imageIfSelected": "free_xp_locker_true.png",
            "imageIfNotSelected": "locker_false.png",
            "valueIfSelected": {
              "free_xp_locker_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "enableFreeXpLocker": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "crystal_locker": {
            "name": "crystal_locker",
            "description": "crystal_locker",
            "checked": false,
            "imageIfSelected": "crystal_locker_true.png",
            "imageIfNotSelected": "locker_false.png",
            "valueIfSelected": {
              "crystal_locker_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "enableCrystalLocker": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      }
    }
  },
  "3color_theme": {
    "name": "color_scheme",
    "description": "color_scheme",
    "itemType": "group",
    "checked": false,
    "children": {
      "color_blindness": {
        "name": "color_blindness",
        "description": "color_blindness",
        "checked": false,
        "imageIfSelected": "color_blindness_true.png",
        "imageIfNotSelected": "color_blindness_false.png",
        "valueIfSelected": {
          "cb_login": {
            "@files": [
              "res_mods/mods/shared_resources/xvm/res/icons/carousel/damage.png"
            ],
            "configFileName": "login.xc",
            "value": {
              "login": {
                "pingServers": {
                  "fontStyle": {
                    "color": { "bad": "0x3399CC" }
                  }
                },
                "onlineServers": {
                  "fontStyle": {
                    "color": { "bad": "0x3399CC" }
                  }
                }
              }
            }
          },
          "cb_hangar": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": {
                "pingServers": {
                  "fontStyle": {
                    "color": { "bad": "0x3399CC" }
                  }
                },
                "onlineServers": {
                  "fontStyle": {
                    "color": { "bad": "0x3399CC" }
                  }
                }
              }
            }
          },
          "cb_mm_circles": {
            "configFileName": "minimapCircles.xc",
            "isAdd": false,
            "value": {
              "circles": {
                "view": [
                  { "enabled":  true, "distance": "blindarea", "scale": 1, "thickness": 0.75, "alpha": 80, "color": "0x3EB5F1" },
                  { "enabled":  true, "distance": 445,         "scale": 1, "thickness":  1.1, "alpha": 45, "color": "0xFFCC66" },
                  { "enabled": "{{my-vtype-key=SPG?false|true}}", "distance": 564, "scale": 1, "thickness": 0.7, "alpha": 40, "color": "0xFFFFFF" },
                  { "enabled": true, "distance": 50,           "scale": 1, "thickness": 0.75, "alpha": 60, "color": "0xFFFFFF" },
                  { "enabled": false, "distance": "standing",  "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x887EFF" },
                  { "enabled": false, "distance": "motion",    "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x0000FF" },
                  { "enabled": false, "distance": "dynamic",   "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x3EB5F1" }
                ],
                "artillery": { "enabled": true, "alpha": 55, "color": "0x3C3C6D", "thickness": 0.5 },
                "shell": { "enabled": true, "alpha": 55, "color": "0x3C3C6D", "thickness": 0.5 }
              }
            }
          },
          "cb_mm_labels": {
            "configFileName": "minimapLabelsData.xc",
            "value": {
              "labelsData": {
                "colors": {
                  "txt": {
                    "enemy_alive": "#A8A4D7",
                    "enemy_dead": "#7F90A8",
                    "enemy_blowedup": "#7F90A8"
                  },
                  "dot": {
                    "enemy_alive": "#F50800",
                    "enemy_dead": "#47407A",
                    "enemy_blowedup": "#47407A"
                  },
                  "lostDot": {
                    "enemy_alive": "#A4ACD6",
                    "enemy_dead": "#47407A",
                    "enemy_blowedup": "#47407A"
                  }
                }
              }
            }
          },
          "damageLog_bg": {
            "configFileName": "damageLog.xc",
            "@files": [
              "res_mods/mods/shared_resources/xvm/res/icons/damageLog/cb_dmg.png"
            ],
            "value": {
              "damageLog": {
                "logBackground": {
                  "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|cb_dmg}}.png'>"
                },
                "logAltBackground": {
                  "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|cb_dmg}}.png'>"
                }
              }
            }
          },
          "cb_colors": {
            "configFileName": "colors.xc",
            "@files": [
              "res_mods/configs/xvm/py_macro/systemColor.py"
            ],
            "value": {
              "def": {
                "en": "0x8379FE",
                "colorRating": { "very_bad": "0x9C3E00" },
                "colorHP": { "very_low": "0x3355CC", "low": "0x3399CC" }
              },
              "colors": {
                "system": {
                  "enemy_dead": "0x47407A",
                  "enemy_blowedup": "0x3B365F"
                },
                "dmg_kind": { "fire": "0x756CE0" },
                "vtype": { "HT": "0x3399CC" }
              }
            }
          }
        },
        "valueIfNotSelected": ""
      }
    }
  },
  "4sounds": {
    "name": "sounds",
    "description": "sounds",
    "itemType": "checkBox",
    "checked": true,
    "imageIfSelected": "",
    "imageIfNotSelected": "",
    "valueIfSelected": "",
    "valueIfNotSelected": {
      "clock_disabled": {
        "configFileName": "sounds.xc",
        "value": {
          "sounds": { "enabled": false }
        }
      }
    },
    "children": {
      "sixthSense": {
        "name": "sixth_sense",
        "description": "sixth_sense",
        "checked": true,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        // Имя звукового файла (mp3, ogg), который будет проигран, если пункт выбран. Значение по умолчанию ""
        "soundIfSelected": "sixthSenseXVM.mp3",
        // Имя звукового файла (mp3, ogg), который будет проигран, если пункт не выбран. Значение по умолчанию ""
        "soundIfNotSelected": "sixthSenseWoT_1.mp3",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "sixthSense_disabled": {
            "configFileName": "sounds.xc",
            "value": {
              "sounds": {
                "soundMapping": {
                  "lightbulb": "lightbulb",
                  "lightbulb_02": "lightbulb_02",
                  "sixthSense": "sixthSense",
                  "xvm_sixthSense": "",
                  "xvm_sixthSenseRudy": "",
                }
              }
            }
          }
        }
      }
    }
  }
}
