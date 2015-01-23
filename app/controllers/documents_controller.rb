class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.all
  end

  def show
  end

  def new
    @document = Document.new
    @document.build_current_version
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.current_version.number = @document.versions.count + 1
    
    if @document.save
      mimeType = "application/vnd.google-apps.document"
      if @document.doc_type == "excel"
        mimeType = "application/vnd.google-apps.spreadsheet"
      end

      puts "Session: #{session[:access_token]}"
      response = Unirest.post "https://www.googleapis.com/drive/v2/files?convert=true", 
        headers:{"Authorization" => "Bearer #{session[:access_token]}", "Content-Type" => "application/json"}, 
        parameters: {title: "doc-#{@document.id}", mimeType: mimeType }.to_json

      drive_id = response.body["id"]
      @document.current_version.docdrive_id = drive_id
      @document.current_version.document_id = @document.id

      @document.current_version.save
    end
    #redirect_to documents_path

    #s = GoogleDrive.login_with_oauth(session[:access_token])
    #s.upload_from_string(
    #{}"Hello mundo.doc", "Hello", :content_type => "text/doc", :convert => false)
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    response = Unirest.delete "https://www.googleapis.com/drive/v2/files/#{@document.current_version.docdrive_id}",
    headers:{"Authorization" => "Bearer #{session[:access_token]}", "Content-Type" => "application/json"}
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:code, :origin, :type, :doc_type, current_version_attributes: [:number, :ubication, :title, :description])
    end
end
