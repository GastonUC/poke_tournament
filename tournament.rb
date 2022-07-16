# Usando https://pokeapi.co/, crear un codigo que simule un torneo pokemon entre 8 pokemones al azar (entre los primeros 151).
# Para simular que pokemon gana una batalla debes desarrollar un algoritmo que considere los base_stats y los tipos de los pokemones (el resto no es necesario)
# Avance y resultados deben de ser mostrados en consola

# Se utilzará un formato estándar de campeonato, serán 4 batallas por lado A y 4 batallas en el lado B.

# hash = {"charmander" => {"hp":56, "att":61, "def":30, "satt":58, "sdef":54, "spd":34, "type":"fire"}, "bulbasaur" => {"hp":56, "att":80, "def":48, "satt":60, "sdef":70, "spd":43, "type":"water"}}
# puts hash["charmander"][:hp]

# Form N2
# hash = {"grimer"=>{"hp"=>80, "attack"=>80, "defense"=>50, "special-attack"=>40, "special-defense"=>50, "speed"=>25, "type"=>"poison"}}
# puts hash["grimer"]["type"]

require 'httparty'
#require 'poke-api-v2'

#Primeros 151 Pokemons
pokemon_limit = 151
uri = "https://pokeapi.co/api/v2/pokemon"

#Method to get all the pokemons, select and return 8 contestants
def get_pokemons(poke_lim)
    # response = HTTParty.get("#{uri}?limit=#{poke_lim}")
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=#{poke_lim}")
    pokemons = response['results'].sample(8)
    return pokemons
end


# Obtiene los links a las paginas correspondientes a los pokemon y los envia al metodo para obtener los base_stats y el tipo
def get_base_data(poke_lim)
    pok_link = []
    pok_data = []
    array = get_pokemons(poke_lim)

    for a in array
        name = a['name']
        link = a['url']
        pok_link << [name, link]
    end

    pok_link.each do|key, value|
        pok_data << getting_stats_type(key, value)
    end
    return pok_data
end


# Obtiene los base_stats y los tipos
def getting_stats_type(key, link)
    poke = []
    stats = []
    urls = HTTParty.get(link)["stats"]
    link2 = HTTParty.get(link)["types"]
    for x in link2
        type1 = x["type"]["name"]
    end
    for i in urls
        stat_name = i["stat"]["name"]
        stat = i["base_stat"]
        stats << [stat_name, stat]
    end
    stats << ["type",type1]
    poke << [key, stats.to_h]
    return poke.to_h
end

puts get_base_data(pokemon_limit)

# link = HTTParty.get("https://pokeapi.co/api/v2/pokemon/charmander/")["types"]
# for x in link
#     puts x["type"]["name"]
# end

# Para obtener los base_stat
# response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/90/")['stats']
# puts response[0]['base_stat']


# puts response["stats"]
# for r in response
#     puts r[1]
# end

# puts response['stats']



# type = get_pokemon_type(contestants, uri)
# puts type
# puts get_pokemon_type(uri)


# class Pokemons
#     include HTTParty
#     base_uri 'https://pokeapi.co/api/v2/pokemon'

#     def max_pokemons
#         self.class.get("?limit=151")
#     end

#     def get_contestant
#         max_pokemons.sample(8)
#     end
    
# end
