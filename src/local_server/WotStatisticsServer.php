<?php

require_once("HTTP/WebDAV/Server.php");

class WotStatisticsServer extends HTTP_WebDAV_Server {
  const MAX_STATISTICS_SERVER_WAIT_TIME = 5;
  const TIMEOUT_WAIT_TIME = 60;
  const CACHE_FILE_LIVE_TIME = 1209600;  //=14*24*60*60 - 14 days

  const COMMAND_LOG = "@LOG";
  const COMMAND_SET_IDS = "@SET_IDS ";
  const COMMAND_ADD_IDS = "@ADD_IDS ";
  const COMMAND_GET_IDS = "@GET_IDS";
  const COMMAND_RUN_IDS = "@RUN_IDS";
  const COMMAND_SET_NAMES = "@SET_NAMES ";
  const COMMAND_ADD_NAMES = "@ADD_NAMES ";
  const COMMAND_GET_NAMES = "@GET_NAMES";
  const COMMAND_RUN_NAMES = "@RUN_NAMES";
  const COMMAND_GET_LAST_STAT = "@GET_LAST_STAT";

  private $_cached_statistics = array();
  private $set_timeout_enabled = true;

  function ServeRequest() {
    // special treatment for litmus compliance test
    // reply on its identifier header
    // not needed for the test itself but eases debugging
    if (isset($this->_SERVER['HTTP_X_LITMUS'])) {
      $this->log("Litmus test ".$this->_SERVER['HTTP_X_LITMUS']);
      header("X-Litmus-reply: ".$this->_SERVER['HTTP_X_LITMUS']);
    };

    parent::ServeRequest();
  }

  function check_auth($type, $user, $pass) {
    return true;
  }

  function fileinfo($path) {
    $info = array();
    $info["path"]  = $path;
    $info["props"] = array();
    $info["props"][] = $this->mkprop("displayname", strtoupper($path));
    $info["props"][] = $this->mkprop("creationdate",    time());
    $info["props"][] = $this->mkprop("getlastmodified", time());
    $info["props"][] = $this->mkprop("lastaccessed",    time());
    $info["props"][] = $this->mkprop("ishidden", ('.' === substr(basename($fspath), 0, 1)));

    if ($path == '/') {
      $info["props"][] = $this->mkprop("resourcetype", "collection");
      $info["props"][] = $this->mkprop("getcontenttype", "httpd/unix-directory");
    } else {
      // plain file (WebDAV resource)
      $info["props"][] = $this->mkprop("resourcetype", "");
      $info["props"][] = $this->mkprop("getcontenttype", "text/plain");
      $info["props"][] = $this->mkprop("getcontentlength", strlen($this->get_statistics_contents($path, 'fileinfo')));
    };

    return $info;
  }

  function PROPFIND(&$options, &$files) {
    //if ($options['path'] != "/")
    //  $this->log(sprintf("PROPFIND: %s\n", $options['path']));
    //$this->log(print_r($options, true));

    $files['files'] = array();
    $files['files'][] = $this->fileinfo($options['path']);

    //$this->log(print_r($files, true));

    return true;
  }

  function HEAD(&$options) {
    $this->log("HEAD\n");

    if (!$statistics_data = $this->get_statistics_contents($options['path'], 'HEAD')) {
      return false;
    };

    $options['mimetype'] = 'text/plain';
    $options['mtime'] = time();
    $options['size'] = strlen($statistics_data);

    return true;
  }

  /**
   * GET method handler
   *
   * @param  array  parameter passing array
   * @return bool   true on success
   */
  function GET(&$options) {
    if ($options['path'][1] != "@")
      $this->log("GET\n");

    // the header output is the same as for HEAD
    // do not call HEAD for avoiding unnecessary call
    if (!$statistics_data = $this->get_statistics_contents($options['path'], 'GET')) {
      return false;
    };

    $options['mimetype'] = 'text/plain';
    $options['mtime'] = time();
    $options['size'] = strlen($statistics_data);
    $options['data'] = $statistics_data;

    return true;
  }

