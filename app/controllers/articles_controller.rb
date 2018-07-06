class ArticlesController < ApplicationController

	before_action :set_article, only: [:show, :edit, :destroy, :set_article, :update]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save then
			flash[:notice]="Artical was successfully created"
			redirect_to article_path(@article)
		else
			render 'new'
		end
		
	end

	def show
		#@article = Article.find(params[:id])
		#@article = Article.find(params[:id])
	end

	def edit
		#@article = Article.find(params[:id])
	end

	def update
		#@article = Article.find(params[:id])
		if @article.update(article_params) then
			flash[:notice] = "Artical was successfully updated"
			redirect_to article_path(@article)
		end 
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy
		flash[:notice] = "Article was successfully deleted"
		redirect_to articles_path
	end

	private
	def set_article
		@article = Article.find(params[:id])
	end
	def article_params
		params.require(:article).permit(:title, :description)
	end

end