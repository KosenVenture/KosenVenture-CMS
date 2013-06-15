module Admin::FileUploaderHelper
  def file_path(file)
    if file[:type] == 'file'
      ['/files', params[:path], file[:name]].compact.join '/'
    else
      [admin_file_uploader_path, params[:path], file[:name]].compact.join('/') + '/'
    end
  end

  def admin_file_path(file)
    [admin_file_uploader_path, params[:path], file[:name]].compact.join('/') + '/'
  end

  def parent_path(current)
    if current
      a = current.split('/')
      a.pop
      a.unshift admin_file_uploader_path
      a.join('/')
    else
      admin_file_uploader_path
    end
  end
end