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
    if @asset.update(status: 'CheckedOut')
      history = @asset.asset_histories.create(user_id: current_user.id, borrowed_at: Time.current)
      Rails.logger.debug "AssetHistory errors: #{history.errors.full_messages}" unless history.persisted?
      respond_to do |format|
        format.html { redirect_to assets_path, notice: '資產已借出' }
        format.js
      end
    end
  end

  def checkin
    @asset = Asset.find(params[:id])
    # 找到最後一條借出記錄，且尚未歸還的
    last_history = @asset.asset_histories.where(returned_at: nil).last

    # 檢查是否存在一條歷史記錄，且當前用戶是該記錄的借用人
    if last_history.present? && last_history.user_id == current_user.id
      # 如果條件滿足，更新歷史記錄和資產狀態
      last_history.update(returned_at: Time.current)
      @asset.update(status: 'Available')
      notice = '資產已歸還'
    else
      # 如果不滿足，設置一個錯誤消息
      notice = '只有借用人才能歸還資產'
    end

    respond_to do |format|
      format.html { redirect_to assets_path, notice: notice }
      format.js
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
