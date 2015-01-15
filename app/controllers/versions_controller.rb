class VersionsController < ApplicationController
  def create
    @document = Document.find(params[:document_id])
    @version  = @document.versions.create(versions_params)
    @document.update(current_version: @version)

    redirect_to document_path(@document)
  end

  def destroy
    @document = Document.find(params[:document_id])
    @versions = @document.versions.find(params[:id])
    @versions.destroy
    redirect_to @document
  end

  private
    def versions_params
      params.require(:version).permit(:number, :ubication)
    end
end
