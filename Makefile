# Visite os endereços abaixo para verificar as versões do PHP 
# com suporte ativo e versões do Xdebug compatíveis. 
#
# PHP: https://www.php.net/supported-versions.php
# Xdebug: https://xdebug.org/docs/compat#versions

PHP_VERSION=7.4.8
XDEBUG_VERSION=2.9.8

default: build

build:
	@docker build . -t aljes96/php-apache:$(PHP_VERSION)-wp-cli \
		--build-arg PHP_VERSION=$(PHP_VERSION) \
		--build-arg XDEBUG_VERSION=$(XDEBUG_VERSION) \
		--force-rm

push:
	@docker push aljes96/php-apache:$(PHP_VERSION)-wp-cli

debug:
	@docker run --rm -it aljes96/php-apache:$(PHP_VERSION)-wp-cli /bin/bash

run:
	@docker run --rm aljes96/php-apache:$(PHP_VERSION)-wp-cli

release: build push
