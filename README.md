# abnt-asciidoc-webhook
Webhook to build pdfs with ABNT specification


## Pré-requisitos:

- pdflatex
- [asciidoctor-latex](https://github.com/asciidoctor/asciidoctor-latex)
- [abnt_asciidoc](https://github.com/edusantana/abnt_asciidoc)
- [ngrok](https://ngrok.com/download) - para testes locais

## Instalação

Instale as dependências:

    bundle install

## Teste local

Execute ngrok ([see Configuring Your Server at github](https://developer.github.com/webhooks/configuring/)):

    ./ngrok http 4567

Copie o endereço que será exibido:

    Forwarding    http://7e9ea9dc.ngrok.com -> 127.0.0.1:4567

## Execute o serviço sinatra

    ruby server.rb

## Fork e configuração do serviço

- Faça um fork de [edusantana/trabalho-academico-abnt-asciidoc](https://github.com/edusantana/trabalho-academico-abnt-asciidoc/fork).

## Criando um Webhook

Caso necessite de ajuda, consulte [Creating Webhooks](https://developer.github.com/webhooks/creating/).

- Acesse a configuração do repositório, e abra a tela de Webhooks (`seu_usuario/trabalho-academico-abnt-asciidoc/settings/hooks`)

- Adicione o endereço copiado do ngrok e adicione `/payload`, exemplo:

    http://a07ce21b.ngrok.io/payload




http://a07ce21b.ngrok.io
