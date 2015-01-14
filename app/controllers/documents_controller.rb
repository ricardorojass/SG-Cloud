class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @documents = Document.all
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.save
    session = GoogleDrive.login_with_oauth(current_user.uid)
    session.upload_from_string(
    "", :content_type => "application/vnd.google-apps.document")
    respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    respond_with(@document)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:code, :origin, :type, :ubication)
    end
end
