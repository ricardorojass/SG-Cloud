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
    puts "Session: #{session[:access_token]}"
    response = Unirest.post "https://www.googleapis.com/drive/v2/files", 
      headers:{"Authorization" => "Bearer #{session[:access_token]}", "Content-Type" => "application/json"}, 
      parameters: {title: "test.doc", mimetype: "application/vnd.google-apps.document" }.to_json

    puts response.code
    puts response.body["id"]

    #s = GoogleDrive.login_with_oauth(session[:access_token])
    #s.upload_from_string(
    #{}"Hello mundo.doc", "Hello", :content_type => "text/doc", :convert => false)
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
