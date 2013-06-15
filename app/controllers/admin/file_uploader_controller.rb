# encoding: utf-8

class Admin::FileUploaderController < Admin::ApplicationController
  layout 'admin/pages'
  before_filter :authenticate_admin!
  UPLOAD_PATH = Rails.public_path + '/files'

  # GET /file_uploader/*path
  def index
    if File.directory? full_path
      # 先頭が'.'で始まるファイル名を取り除いて、一覧を作成
      @files = Dir.entries(full_path).delete_if{ |f| f =~ /^\..*$/ }.map { |e|
        stat = File::stat full_path + '/' + e
        { name: e,
          type: stat.ftype,
          size: stat.size,
          mtime: stat.mtime
        }
      }

      render 'index'
    else
      redirect_to admin_file_uploader_url, alert: '指定されたディレクトリは存在しません。'
    end
  end

  # POST /file_uploader/*path
  def upload
    f = params[:file]
    file_path = full_path + '/' + f.original_filename

    # 保存
    File.open file_path, 'wb' do |of|
      of.write f.read
    end

    if File.exists? file_path
      redirect_to admin_file_uploader_url + '/' + params[:path].to_s, notice: 'アップロードが完了しました。'
    else
      redirect_to admin_file_uploader_url + '/' + params[:path].to_s, alert: 'アップロードに失敗しました。'
    end

  rescue
    redirect_to admin_file_uploader_url + '/' + params[:path].to_s, alert: 'ファイルが指定されていないか、アップロードに失敗しました。'
  end

  # POST /file_uploader/*path/new_dir
  def new_dir
    dir_name = params[:dir_name]

    if dir_name.blank?
      redirect_to admin_file_uploader_url + '/' + params[:path].to_s, alert: 'ディレクトリ名を入力してください。'
    else
      unless File.exists? full_path + '/' + dir_name
        Dir.mkdir full_path + '/' + dir_name

        redirect_to admin_file_uploader_url + '/' + params[:path].to_s, notice: '指定されたディレクトリを作成しました。'
      else
        redirect_to admin_file_uploader_url, alert: '指定された名前のディレクトリ、もしくはファイルが既に存在します。'
      end
    end
  rescue
    redirect_to admin_file_uploader_url + '/' + params[:path].to_s, alert: '指定されたディレクトリは既に存在するか、作成に失敗しました。'
  end

  # DELETE /file_uploader/*path
  def destroy
    file_path = full_path + (params[:format] ? '.' + params[:format] : '')
    # トップディレクトリの削除は禁止
    raise if file_path == UPLOAD_PATH

    if File.directory? file_path
      Dir.delete file_path
      redirect_to admin_file_uploader_url, notice: '指定されたディレクトリを削除しました。'
    elsif File.file? file_path
      File.delete file_path
      redirect_to admin_file_uploader_url + path, notice: '指定されたファイルを削除しました。'
    else
      redirect_to admin_file_uploader_url, alert: '指定されたディレクトリまたはファイルは存在しません。'
    end
  rescue
    redirect_to admin_file_uploader_url, alert: '指定されたディレクトリまたはファイルの削除に失敗しました。'
  end

private
  def path
    (params[:path] ? '/' + params[:path] : '')
  end

  def full_path
    UPLOAD_PATH + (params[:path] ? '/' + params[:path] : '')
  end
end
