#
# Start PHP tools
#
PARAMS_PHPSTAN=
PARAMS_PSALM=

PHPUNIT_COMMAND=

ifndef FOLDER_APP
	FOLDER_APP = ${WORK_DIR}/app
endif

ifndef PSALM_FOLDER
	PSALM_FOLDER = 
endif

# Set the base app source folder
FOLDER_SOURCE = ${FOLDER_APP}/src

# Does /app exist
ifeq ($(wildcard ${FOLDER_APP}),)
	FOLDER_APP = ${WORK_DIR}
	FOLDER_SOURCE = ${FOLDER_APP}/src
endif

# Does /src exist
ifeq ($(wildcard ${FOLDER_SOURCE}),)
	FOLDER_SOURCE = ${FOLDER_APP}
endif

# Create a config for phpstan?
ifneq ($(wildcard ${FOLDER_APP}/phpstan.neon),)
	PARAMS_PHPSTAN:=-c ${FOLDER_APP}/phpstan.neon
endif

# Create a config for PSALM?
ifeq ($(wildcard ${FOLDER_APP}/psalm.xml),)
	ifeq ($(PSALM_FOLDER),)
		PARAMS_PSALM:=--init
	endif
endif

# Enable phpunit if the xml file exists
ifneq ($(wildcard ${FOLDER_APP}/phpunit.xml),)
	PHPUNIT_COMMAND:=phpunit --configuration ${FOLDER_APP}/phpunit.xml
endif

VENDOR_FOLDER=${FOLDER_APP}/vendor

.DEFAULT_GOAL := default

default: tests

composer-install: 
	cd ${FOLDER_APP} && composer install --no-dev --ignore-platform-reqs --optimize-autoloader --prefer-dist
	
composer-install-dev:
	cd ${FOLDER_APP} && composer install --dev --ignore-platform-reqs 

composer-update: 
	cd ${FOLDER_APP} && composer update --ignore-platform-reqs

phpassume:
	-phpa ${FOLDER_SOURCE}
	
phplint:
	parallel-lint --exclude ${VENDOR_FOLDER} ${FOLDER_SOURCE}
	
phpcbf:
	phpcbf --standard=PSR1,PSR12 --ignore=*/vendor/* ${FOLDER_SOURCE}
	
phpcs:
	phpcs --standard=PSR1,PSR12 --ignore=*/vendor/* ${FOLDER_SOURCE}

phpcpd:
	phpcpd --exclude=${VENDOR_FOLDER} ${FOLDER_SOURCE}

phpmd:
	phpmd ${FOLDER_SOURCE} text cleancode,codesize,controversial,design,naming,unusedcode --exclude ${VENDOR_FOLDER}

phpstan:
	phpstan analyse --autoload-file=${FOLDER_APP}/vendor/autoload.php -l 6 $(PARAMS_PHPSTAN) ${FOLDER_SOURCE}

phpunit:
	$(PHPUNIT_COMMAND)
	
psalm:
	psalm $(PARAMS_PSALM) $(PSALM_FOLDER)


tools-code: phpassume phplint phpcs phpcpd phpmd
tools-static: phpstan psalm
tests: tools-code tools-static phpunit
