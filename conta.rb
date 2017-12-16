require_relative 'cliente'
class Conta
  LISTA_CONTAS = 'txtContas.txt'
  attr_accessor :saldo, :limite, :senha, :numero
  attr_reader :cliente, :salario

  SEPARADOR = '<|QSD|>'

  def initialize(cliente:, salario:, numero:, senha:, saldo:)
  	@cliente = cliente
  	@saldo = saldo
    @limite = salario/2
    @numero = numero
    @senha = senha
    @salario = salario
  end

  def self.all
    File.readlines(LISTA_CONTAS).map do |line|
      to_conta line.chomp
    end
  end

  def self.find(numero)
    all.select do |conta|
      conta.eh?(numero)
    end
  end

  def to_s
        "======================================
Titular: #{cliente.nome}
Rg: #{cliente.rg}
====================================== "
  end

  def eh? numero
    @numero==numero
  end

  def self.save_all(array)
    para_salvar = array.map do |conta|
      conta.to_row
    end
    File.open(LISTA_CONTAS, 'w+') do |file|
      file << para_salvar.join("\n")
    end
  end

  def atualiza_saldo
  	contas = Conta.all
    accounts = contas.map do |conta|
      if self==conta
      	conta.saldo = self.saldo
      	conta
      else
        conta
      end
    end
    Conta.save_all accounts
  end

  def to_row
    "#{cliente.nome}<|QSD|>#{cliente.rg}<|QSD|>#{cliente.sexo}<|QSD|>#{salario}<|QSD|>#{numero}<|QSD|>#{senha}<|QSD|>#{saldo.round(2)}"
  end

  def destroy
    Conta.save_all(Conta.all - [self])
  end

  def ==(outra)
    eql?(outra)
  end

  def eql? outra
    self.numero == outra.numero
  end

  def self.to_conta(linha)
    dados = linha.split(SEPARADOR)
    Conta.new(cliente: Cliente.new(nome: dados[0], rg: dados[1], sexo:dados[2]), salario: dados[3].to_f, numero: dados[4].to_i, senha:dados[5].to_i, saldo: dados[6].to_f.round(2))
  end

  def sacar valor
    if valor<=self.saldo
      self.saldo-=valor
      atualiza_saldo
      true
    else
      puts 'Saldo insuficiente!'
      false
    end
  end

  def depositar valor
    self.saldo+=valor
    atualiza_saldo
  end

  def transferir valor,nconta
  	conta = Conta.find(nconta).first
  	puts conta
  	puts "valor: R$#{valor}, \nConfirma? 'S' ou 'N'."
  	op = gets.chomp
  	if op =='S'
      if self.sacar valor
        conta.depositar valor
        true
      else 
        false
      end
    else
      puts 'Operação Cancelada!'
    end
  end

end