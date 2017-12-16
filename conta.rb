require_relative 'cliente'
class Conta
  LISTA_CONTAS = 'txtContas.txt'
  attr_accessor :saldo, :limite, :senha, :numero
  attr_reader :cliente, :salario

  SEPARADOR = '<|QSD|>'

  def initialize(cliente:, salario:, numero:, senha:)
  	@cliente = cliente
  	@saldo = 0
    @limite = salario/2
    @numero = numero
    @senha = senha
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

  def eh? numero
    @numero==numero
  end

  def self.to_conta(linha)
    dados = linha.split(SEPARADOR)
    Conta.new(cliente: Cliente.new(nome: dados[0], rg: dados[1], sexo:dados[2]), salario: dados[3].to_f, numero: dados[4].to_i, senha:dados[5].to_i)
  end

  def sacar valor
    if valor<=self.saldo
      self.saldo-=valor
    else 
      false
    end
  end

  def depositar valor
    self.saldo+=valor
  end

end