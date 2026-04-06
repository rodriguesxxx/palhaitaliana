#!/bin/bash

ARQUIVO="nomes.txt"
LOG="sort.log"

if [ ! -f "$ARQUIVO" ]; then
    echo "Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

function visualizar_nomes() {
    echo "===== LISTA DE NOMES ====="
    nl -w2 -s'. ' "$ARQUIVO"
    echo "=========================="
}

function sortear_nome() {
    TOTAL=$(wc -l < "$ARQUIVO")

    if [ "$TOTAL" -eq 0 ]; then
        echo "Arquivo vazio!"
        return
    fi

    NUM=$(shuf -i 1-"$TOTAL" -n 1)
    NOME=$(sed -n "${NUM}p" "$ARQUIVO")

    echo "Nome sorteado: $NOME"

    # Salva no log com data
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Sorteado: $NOME" >> "$LOG"
}

while true; do
    echo ""
    echo "===== MENU ====="
    echo "1 - Sortear Nome"
    echo "2 - Visualizar Nomes"
    echo "0 - Sair"
    echo "================"
    read -p ": " OP

    case $OP in
        1)
            sortear_nome
            ;;
        2)
            visualizar_nomes
            ;;
        0)
            echo "..."
            exit 0
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac
done
