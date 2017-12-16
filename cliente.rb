class Cliente
  attr_reader :nome, :rg, :sexo;

  def initialize(nome: , rg:, sexo:)
    @nome = nome
    @rg = rg
    @sexo = sexo
  end
end