  function GetDir($fspath, &$options) {
    $this->log("GetDir\n");
    exit;
  }

  function PUT(&$options) {
    $this->log("PUT\n");
    return "403 Forbidden";
  }

  function MKCOL($options)  {
    $this->log("MKCOL\n");
    return "403 Forbidden";
  }

  function DELETE($options) {
    $this->log("DELETE\n");
    return "403 Forbidden";
  }

  function MOVE($options) {
    $this->log("MOVE\n");
    return "403 Forbidden";
  }

  function COPY($options, $del=false) {
    $this->log("COPY\n");
    return "403 Forbidden";
  }

  function PROPPATCH(&$options) {
    $this->log("PROPPATCH\n");
    return "403 Forbidden";
  }

  function LOCK(&$options) {
    $this->log("LOCK\n");
    return "403 Forbidden";
  }

  function UNLOCK(&$options) {
    $this->log("UNLOCK\n");
    return "403 Forbidden";
  }

  /*
   * Implementation details
   */

  final private function log($data)
  {
    if (!defined('LOG_ENABLED') || !LOG_ENABLED)
      return;

    error_log(date("d-m-Y H:i:s") . ': ' . $data, 3, 'log/dav.log');
  }

  private function is_command($path, $cmd)
  {
    return (substr($path, 0, strlen($cmd)) == $cmd);
  }

  final private function get_statistics_contents($path, $sender)
  {
    $path = strtoupper($path);

    // Process service commands (starts with '@').
    if (substr($path, 0, 2) == '/@')
    {
      $p = substr($path, 1);
      if ($sender != "GET" && !$this->is_command($p, self::COMMAND_LOG))
        $this->log(" CMD: " . $p . "\n");

      if ($this->is_command($p, self::COMMAND_SET_IDS))
      {
        if ($sender == "GET")
          return "";
        $users = substr($p, strlen(self::COMMAND_SET_IDS));
        if ($users == null || $users == "")
          return null;
        $this->save_cached_statistics(self::COMMAND_SET_IDS, $users);
        return "";
      }

      if ($this->is_command($p, self::COMMAND_ADD_IDS))
      {
        if ($sender == "GET")
          return "";
        $users = $this->load_cached_statistics(self::COMMAND_SET_IDS);
        $new_users = substr($p, strlen(self::COMMAND_ADD_IDS));
        $users = $users ? $users . "," : "";
        if ($users == null || $users == "")
          return null;
        $this->save_cached_statistics(self::COMMAND_SET_IDS, $users . $new_users);
        return "";
      }

      if ($this->is_command($p, self::COMMAND_GET_IDS))
        return $this->load_cached_statistics(self::COMMAND_SET_IDS);

      if ($this->is_command($p, self::COMMAND_RUN_IDS))
      {
        if ($sender == "GET")
          return $this->load_cached_statistics(self::COMMAND_GET_LAST_STAT);
        $users = $this->load_cached_statistics(self::COMMAND_SET_IDS);
        if ($users == null || $users == "")
          return null;
        $content = $this->get_statistics_contents_batch(split(',', $users));
        $this->save_cached_statistics(self::COMMAND_GET_LAST_STAT, $content);
        return $content;
      }

      if ($this->is_command($p, self::COMMAND_SET_NAMES))
      {
        if ($sender == "GET")
          return "";
        $users = substr($p, strlen(self::COMMAND_SET_NAMES));
        if ($users == null || $users == "")
          return null;
        $this->save_cached_statistics(self::COMMAND_SET_NAMES, $users);
        return "";
      }

      if ($this->is_command($p, self::COMMAND_ADD_NAMES))
      {
        if ($sender == "GET")
          return "";
        $users = $this->load_cached_statistics(self::COMMAND_SET_NAMES);
        $new_users = substr($p, strlen(self::COMMAND_ADD_NAMES));
        $users = $users ? $users . "," : "";
        if ($users == null || $users == "")
          return null;
        $this->save_cached_statistics(self::COMMAND_SET_NAMES, $users . $new_users);
        return "";
      }

      if ($this->is_command($p, self::COMMAND_GET_NAMES))
        return $this->load_cached_statistics(self::COMMAND_SET_NAMES);

      if ($this->is_command($p, self::COMMAND_RUN_NAMES))
      {
        if ($sender == "GET")
          return $this->load_cached_statistics(self::COMMAND_GET_LAST_STAT);
        $users = $this->load_cached_statistics(self::COMMAND_SET_NAMES);
        if ($users == null || $users == "")
          return null;
        $content = $this->get_statistics_contents_batch(split(',', $users));
        $this->save_cached_statistics(self::COMMAND_GET_LAST_STAT, $content);
        return $content;
      }

      if ($this->is_command($p, self::COMMAND_GET_LAST_STAT))
        return $this->load_cached_statistics(self::COMMAND_GET_LAST_STAT);

      if ($this->is_command($p, self::COMMAND_LOG))
      {
        if ($sender != "GET")
          $this->log(sprintf("LOG:%s\n", substr($p, 4)));
        return "";
      }

      $this->log(sprintf("ВНИМАНИЕ: Неизвестная управляющая команда: %s\n", $p));
      return null;
    }

    $this->log(sprintf("Загрузка файла статистики: %s\n", $path));
    if (!preg_match('/\/(.*)/i', $path, $matches))
      return null;
    $usernames = $matches[1];
    $content = $this->get_statistics_contents_batch(split(',', $usernames));
    return $content;
  }

