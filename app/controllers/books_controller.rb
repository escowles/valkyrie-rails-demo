class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = BookChangeSet.new(Book.new)
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    change_set = BookChangeSet.new(Book.new)
    change_set.validate(book_params)
    change_set.sync
    @book = metadata_adapter.persister.save(resource: change_set.resource)

    respond_to do |format|
      if @book.persisted?
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.validate(book_params)
        @book.sync
        @book = metadata_adapter.persister.save(resource: @book.resource)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    metadata_adapter.persister.delete(resource: @book)
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = BookChangeSet.new(metadata_adapter.query_service.find_by(id: Valkyrie::ID.new(params[:id])))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(title: [], author: [], description: [])
    end

    def metadata_adapter
      @metadata_adapter ||= Valkyrie.config.metadata_adapter
    end
end
