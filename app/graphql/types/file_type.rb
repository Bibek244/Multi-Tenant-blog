class Types::FileType < Types::BaseScalar
  description "ActionDispatch::Http::UploadedFile"

  def self.coerce_input(value, _context)
    value.is_a?(ActionDispatch::Http::UploadedFile) ? value : nil
  end
end