# Requires para carregar as classes dependentes
require_relative 'node'
require_relative 'linked_list'
require_relative 'hash_map'

def main
  # Criação do HashMap
  hash_map = HashMap.new

  # Teste de inicialização
  puts "Teste de inicialização: HashMap vazio?"
  puts hash_map.is_empty? == true # Deve retornar true

  # Teste de inserção
  puts "\nTeste de inserção"
  hash_map.insert('apple', 'red')
  hash_map.insert('banana', 'yellow')
  puts hash_map.get('apple') == 'red'  # Deve retornar 'red'
  puts hash_map.get('banana') == 'yellow'  # Deve retornar 'yellow'
  puts hash_map.size == 2  # Deve retornar 2

  # Teste de colisão (caso haja colisão)
  puts "\nTeste de colisão"
  hash_map.insert('car', 'blue')
  hash_map.insert('arc', 'green')  # Suponha que 'car' e 'arc' gerem colisões
  puts hash_map.get('car') == 'blue'  # Deve retornar 'blue'
  puts hash_map.get('arc') == 'green'  # Deve retornar 'green'

  # Teste de sobrescrita de chave
  puts "\nTeste de sobrescrita de chave"
  hash_map.insert('apple', 'green')  # Atualizando valor
  puts hash_map.get('apple') == 'green'  # Deve retornar 'green'

  # Teste de remoção
  puts "\nTeste de remoção"
  hash_map.remove('banana')
  puts hash_map.get('banana').nil?  # Deve retornar nil
  puts hash_map.size == 2  # Deve retornar 2, já que 'banana' foi removida

  # Teste de presença de chave
  puts "\nTeste de presença de chave"
  puts hash_map.include?('apple') == true  # Deve retornar true
  puts hash_map.include?('banana') == false  # Deve retornar false

  # Teste de rehashing (crescimento da capacidade)
  puts "\nTeste de rehashing"
  hash_map.insert('dog', 'brown')
  hash_map.insert('elephant', 'gray')
  hash_map.insert('frog', 'green')
  hash_map.insert('grape', 'purple')
  hash_map.insert('hat', 'black')
  hash_map.insert('ice cream', 'white')
  hash_map.insert('jacket', 'blue')
  hash_map.insert('kite', 'pink')
  hash_map.insert('lion', 'golden')
  hash_map.insert('moon', 'silver')  # Este deve acionar o rehash
  puts hash_map.size == 11  # Deve retornar 11 após o rehash

  # Teste de clear (limpeza total)
  puts "\nTeste de limpeza"
  hash_map.clear
  puts hash_map.is_empty? == true  # Deve retornar true
  puts hash_map.size == 0  # Deve retornar 0

  # Teste de recuperação de chaves, valores e pares
  puts "\nTeste de recuperação de chaves, valores e pares"
  hash_map.insert('a', '1')
  hash_map.insert('b', '2')
  puts hash_map.keys == ['a', 'b']  # Deve retornar ['a', 'b']
  puts hash_map.values == ['1', '2']  # Deve retornar ['1', '2']
  puts hash_map.entries == [['a', '1'], ['b', '2']]  # Deve retornar [['a', '1'], ['b', '2']]
end

main
