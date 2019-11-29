# segrax/php-testing
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE.md)

A collection of PHP testing tools bundled into a docker container.

## Usage
See [Commands](AvailableCommands) for all available parameters

### Execute all tests
```bash
docker run --rm --volume c:/work/myapp:/srv/app segrax/php-testing tests
```

### Execute phpcbf
```bash
docker run --rm --volume c:/work/myapp:/srv/app segrax/php-testing phpcbf
```

## Configuration files
Some tools require configuration, place these files in the root of the volume mount (or inside /app if it exists)

| Tool    | File
| ------- |---
| phpstan | /phpstan.neon |
| psalm   | /psalm.xml |
| phpunit | /phpunit.xml |

## Commands
[AvailableCommands]: 1
Each tool can be either individually executed or related tools sequentually. To run an individual tool, simply change the command on the end of the docker run command.

### Individual tools
| Command | Description | Tool
| ------- | ---- | ---
| composer-install | Execute a composer install, with optimization | [Composer](https://getcomposer.org/)
| composer-install-dev | Execute a development install| [Composer](https://getcomposer.org/)
| composer-update | Execute an update| [Composer](https://getcomposer.org/)
| phpassume | Find assumptions | [PHP Assumptions](https://github.com/rskuipers/php-assumptions)
| phplint | Validate php syntax | [PHP Parallel Lint](https://github.com/JakubOnderka/PHP-Parallel-Lint)
| phpcbf | Fix [PSR1](https://www.php-fig.org/psr/psr-1/) and [PSR12](https://www.php-fig.org/psr/psr-12/) violations | [PHP CBF](https://github.com/squizlabs/PHP_CodeSniffer)
| phpcs | Validate against [PSR1](https://www.php-fig.org/psr/psr-1/) and [PSR12](https://www.php-fig.org/psr/psr-12/) | [PHP CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)
| phpcpd | Find copy and pasted code | [PHP Copy/Paste Detector](https://github.com/sebastianbergmann/phpcpd)
| phpmd | Find messy code | [PHP Mess Detector](http://phpmd.org/)
| phpstan | Find code mistakes | [PHP Static Analysis Tool](https://github.com/phpstan/phpstan)
| phpunit | Execute phpunit tests | [PHPUnit](https://phpunit.de/)
| psalm | Find code mistakes | [Psalm](https://psalm.dev/)

### Sequential tools
| Command | Tools
| ------- | ----
| tools-code | phpassume, phplint, phpcs, phpcpd, phpmd
| tools-static | phpstan, psalm
| tests | tools-code, tools-static, phpunit

## Installed PHP Extensions
* json
* sockets
* xdebug
* zip

## License

The MIT License (MIT). Please see [License File](LICENSE.txt) for more information.
