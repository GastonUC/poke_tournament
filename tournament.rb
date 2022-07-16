# Usando https://pokeapi.co/, crear un codigo que simule un torneo pokemon entre 8 pokemones al azar (entre los primeros 151).
# Para simular que pokemon gana una batalla debes desarrollar un algoritmo que considere los base_stats y los tipos de los pokemones (el resto no es necesario)
# Avance y resultados deben de ser mostrados en consola

# Se utilzará un formato estándar de campeonato, serán 4 batallas por lado A y 4 batallas en el lado B.

# hash = {"charmander" => {"hp":56, "att":61, "def":30, "satt":58, "sdef":54, "spd":34, "type":"fire"}, "bulbasaur" => {"hp":56, "att":80, "def":48, "satt":60, "sdef":70, "spd":43, "type":"water"}}
# puts hash["charmander"][:hp]

require 'httparty'
#require 'poke-api-v2'

pokemon_limit = 151
uri = "https://pokeapi.co/api/v2/pokemon"

#Method to get all the pokemons, select and return 8 contestants
def get_pokemons(uri, poke_lim)
    response = HTTParty.get("#{uri}?limit=#{poke_lim}")
    pokemons = response['results'].sample(8)
    return pokemons
end

#Method to get 8 random pokemons from the list
# def get_contestant(uri, poke_lim)
#     return pokemons
# end

def base_stats(uri)
    stat 
end

#Method to get the type of the pokemon
def get_pokemon_type(contestants, uri)
    for poke in contestants
        response = HTTParty.get("#{uri}/#{poke}")
    end
    return response['types']
    # response = HTTParty.get("#{uri}/charmander")
end


# puts get_contestant(uri, pokemon_limit)

# contestants = get_pokemons(uri, pokemon_limit)
# puts contestants

# Get Pokemon links
def get_base_data(uri, poke_lim)
    url = []
    array = get_pokemons(uri, poke_lim)

    for a in array
        name = a['name']
        link = a['url']
        url << [name, link]
    end

    url.each do|key, value|
        # getting_stats(link)
        getting_stats(key, value)
    end
    # return url.to_h
end

def getting_stats(key, link)
    poke = []
    stats = []
    link = HTTParty.get(link)["stats"]
    for i in link
        stat_name = i["stat"]["name"]
        stat = i["base_stat"]
        stats << [stat_name, stat]
        poke << [key, stats.to_h]
    end
    return poke.to_h
end

# getPokemons = get_base_data(uri, pokemon_limit)[:value]
# puts getting_stats()
puts get_base_data(uri, 151)

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

# poke = Pokemons.new()
# puts poke.get_contestant
# puts poke.max_pokemons(151)


# Test if the header gets into the output array
# pokemons.push("next")
# ans = pokemons.include?('count' || 'next')
# while !ans
#     puts "finish"
# end
# puts "not finish"