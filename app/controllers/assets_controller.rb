class AssetsController < ApplicationController

  def index
    @assets = Asset.all
  end

  def show
    @asset = Asset.find(params[:id])
    @asset_histories = @asset.asset_histories
  end

  def checkout
    @asset = Asset.find(params[:id])
    if @asset.update(status: 'CheckedOut')
      respond_to do |format|
        format.html { redirect_to assets_path, notice: '資產已借出' }
        format.js
      end
    end
  end

  def checkin
    @asset = Asset.find(params[:id])
    if @asset.update(status: 'Available')
      respond_to do |format|
        format.html { redirect_to assets_path, notice: '資產已歸還' }
        format.js
      end
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :description, :status)
  end

end
