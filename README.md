# Flutter Via CEP API e Back4App Integration

Este é um projeto Flutter que demonstra a integração com a API Via CEP para buscar informações de endereços e a utilização do serviço Back4App para salvar essas informações. O aplicativo utiliza o padrão de projeto MVC (Model-View-Controller) para organizar o código e separar as responsabilidades.

## Funcionalidades

- Busca de endereço através da API Via CEP.
- Exibição dos endereços buscados.
- Possibilidade de salvar os endereços no Back4App.

## Arquitetura

O projeto segue a seguinte estrutura de pastas:

- **controllers**: Contém os controladores responsáveis por gerenciar a lógica de negócios da aplicação.
- **presenter**: Aqui estão os widgets de apresentação, que exibem os dados e interagem com o usuário.
- **models**: Definição das classes de modelo para representar os dados da aplicação.
- **repositories**: Lida com a comunicação com a API Via CEP e com o serviço Back4App.
- **utils**: Funções e classes utilitárias para auxiliar no desenvolvimento.
