# Script de Manipulação de QR Code

Este script é uma ferramenta útil para trabalhar com códigos QR diratamente via terminal. Ele tem capacidade tanto para decodificar quanto para gerar códigos QR.

## Objetivo

O principal objetivo deste script é fornecer uma ferramenta de linha de comando simples e eficaz para:
1. Decodificar códigos QR a partir de uma área selecionada na tela.
2. Gerar representações visuais de códigos QR a partir de strings fornecidas.

## Funcionalidades

1. **Decodificação de Códigos QR**: Quando executado sem argumentos, o script solicita ao usuário que selecione uma área na tela. Ele então tenta decodificar qualquer código QR presente nessa área.
   
2. **Geração de Códigos QR**: Quando fornecido com uma string como argumento, o script gera e exibe um código QR no terminal.

## Dependências

O script depende das seguintes ferramentas:
- `zbarimg` (de zbar-tools): Para decodificar códigos QR de imagens.
- `qrencode`: Para gerar códigos QR.
- `scrot`: Para capturar screenshots.
- (Opcional) `identify` (de ImageMagick): Para identificar as dimensões da imagem.

## Uso
- Para decodificar um código QR de uma área da tela:
Sem argumentos: O script tentará decodificar um código QR de uma área da tela. *

```bash
./qrshot.sh
```
E então selecione o código QR em tela

- Para gerar um código QR
Com uma string como argumento: O script gerará um código QR dessa string.

```bash
./qrshot.sh "sua_string_aqui"
```

## Licença

Este é um software livre: você pode redistribuí-lo e/ou modificar sob os termos da [Licença](LICENSE) Pública Geral GNU (GPL) versão 3, conforme publicado pela Free Software Foundation.

Este programa é distribuído na esperança de que seja útil, mas SEM NENHUMA GARANTIA; sem sequer a garantia implícita de COMERCIALIZAÇÃO ou ADEQUAÇÃO A UM PROPÓSITO ESPECÍFICO. Veja a Licença Pública Geral GNU para mais detalhes.
