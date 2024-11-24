# flutter_produtos
Catálogo de Produtos - Flutter

Objetivo
O objetivo deste projeto é criar um aplicativo móvel simples utilizando o Flutter para exibir um catálogo de produtos. O aplicativo consome uma API externa que fornece informações sobre produtos, como título, descrição, preço e imagem. O foco principal é aprender a integrar uma API em um app Flutter, criar uma interface moderna e responsiva, e organizar o código de forma limpa e eficiente.

Apresentação do App
O aplicativo possui uma interface limpa e intuitiva, ideal para usuários que desejam navegar por uma lista de produtos e visualizar mais informações detalhadas sobre cada um deles. A tela inicial mostra uma lista de produtos, e ao selecionar um produto, o usuário é levado a uma segunda tela com informações mais detalhadas.

O aplicativo possui as seguintes funcionalidades principais:

Tela de Listagem de Produtos: Exibe os produtos disponíveis com informações resumidas, como nome e preço.
Tela de Detalhes do Produto: Mostra informações adicionais sobre o produto selecionado, incluindo uma descrição mais detalhada e a imagem do produto.
Funcionalidades:
Carregamento dinâmico de produtos: Os dados dos produtos são carregados de uma API externa (mockada ou real).
Navegação entre telas: O usuário pode clicar em um produto e ser redirecionado para uma nova tela que mostra mais detalhes sobre o item.
Interface moderna e responsiva: A aplicação utiliza elementos do Flutter como ListView, Card, Text, Image e ElevatedButton para criar uma interface visualmente agradável e fácil de usar.
Como Funciona
Carregamento de Produtos via API: A aplicação faz uma requisição HTTP para buscar os dados dos produtos. A API retorna um conjunto de dados com informações como nome, descrição, preço e URL da imagem do produto.

Listagem de Produtos: Na tela inicial, a aplicação exibe os produtos de forma ordenada em uma lista. Cada item da lista é mostrado com o nome do produto e o preço. O usuário pode ver esses dados de forma rápida e simples.

Tela de Detalhes: Quando o usuário clica em um produto, o app redireciona para uma tela de detalhes, onde ele pode ver mais informações sobre o produto, como a descrição completa e a imagem em maior tamanho.

Interatividade: O aplicativo permite ao usuário navegar entre as telas de forma simples e intuitiva, utilizando navegação de pilha (push e pop) que é característica do Flutter.

Interface Responsiva: O layout foi projetado para se ajustar a diferentes tamanhos de tela, garantindo uma boa experiência tanto em smartphones quanto em tablets.

Tecnologias Utilizadas
Flutter: Framework de desenvolvimento para criar aplicativos móveis nativos.
Dart: Linguagem utilizada para escrever o código do app.
API HTTP: Integração com APIs externas para carregar dados dos produtos (pode ser uma API real ou mockada para fins de teste).
Widgets do Flutter: Utilização de diversos widgets como ListView, Card, Image, Text, ElevatedButton, para construção da interface.
JSON: Formato de dados utilizado para transmitir informações entre o cliente (aplicativo) e o servidor (API).
Como Rodar o Projeto
Clone o repositório:

bash
Copiar código
flutter pub get
Execute o app: Conecte um dispositivo ou emulador e execute:

bash
Copiar código
flutter run
Teste o App: Abra o aplicativo no seu dispositivo ou emulador e navegue pelas telas. Você verá a lista de produtos sendo carregada e poderá acessar os detalhes de cada produto ao clicar sobre ele.