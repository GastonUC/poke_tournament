# Usando https://pokeapi.co/, crear un codigo que simule un torneo pokemon entre 8 pokemones al azar (entre los primeros 151).
# Para simular que pokemon gana una batalla debes desarrollar un algoritmo que considere los base_stats y los tipos de los pokemones (el resto no es necesario)
# Avance y resultados deben de ser mostrados en consola

# Se utilzará un formato estándar de campeonato, serán 4 batallas por lado A y 4 batallas en el lado B.

require 'httparty'

pokemon_limit = 151
def get_pokemons(pok_lim)
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=#{pok_lim}")
    return response
end

puts get_pokemons(pokemon_limit)