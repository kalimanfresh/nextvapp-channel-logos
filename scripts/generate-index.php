#!/usr/bin/env php
<?php
/**
 * Generate index.json from logos directory
 * Run: php generate-index.php
 */

$logosDir = __DIR__ . '/../logos';
$outputFile = __DIR__ . '/../index.json';

$logos = [];
$files = glob($logosDir . '/*');

foreach ($files as $file) {
    if (!is_file($file)) continue;

    $filename = basename($file);
    $name = pathinfo($filename, PATHINFO_FILENAME);
    $ext = pathinfo($filename, PATHINFO_EXTENSION);

    // Convert filename to display name
    $displayName = ucwords(str_replace('-', ' ', $name));

    $logos[] = [
        'id' => $name,
        'name' => $displayName,
        'file' => $filename,
        'format' => $ext,
        'size' => filesize($file),
        'url' => "https://raw.githubusercontent.com/nextvapp/channel-logos/main/logos/{$filename}"
    ];
}

// Sort alphabetically by name
usort($logos, function($a, $b) {
    return strcasecmp($a['name'], $b['name']);
});

$index = [
    'version' => '1.0.0',
    'updated' => date('Y-m-d H:i:s'),
    'count' => count($logos),
    'base_url' => 'https://raw.githubusercontent.com/nextvapp/channel-logos/main/logos/',
    'logos' => $logos
];

file_put_contents($outputFile, json_encode($index, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));

echo "Generated index.json with " . count($logos) . " logos\n";
