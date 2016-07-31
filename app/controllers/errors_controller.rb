class ErrorsController < ActionController::Base
  def not_found
    respond_to do |format|
      format.html { render :text => "404 Not found", :status => 404 }
      format.json { render json: {:error => "not-found"}.to_json, :status => :not_found }
    end
  end

  def exception
    respond_to do |format|
      format.html { render :text => "500 Internal Server Error", :status => 500 }
      format.json { render json: {:error => "internal-server-error"}.to_json, :status => 500 }
    end
  end
end