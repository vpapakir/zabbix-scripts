<?php

const MEMCACHED_SERVER='172.31.0.137';
const MEMCACHED_PORT=11211;

ini_set('memcached.sess_prefix', 'test.sess.memc.');
ini_set('memcached.sess_locking', '1');
ini_set('session.save_handler', 'memcached');
ini_set('session.save_path', MEMCACHED_SERVER.':'.MEMCACHED_PORT);

$memc = new Memcached('mc');
$memc->addServer(MEMCACHED_SERVER, MEMCACHED_PORT);

echo "session lock: " . $memc->get('test.sess.memc.lock.'.session_id()).'<br/>';

// starting session, lock enabled if all goes fine
session_start();

echo "session started: ".session_id();

echo "<h3>session data:</h3><pre>";
var_dump($_SESSION);
echo "</pre><h3>value of lock 'test.sess.memc.lock.".session_id()."' entry in memcached:</h3><pre>";
var_dump($memc->get('test.sess.memc.lock.'.session_id()));
echo "</pre><h3>value of session 'test.sess.memc.".session_id() . "' entry in memcached:</h3><pre>";
var_dump($memc->get('test.sess.memc.'.session_id()));
echo "</pre>";

$_SESSION['time'] = time();

$_SESSION['flag'] = $_GET['flag'];

sleep(3);

echo 'done';

// script done, lock released
