/**
 * Parameters for login screen
 * Параметры экрана логина
 */
{
  "login": {
    // Skip intro movie
    // Пропустить вступительное видео
    "skipIntro": true,
    // Auto enter to the game
    // Автоматический вход в игру
    "autologin": false,
    // Ping servers; works only with xvm-stat.exe
    // Пинг серверов; работает только с xvm-stat.exe
    "pingServers": {
      "$ref": { "file": "hangar.xc", "path": "hangar.pingServers" },
      // true - Show ping to the servers
      // true - показывать пинг до серверов
      "enabled": false,
      // Axis field coordinates
      // Положение поля по осям
      "x": 5,
      "y": 30
    }
  }
}
