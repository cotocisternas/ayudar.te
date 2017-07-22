class GridfsController < ApplicationController

  def serve
    gridfs_path = params[:path] + '.jpg'
    begin
      gridfs_file = Mongoid::GridFs.find(gridfs_path)
      if stale?(etag: gridfs_file.data, last_modified: Time.now.utc, public: true)
        send_data gridfs_file.data, type: gridfs_file.content_type, disposition: "inline"
        expires_in 0, public: true
      end
    rescue
      head :not_found
    end
    # begin
    #
    #   # self.response_body = gridfs_file.data
    #   # self.content_type = gridfs_file.content_type
    # rescue
    #   head :no_content
    #   # self.status = :file_not_found
    #   # self.content_type = 'text/plain'
    #   # self.response_body = ''
    # end
  end

end


# content = @user.avatar.read
#     if stale?(etag: content, last_modified: @user.updated_at.utc, public: true)
#       send_data content, type: @user.avatar.file.content_type, disposition: "inline"
#       expires_in 0, public: true
#     end
