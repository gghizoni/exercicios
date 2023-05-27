#!/usr/bin/env bash
#
# exercicio.sh - Extrai erros de login do /var/log/auth.log
#
# Site:
# Autor:      Guilherme Ghizoni
# Manutenção: Guilherme Ghizoni
#
# ------------------------------------------------------------------------ #
#  Ira listar todos os erros de login no ssh, havendo a possibilidade de mostrar
# todas as datas que houveram erro, bem como o user que gerou.
#
#  Exemplos:
#      $ ./exercicio.sh -d
#      Neste exemplo printara apenas a data, mes e horario que houveram erros
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 27/05/2023, Guilherme:
#       - Adicionado -d, -u
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS ----------------------------------------- #
FALHAS="$(egrep "FAILED|failure" /var/log/auth.log)"
MENSAGEM_USO="
    $(basename $0) - [OPCOES]

      -h - Menu de ajuda
      -d - Printa apenas as datas e horario que houveram erros
      -u - Printa o user que teve a falha
      -v - Versao
"

VERSAO="v1.0"
CHAVE_DATA=0
CHAVE_USER=0
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case "$1" in
  -h) echo "$MENSAGEM_USO" && exit 0 ;;
  -v) echo "$VERSAO" && exit 0       ;;
  -d) CHAVE_DATA=1                   ;;
  -u) CHAVE_USER=1                   ;;
   *) echo "$FALHAS"                 ;;
esac

[ $CHAVE_DATA -eq 1 ] && echo "$FALHAS" | awk '{print $1,$2,$3}'
[ $CHAVE_USER -eq 1 ] && echo "$FALHAS" | grep logname= | cut -d = -f2
# ------------------------------------------------------------------------ #
