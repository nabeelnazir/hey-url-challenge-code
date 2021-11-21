# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.latest
    options = {}
    options[:include] = [:clicks]
    respond_to do |format|
      format.json { render json: UrlSerializer.new(@urls, options).serializable_hash.to_json }
      format.html { render index: @urls }
    end
  end

  def create
    url = Url.create(url_params.merge({ short_url: Url.generate_short_url }))
    flash_object = url.id.nil? ? { notice: url.errors.full_messages } : { success: 'Success!' }
    redirect_to root_path, flash: flash_object
  end

  def show
    @daily_clicks =  short_url.clicks.daily_clicks
    @browsers_clicks = short_url.clicks.browsers_clicks
    @platform_clicks = short_url.clicks.platform_clicks
  end

  def visit
    unless short_url.present?
      return render 'errors/404', layout: false, status: :not_found
    end
    click = short_url.clicks.create(platform: browser.platform.name, browser: browser.name)
    if(click.valid?)
      short_url.increment!(:clicks_count)
      redirect_to short_url.original_url
    else
      redirect_to root_path, flash: { notice: click.erorrs.full_messages }
    end
  end

  private

  def short_url
    @url ||= Url.find_by(short_url: params[:short_url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end

end
