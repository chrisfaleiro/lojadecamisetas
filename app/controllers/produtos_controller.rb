class ProdutosController < ApplicationController

  before_action :set_produto, only: [:edit, :update, :destroy]

  def index
    @produtos_por_nome = Produto.order(:nome).limit 5
    @produtos_por_preco = Produto.order(:preco).limit 2
  end

  def create
    @produto = Produto.new produto_params
    @departamentos = Departamento.all
    if @produto.save
      flash[:notice] = "Produto salvo com sucesso"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @produto.destroy
    redirect_to root_url
  end

  def edit
    @departamentos = Departamento.all
    render :new
  end

  def update
    @departamentos = Departamento.all
    if @produto.update produto_params
      flash[:notice] = "Produto atualizado com sucesso"
      redirect_to root_url
    else
      render :new
    end
  end

  def busca
      @nome_a_buscar = params[:nome]
      @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
  end

  def new
    @produto = Produto.new
    @departamentos = Departamento.all
  end

  private

  def renderiza_new 
    @departamentos = Departamento.all
    render :new
  end

  def set_produto
    id = params[:id]
    @produto = Produto.find(id)
  end

  def produto_params
    params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
  end

end
