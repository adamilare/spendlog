module FileUploadHelper
  def process_icon_upload(attached_icon)
    return unless attached_icon.present?

    unique_basename = generate_uuid_filename(attached_icon.original_filename)
    icon_path = Rails.root.join('app', 'assets', 'images', unique_basename)
    File.binwrite(icon_path, attached_icon.read)
    unique_basename
  end

  def generate_unique_filename(filename)
    extension = File.extname(filename)
    basename = File.basename(filename, extension)
    unique_basename = "#{basename}-#{SecureRandom.hex(4)}"
    "#{unique_basename}#{extension}"
  end

  def generate_uuid_filename(filename)
    extension = File.extname(filename)

    uuid = SecureRandom.uuid
    "#{uuid}#{extension}"
  end
end
