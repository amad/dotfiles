<?php

return PhpCsFixer\Config::create()->setRules([
    //'@PSR2' => true,
    // 'strict_param' => true,
    // 'no_unused_imports' => true,
    '@PHP56Migration' => true,
    '@PHP70Migration' => true,
    '@PHPUnit60Migration:risky' => true,
    '@Symfony' => true,
    '@Symfony:risky' => true,
    'blank_line_after_opening_tag' => false,
    //'align_multiline_comment' => true,
    'array_syntax' => ['syntax' => 'short'],
    // 'blank_line_before_statement' => true,
    'combine_consecutive_issets' => true,
    'combine_consecutive_unsets' => true,
    'compact_nullable_typehint' => true,
    //'header_comment' => ['header' => $header],
    'heredoc_to_nowdoc' => true,
    'list_syntax' => ['syntax' => 'long'],
    'method_argument_space' => ['ensure_fully_multiline' => true],
    'no_extra_consecutive_blank_lines' => ['tokens' => ['break', 'continue', 'extra', 'return', 'throw', 'use', 'parenthesis_brace_block', 'square_brace_block', 'curly_brace_block']],
    'no_null_property_initialization' => true,
    'no_short_echo_tag' => true,
    'no_superfluous_elseif' => true,
    // 'no_unneeded_curly_braces' => true,
    // 'no_unneeded_final_method' => true,
    // 'no_unreachable_default_argument_value' => true,
    'no_useless_else' => true,
    'no_useless_return' => true,
    'ordered_class_elements' => true,
    'ordered_imports' => true,
    'php_unit_strict' => true,
    'php_unit_test_class_requires_covers' => false,
    'phpdoc_add_missing_param_annotation' => true,
    'phpdoc_order' => true,
    'phpdoc_types_order' => true,
    'phpdoc_align' => false,
    // 'semicolon_after_instruction' => true,
    // 'single_line_comment_style' => true,
    'strict_comparison' => true,
    'strict_param' => true,
    'yoda_style' => false,
    'simplified_null_return' => true,
    'not_operator_with_space' => true,
    'no_null_property_initialization' => true,
    'mb_str_functions' => true,
    'final_internal_class' => true,
    'compact_nullable_typehint' => true,
    'cast_spaces' => ['space' => 'none'],
    'trailing_comma_in_multiline_array' => false,
]);
