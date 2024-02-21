class AssetsController < ApplicationController

  helper_method :current_user # 使其在視圖中也可用

  def index
    @assets = Asset.all
  end

  def show
    @asset = Asset.find(params[:id])
    @asset_histories = @asset.asset_histories.order(borrowed_at: :desc)
  end

  def checkout
    @asset = Asset.find(params[:id])
    # 檢查是否有未歸還的資產
    if @asset.asset_histories.where(returned_at: nil).exists?
      respond_to do |format|
        format.html { redirect_to assets_path, alert: '該資產尚有未歸還的記錄，無法借用' }
      end
    else
      if @asset.update(status: 'CheckedOut')
        @asset.asset_histories.create(user_id: current_user.id, borrowed_at: Time.current)
        respond_to do |format|
          format.html { redirect_to assets_path, notice: '資產已借出' }
          format.js
        end
      end
    end
  end


  def checkin
    @asset = Asset.find(params[:id])
    last_history = @asset.asset_histories.where(returned_at: nil).last

    if last_history.present? && last_history.user_id == current_user.id
      if @asset.update(status: 'Available')
        last_history.update(returned_at: Time.current)
        # 成功歸還的邏輯
        respond_to do |format|
          format.html { redirect_to assets_path, notice: '資產已歸還' }
          format.js
        end
      end
    else
      # 錯誤處理，比如當前用戶不是借用人
      respond_to do |format|
        format.html { redirect_to assets_path, alert: '只有借用人才能歸還該資產' }
      end
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :description, :status)
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

end
