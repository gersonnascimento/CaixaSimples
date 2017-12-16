require_relative 'cliente'
require_relative 'conta'

SAIR = 0
SALDO = 1
DEPOSITO = 2
SAQUE = 3

CONTA = Conta.new(cliente: Cliente.new(nome:"Gerson Silva do Nascimento", rg: "43933454-8", sexo: "Masculino"), salario: 3000, numero: 1, senha: 1234)

def boas_vindas
 puts "Bem vindo(a) sr(a) #{CONTA.cliente.nome}"
end

def menu
  puts 'Selecione a opcao:'
  puts "#{SALDO} - Para ver o saldo."
  puts "#{DEPOSITO} - Para fazer um depósito."
  puts "#{SAQUE} - Para fazer um saque."

  op = gets.chomp.to_i
end
def mostra_saldo
  puts "Seu saldo é R$#{CONTA.saldo}"
end
def faz_deposito
  puts 'Insira o valor'
    val = gets.chomp.to_f
    CONTA.depositar val
    puts 'Operação efetuada com sucesso!'
    mostra_saldo
end
def faz_saque
  puts 'Insira o valor'
    val = gets.chomp.to_f
    if CONTA.sacar val
      puts 'Operação efetuada com sucesso!'
      mostra_saldo
    else 
      puts "Saldo Insuficiente!"
    end
    
end

boas_vindas
op = menu
while op != SAIR
  if op==SALDO
  	mostra_saldo
  elsif op==DEPOSITO
    faz_deposito
  elsif op==SAQUE
    faz_saque
  end #if 
  op = menu
end #while
