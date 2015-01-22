class VersionsController < ApplicationController
  
  def new
    @document = Document.find(params[:document_id])
    @version = Version.new
  end

  def create
    @document = Document.find(params[:document_id])
    @version  = @document.versions.build(versions_params)
    @version.number = @document.versions.count + 1 
    @version.save
    response = Unirest.post "https://www.googleapis.com/drive/v2/files/#{@document.current_version.docdrive_id}/copy", 
      headers:{"Authorization" => "Bearer #{session[:access_token]}", "Content-Type" => "application/json"}

      drive_id = response.body["id"]
      @version.docdrive_id = drive_id
      @version.document_id = @document.id
      
    if @version.save
      @version.document_id = @document.id
      redirect_to document_path(@document)
    else
      render :new
    end
  end

  def destroy
    @document = Document.find(params[:document_id])
    @versions = @document.versions.find(params[:id])
    @versions.destroy
    redirect_to @document
  end

  def update_status
    @version = Version.update(params[:version_id], status: params[:status].to_i)
  end

  private
    def versions_params
      params.require(:version).permit(:ubication, :title, :description, :application_date)
    end
end
