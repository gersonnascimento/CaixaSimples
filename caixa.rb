require_relative 'cliente'
require_relative 'conta'

SAIR = 0
SALDO = 1
DEPOSITO = 2
SAQUE = 3
TRANSFERENCIA = 4
conta = nil


def login(numero, senha)
  if Conta.find(numero) == []
    puts 'Conta não encontrada!'
    false
  elsif Conta.find(numero).first.senha == senha
  	Conta.find(numero).first
  else
  	puts 'Senha incorreta!'
  	false
  end
end

def boas_vindas(conta)
  puts "Bem vindo(a) sr(a) #{conta.cliente.nome}."
end

def menu
  puts 'Selecione a opcao:'
  puts "#{SALDO} - Para ver o saldo."
  puts "#{DEPOSITO} - Para fazer um depósito."
  puts "#{SAQUE} - Para fazer um saque."
  puts "#{TRANSFERENCIA} - Para fazer uma transferência."
  puts "#{SAIR} - Para sair."

  op = gets.chomp.to_i
end
def mostra_saldo(conta)
  puts'================================'
  puts "Seu saldo é R$#{conta.saldo}"
  puts'================================'
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
      puts "Não foi possível sacar."
    end 
end

def faz_transferencia(conta)
	puts 'Digite o numero da conta de destino: '
	nconta = gets.chomp.to_i
	puts 'Digite o valor da transferência: '
	val = gets.chomp.to_f
	if conta.transferir val,nconta
      puts 'Transferência efetuada com sucesso!'
      mostra_saldo(conta)
    else puts'Transferência não realizada!'
	end
end

puts 'Digite o numero da conta: '
c = gets.chomp.to_i
puts 'Digite a senha: '
s = gets.chomp.to_i
conta = login c,s
if conta.is_a?(Conta)
  boas_vindas(conta)
op = menu
while op != SAIR
  if op==SALDO
  	mostra_saldo(conta)
  elsif op==DEPOSITO
    faz_deposito(conta)
  elsif op==SAQUE
    faz_saque(conta)
  elsif op==TRANSFERENCIA
  	faz_transferencia conta
  else puts 'Opção inválida!'     
  end #if
  op = menu
end #while
end#if
puts 'Tchau!'