  final private function get_statistics_contents_batch($usernames)
  {
    $result = array("players" => array());

    // Pre-fetch elements which are not yet cached cached locally
    $request_users = array();
    foreach ($usernames as $username)
    {
      if (array_key_exists($username, $this->_cached_statistics)) {
        $this->log(sprintf("Загрузка статистики из памяти для: %s\n", $username));
      } else {
        $res = file_exists($this->get_cache_file_name($username));
        if ($res) {
          $this->log(sprintf("Загрузка статистики из кэша для: %s\n", $username));
          $this->_cached_statistics[$username] = file_get_contents($this->get_cache_file_name($username));
          if (time() - filemtime($this->get_cache_file_name($username)) > self::CACHE_FILE_LIVE_TIME) {
            $this->log(sprintf("Просроченный файл статистики в кэше для: %s\n", $username));
            $res = false;
          };
        };
        if (!$res && !$this->has_timed_out_recently($username))
          $request_users[] = $username;
      };
    };

    $this->execute_requests($request_users);

    // Generate batch response
    foreach ($usernames as $username)
      $result["players"][] = json_decode($this->load_cached_statistics($username));

    //$this->log("response: " . json_encode($result));
    return json_encode($result);
  }

  final private function get_cache_file_name($username)
  {
    settype($username, "string");
    $path = $username[0] == "@"
      ? 'cache/@'
      : sprintf('cache' . DIRECTORY_SEPARATOR . '%s' . DIRECTORY_SEPARATOR . '%s' . DIRECTORY_SEPARATOR . '%s',
                $username[0], $username[1], $username[2]);

    if (!file_exists($path)) {
      if (!mkdir($path, 777, true))
        $this->log(sprintf("ВНИМАНИЕ: невозможно создать директорию %s\n", $path));
    }
    else if (!is_dir($path))
      $this->log(sprintf("ВНИМАНИЕ: %s существует, но не директория\n", $path));

    return trim(sprintf('%s/%s%s', $path, $username, $username[0] == "@" ? "" : ".json"));
  }

  final private function get_timeout_flag_file_name($username)
  {
    return sprintf('%s.timeout.flag', $this->get_cache_file_name($username));
  }

  final private function has_timed_out_recently($username)
  {
    $flag_file = $this->get_timeout_flag_file_name($username);
    if (!file_exists($flag_file))
      return false;
    $res = (time() - filemtime($flag_file)) < self::TIMEOUT_WAIT_TIME;
    if (!$res)
      unlink($flag_file);
    return $res;
  }

