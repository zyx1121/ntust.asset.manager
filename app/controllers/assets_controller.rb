class AssetsController < ApplicationController

  # 禁用`options`CSRF保護
  skip_before_action :verify_authenticity_token, only: [:options]

  def options
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
    render json: {}, status: :ok
  end

  def create
    asset = Asset.new(asset_params)
    if asset.save
      render json: asset, status: :created
    else
      render json: asset.errors, status: :unprocessable_entity
    end
  end

  def update
    asset = Asset.find(params[:id])
    if asset.update(asset_params)
      render json: asset
    else
      render json: asset.errors, status: :unprocessable_entity
    end
  end

  def index
    assets = Asset.all
    render json: assets
  end

  def show
    asset = Asset.find(params[:id])
    render json: asset
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :status)
  end

end
