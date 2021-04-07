# [aljes96/php-apache](https://hub.docker.com/r/aljes96/php-apache)

Construída a partir da [imagem oficial do Docker para PHP](https://hub.docker.com/_/php/) com a finalidade de
facilitar o desenvolvimento de projetos web em geral.

### Faz o download da imagem 'aljes96/php-apache:7.4.8'
```console
$ docker pull aljes96/php-apache:7.4.8
```
Ou com WP-CLI
```console
$ docker pull aljes96/php-apache:7.4.8-wp-cli
```
### Inicializa container de nome 'web-server'
Executar uma imagem (criando um container)
```console
$ docker run -d --name web-server \
    -p 80:80 \
    -v "$PWD":/var/www/html \
    aljes96/php-apache:7.4.8
```
### Acessa o terminal do container 'web-server'
Executa um container e abri um terminal (executando o comando /bin/bash)
```console
$ docker exec -it web-server /bin/bash
```
### Remove o container em execução 'web-server' e volumes anônimos associados
Exclui um container
```console
$ docker rm -f -v /web-server
```
### Cria container temporário
Executa um container e remove-o automaticamente ao sair
```console
$ docker run --rm -it aljes96/php-apache:7.4.8 /bin/bash
```
