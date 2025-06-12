# PokeApp Mottu

Aplicativo Flutter que consome a [PokeAPI](https://pokeapi.co) para exibir uma lista de Pokémons com detalhes.

## 📱 Funcionalidades Implementadas

- Listagem de Pokémons com nome e imagem.
- Tela de detalhes com:
  - Imagem ampliada.
  - Nome, altura e peso.
  - Tipos do Pokémon.
  - Habilidades do Pokémon.
- Filtro por nome com campo de busca.
- Campo de busca de pokémons.

## ▶️ Como Rodar o Projeto

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/arthurhc1/im-mottu-mobile.git
   cd pokeapp_mottu

2. **Instalar as dependências:**

   flutter pub get
   
3. **Rodar o projeto:**

   flutter run

## **Arquitetura:**

   O projeto utiliza uma arquitetura MVC(Model, View, Controller):
   - models/: Contém as classes como Pokemon e PokemonDetail;
   - views/: Telas visuais como HomeScreen, DetailScreen e widgets;
   - controllers/: requisições HTTP(PokemonController, PokemonDetailController).
   
