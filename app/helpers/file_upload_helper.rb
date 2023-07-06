module FileUploadHelper
  def process_icon_upload(attached_icon)
    return unless attached_icon.present?

    icon_path = Rails.root.join('app', 'assets', 'images', attached_icon.original_filename)
    File.binwrite(icon_path, attached_icon.read)
    attached_icon.original_filename
  end
end
