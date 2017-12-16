/**
 * Over-target markers. All settings moved to separate files.
 * Маркеры над танками. Все настройки вынесены в отдельные файлы.
 */
{
  "markers": {
    // false - use standard client vehicle markers.
    // false - использовать стандартные маркеры клиента.
    "enabled": false,
    // {{turret}} marker display strings.
    // Отображаемые строки {{turret}} маркера.
    "turretMarkers": {
      // Subject has stock turret and top gun can not be mounted. Subject is highly vulnerable.
      // Субъект имеет стоковую башню и топ орудие не может быть установлено. Субъект сильно уязвим.
      "highVulnerability": "*",
      // Subject has stock turret and top gun can be mounted. Subject is somewhat vulnerable.
      // Субъект имеет стоковую башню и топ орудие может быть установлено. Субъект немного уязвим.
      "lowVulnerability": "'"
    },
    // ally
    // союзники
    "ally": {
      "alive": {
        "normal": ${"markersAliveNormal.xc":"ally"},
        "extended": ${"markersAliveExtended.xc":"ally"}
      },
      "dead": {
        "normal": ${"markersDeadNormal.xc":"ally"},
        "extended": ${"markersDeadExtended.xc":"ally"}
      }
    },
    // enemy
    // противники
    "enemy": {
      "alive": {
        "normal": ${"markersAliveNormal.xc":"enemy"},
        "extended": ${"markersAliveExtended.xc":"enemy"}
      },
      "dead": {
        "normal": ${"markersDeadNormal.xc":"enemy"},
        "extended": ${"markersDeadExtended.xc":"enemy"}
      }
    }
  }
}