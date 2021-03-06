 class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end
  
  
  def new
    @article = Article.new 
  end
  
  
  def edit
  end
  
  
  def create

    @article = Article.new(article_params)
    # Assign the user who is logged in
    @article.user = current_user
    if @article.save
      #Do Something!
      flash[:success] = "YOUR ARTICLE WAS SAVED"
      redirect_to article_path(@article)
    else
      render :new
    end
  end
  
  
  def update
    if @article.update(article_params)
      flash[:success] = "YOUR ARTICLE WAS SUCCESSFULLY UPDATED"
      redirect_to article_path(@article)
    else
      render :edit
    end
    
  end
  
  
  def show
    
    
  end
  
  
  def destroy
    @article.destroy
    flash[:danger] = "ARTICLE INCINERATED"
    redirect_to articles_path
  end
  
  
  private
  
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only do this action if you are the author"
        redirect_to root_path
      end
    end
end