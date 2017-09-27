<?php

return PhpCsFixer\Config::create()->setRules([
    '@PSR2' => true,
    // 'strict_param' => true,
    'no_unused_imports' => true,
    'array_syntax' => ['syntax' => 'short'],
]);