  final private function load_cached_statistics($username) {
    if (!file_exists($this->get_cache_file_name($username)))
      return null;

    if (time() - filemtime($this->get_cache_file_name($username)) > self::CACHE_FILE_LIVE_TIME) {
      $this->log(sprintf("Просроченный файл статистики в кэше для: %s\n", $username));
      return null;
    };

    $this->log(sprintf("Загрузка статистики из кэша для: %s\n", $username));
    return file_get_contents($this->get_cache_file_name($username));
  }

  final private function save_cached_statistics($username, $content) {
    if (!$content) {
      if ($username[0] == "@")
        $this->remove_cached_statistics($username);
      else {
        $this->log(sprintf("Таймаут при запросе статистики для: %s\n", $username));
        if ($this->set_timeout_enabled)
        touch($this->get_timeout_flag_file_name($username));
      }
      return;
    };

    $this->_cached_statistics[$username] = $content;
    $this->log(sprintf("Сохранение статистики в кэш для: %s > сохранено %s байт\n", $username,
                       file_put_contents($this->get_cache_file_name($username), $content)));
  }

  final private function remove_cached_statistics($username) {
    unlink($this->get_cache_file_name($username));
  }

  final private function execute_requests($request_users)
  {
    if (count($request_users) == 0)
      return;

    // Client-side "load balancing"
    $PROXY_SERVERS = array(
      array("proto" => 1, "addr" => "http://proxy.bulychev.net/polzamer-mod/1/2/%1")
    );
    $proxy_server = $PROXY_SERVERS[rand(0, count($PROXY_SERVERS) - 1)];
    $url = str_replace("%1", join(",", $request_users), $proxy_server["addr"]);

    $this->log(sprintf("Отправка запроса: %s\n", $url));

    $this->timer();

    // Initialize batch request
    $u = parse_url($url);
    $content = "";
    $fp = fsockopen($u["host"], $u["port"] ? $u["port"] : 80, $errno, $errstr,
      self::MAX_STATISTICS_SERVER_WAIT_TIME);
    if (!$fp)
      $this->log("$errstr ($errno)\n");
    else
    {
      fputs ($fp, sprintf("GET %s%s HTTP/1.0\r\nHost: %s\r\n\r\n",
        $u["path"], $u["query"], $u["host"]));

      stream_set_timeout($fp, self::MAX_STATISTICS_SERVER_WAIT_TIME);
      $res = fread($fp, 65535);

      $info = stream_get_meta_data($fp);
      fclose($fp);

      if ($info['timed_out'])
        $this->log("Истекло время соединения!\n");
      else
      {
        $body = false;
        $lines = split("\n", $res);
        foreach ($lines as $line)
        {
          if (!$body && preg_match("/^[\r]?$/i", $line))
            $body = true;
          else if ($body)
            $content .= "$line\n";
        }
      }
      //$this->log("Обработка ответа\n");
      $this->parse_content($request_users, $content, $proxy_server["proto"]);
    }
  }

  final private function parse_content($users, $content, $proto)
  {
    $data = array();
    switch ($proto)
    {
      // eff-rating,eff-rating,...
      case 1:
        $content_array = split(",", $content);
        for ($i = 0; $i < count($users); $i++)
        {
          $user_data = array("nick" => $users[$i]);
          $content_data = split("-", $content_array[$i]);
          if ($content_data[1] != "0" && $content_data[1] != "X")
          {
            $user_data["eff"] = trim($content_data[0]);
            $user_data["rating"] = trim($content_data[1]);
          }
          $data[$users[$i]] = $user_data;
        }
        break;
    }

    foreach ($users as $username)
    {
      if ($data[$username])
        $this->save_cached_statistics($username, json_encode($data[$username]));
    }
  }

  function timer($shift = false) {
    static $first = 0;
    static $last;

    $now = preg_replace('#^0(.*) (.*)$#', '$2$1', microtime());
    if (!$first) $first = $now;
    $res = $shift ? $now - $last : $now - $first;
    $last = $now;
    return $res;
  }
}

?>