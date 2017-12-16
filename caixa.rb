require_relative 'cliente'
require_relative 'conta'

SAIR = 0
SALDO = 1
DEPOSITO = 2
SAQUE = 3
conta = nil


def login(numero, senha)
  if Conta.find(numero) == []
    puts 'Conta não encontrada!'
    false
  elsif Conta.find(numero).first.senha == senha
  	puts 'Bem vindo'
  	Conta.find(numero).first
  else
  	puts 'Senha incorreta!'
  	false
  end
end

def boas_vindas(conta)
 puts "Bem vindo(a) sr(a) #{conta.cliente.nome}"
end

def menu
  puts 'Selecione a opcao:'
  puts "#{SALDO} - Para ver o saldo."
  puts "#{DEPOSITO} - Para fazer um depósito."
  puts "#{SAQUE} - Para fazer um saque."

  op = gets.chomp.to_i
end
def mostra_saldo(conta)
  puts "Seu saldo é R$#{conta.saldo}"
end
def faz_deposito(conta)
  puts 'Insira o valor'
    val = gets.chomp.to_f
    conta.depositar val
    puts 'Operação efetuada com sucesso!'
    mostra_saldo(conta)
end
def faz_saque(conta)
  puts 'Insira o valor'
    val = gets.chomp.to_f
    if conta.sacar val
      puts 'Operação efetuada com sucesso!'
      mostra_saldo(conta)
    else 
      puts "Saldo Insuficiente!"
    end
    
end

puts 'Digite o numero da conta: '
c = gets.chomp.to_i
puts 'Digite a senha: '
s = gets.chomp.to_i
conta = login c,s
if conta!= false
  boas_vindas(conta)
op = menu
while op != SAIR
  if op==SALDO
  	mostra_saldo(conta)
  elsif op==DEPOSITO
    faz_deposito(conta)
  elsif op==SAQUE
    faz_saque(conta)
  end #if 
  op = menu
end #while
end#if
puts 'Tchau!'
