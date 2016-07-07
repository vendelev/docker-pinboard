<?php
if (!isset($_SERVER) || !array_key_exists('REQUEST_URI', $_SERVER)) {
    throw new UnexpectedValueException('$_SERVER[\'REQUEST_URI\'] must exist');
}
$file = __DIR__ . explode('?', $_SERVER['REQUEST_URI'])[0];
if (is_file($file)) {
    $contentType = mime_content_type($file);
    if (empty($contentType)) {
        $contentType = 'application/octet-stream';
    }
    header('Content-Description: File Transfer');
    header('Content-Type: ' . $contentType);
    header('Content-Disposition: attachment; filename=' . basename($file));
    header('Expires: 60');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
    exit;
}
require_once __DIR__ . '/index.php';