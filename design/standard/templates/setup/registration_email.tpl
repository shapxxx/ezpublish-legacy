{set-block variable=subject}
eZ publish {$version.text} site registration - {$site_info.title}
{/set-block}
Site info:
Title - {$site_info.title}
URL   - {$site_info.url}

PHP info:
Version - {$phpversion.found}

OS info:
Name - {$os.name}

Database info:
Type    - {$database_info.info.name}
Driver  - {$database_info.info.driver}
Unicode - {section show=$database_info.info.supports_unicode}Supported{section-else}Unsupported{/section}


Demo data:

{section show=$demo_data.use}
Demo data was installed.
{section-else}
Demo data was not installed.
{/section}


Email info:
Transport - {section show=eq($email_info.type,1)}sendmail{section-else}SMTP{/section}


Image conversion:

{section show=$imagemagick_program.result}
ImageMagick was found and used.
Path       - {$imagemagick_program.path}
Executable - {$imagemagick_program.program}
{/section}


{section show=$imagegd_extension.result}
ImageGD extension was found and used.
{/section}


Regional info:
Type       - {switch match=$regional_info.language_type}{case match=1}Monolingual{/case}{case match=2}Multilingual{/case}{case match=3}Unicode{/case}{case/}{/switch}

Primary    - {$regional_info.primary_language}
{section show=$regional_info.languages}
Additional - {section name=Language loop=$regional_info.languages}{$:item}{delimiter}, {/delimiter}{/section}
{/section}


Critical tests:

{section name=Critical loop=$tests_run}

{$:key} - {section show=$:item}Success{section-else}Failure{/section}

{/section}


Other tests:

{section name=Other loop=$optional_tests}

{$:item[1]} - {section show=eq($:item[0],1)}Success{section-else}Failure{/section}

{/section}
