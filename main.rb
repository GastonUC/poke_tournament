# Usando https://pokeapi.co/, crear un codigo que simule un torneo pokemon entre 8 pokemones al azar (entre los primeros 151).
# Para simular que pokemon gana una batalla debes desarrollar un algoritmo que considere los base_stats y los tipos de los pokemones (el resto no es necesario)
# Avance y resultados deben de ser mostrados en consola

# Se utilzará un formato estándar de campeonato, serán 4 batallas por lado A y 4 batallas en el lado B.

# Form N3
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

# Method to get all the pokemons, select and return 8 contestants
# Obtiene los links a las paginas correspondientes a los pokemon y los envia al metodo para obtener los base_stats y el tipo
def get_pokemons(poke_lim)
    poke_links = []
    poke_data = []
    # response = HTTParty.get("#{uri}?limit=#{poke_lim}")
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=#{poke_lim}")
    pokemons = response['results'].take(2) #cambiar por sample(8)

    for a in pokemons
        poke_name = a['name']
        poke_link = a['url']
        poke_links << [poke_name, poke_link]
    end

    poke_links.each do|key, value|
        poke_data << getting_stats_types(key, value)
    end
    return poke_data
end


# Obtiene los base_stats y los tipos
def getting_stats_types(key, link)
    poke = []
    stats = []
    type = []
    urls = HTTParty.get(link)["stats"]
    link2 = HTTParty.get(link)["types"]
    for x in link2
        type << x["type"]["name"]
    end
    for i in urls
        stat_name = i["stat"]["name"]
        stat = i["base_stat"]
        stats << [stat_name, stat]
    end
    stats << ["type",type]
    poke << [key, stats.to_h]
    return poke.to_h
end

def getData(poke_limit)
    pokemons1 = get_base_data(poke_limit)
    for contestant in pokemons1
        puts contestant
    end

    
    hp = pokemons1[0]
    for x in hp
        hp = x[1]["hp"]
    end

    att = get_base_data
end
# getData(pokemon_limit)

puts get_pokemons(pokemon_limit)

def who_start(poke_lim)
    poke_A = get_pokemons(poke_lim)[0]
    for r in poke_A
       spdA = r[1]["speed"]
    end
    poke_B = get_pokemons(poke_lim)[1]
    for r in poke_B
        spdB = r[1]["speed"]
    end
    
    if (spdA >= spdB)
        puts "Pokemon A, Empieza la batalla!"
    else
        puts "Pokemon B, Empieza la batalla!"
    end
end

who_start(pokemon_limit)

# def multiplier() TIPO
#     case (type)
#     when "Acero"

# end


def getDices()
end


# x = {"haunter"=>{"hp"=>45, "attack"=>50, "defense"=>45, "special-attack"=>115, "special-defense"=>55, "speed"=>95, "type"=>["ghost", "poison"]}}
# puts x["haunter"]["type"][0]

# def poke_tournament()
#     puts "hi"
# end

# poke_tournament()

# stat = HTTParty.get("https://pokeapi.co/api/v2/pokemon/charizard/")["types"]
# type = []
# for x in stat
#     type << x["type"]["name"]
# end
# puts type

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
